Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Mar 2013 16:51:32 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org,
	marcel@holtmann.org
Subject: Re: [PATCH 5/6] Agent's DisplayPasskey implementation
Message-ID: <20130314195132.GD2649@samus>
References: <1363285326-20089-1-git-send-email-deymo@chromium.org>
 <1363285326-20089-6-git-send-email-deymo@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363285326-20089-6-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,


On 11:22 Thu 14 Mar, Alex Deymo wrote:
> Implements the DisplayPasskey(object device, uint32 passkey, uint16 entered)
> method.
> ---
>  client/agent.c   | 30 ++++++++++++++++++++++++++++++
>  client/display.h |  2 ++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/client/agent.c b/client/agent.c
> index 579ae4e..cb710da 100644
> --- a/client/agent.c
> +++ b/client/agent.c
> @@ -184,6 +184,32 @@ static DBusMessage *display_pincode(DBusConnection *conn,
>  	return dbus_message_new_method_return(msg);
>  }
>  
> +static DBusMessage *display_passkey(DBusConnection *conn,
> +					DBusMessage *msg, void *user_data)
> +{
> +	const char *device;
> +	dbus_uint32_t passkey;
> +	dbus_uint16_t entered;
> +	char passkey_entered[7];
> +	char passkey_remaining[7];
> +
> +	dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &device,
> +			DBUS_TYPE_UINT32, &passkey, DBUS_TYPE_UINT16, &entered,
> +							DBUS_TYPE_INVALID);
> +
> +	snprintf(passkey_entered, 7, "%.6u", passkey);
> +	passkey_entered[6] = '\0';
> +	strncpy(passkey_remaining, passkey_entered, 7);
> +	if (entered > strlen(passkey_entered))
> +		entered = strlen(passkey_entered);
> +	passkey_entered[entered] = '\0';

Some empty lines in this block please.

> +
> +	rl_printf(AGENT_PROMPT "Passkey: " COLOR_BOLDGRAY "%s" COLOR_BOLDWHITE
> +		"%s\n" COLOR_OFF, passkey_entered, passkey_remaining+entered);
> +
> +	return dbus_message_new_method_return(msg);
> +}
> +
>  static DBusMessage *request_confirmation(DBusConnection *conn,
>  					DBusMessage *msg, void *user_data)
>  {
> @@ -262,6 +288,10 @@ static const GDBusMethodTable methods[] = {
>  	{ GDBUS_METHOD("DisplayPinCode",
>  			GDBUS_ARGS({ "device", "o" }, { "pincode", "s" }),
>  			NULL, display_pincode) },
> +	{ GDBUS_METHOD("DisplayPasskey",
> +			GDBUS_ARGS({ "device", "o" }, { "passkey", "u" },
> +							{ "entered", "q" }),
> +			NULL, display_passkey) },
>  	{ GDBUS_ASYNC_METHOD("RequestConfirmation",
>  			GDBUS_ARGS({ "device", "o" }, { "passkey", "u" }),
>  			NULL, request_confirmation) },
> diff --git a/client/display.h b/client/display.h
> index 957bdc6..91a0be9 100644
> --- a/client/display.h
> +++ b/client/display.h
> @@ -26,5 +26,7 @@
>  #define COLOR_GREEN	"\x1B[0;92m"
>  #define COLOR_YELLOW	"\x1B[0;93m"
>  #define COLOR_BLUE	"\x1B[0;94m"
> +#define COLOR_BOLDGRAY	"\x1B[1;30m"
> +#define COLOR_BOLDWHITE	"\x1B[1;37m"
>  
>  void rl_printf(const char *fmt, ...) __attribute__((format(printf, 1, 2)));
> -- 
> 1.8.1.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
