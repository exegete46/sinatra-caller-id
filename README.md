Sign up for a [Vonage account](https://dashboard.nexmo.com/sign-up), and check the [Getting Started Guide](https://dashboard.nexmo.com/getting-started-guide) for your API Key and API Secret if you don't already have one.

You'll need to set a few environment variables to a `.env` file, using `.env.example` as a template.  Simply copy over `.env.example` to `.env`, and edit in the values for:

- `VONAGE_API_KEY`
- `VONAGE_API_SECRET`
- `VONAGE_SMS_FROM` - A valid Vonage phone number to send from.

If you're following along with the tutorial out check out the `start-here` branch

```bash
$ git clone git@github.com:ChrisGuzman/sinatra-caller-id.git

$ cd sinatra-caller-id/

$ bundle install

$ bundle exec ruby app.rb
```

If you would like to see the SMS message generated after a successful async call, this application will need to be accessed via a public URL.  This is required for Vonage to call back into your service with a response.  Services such as [ngrok](https://ngrok.com) may help with this.
