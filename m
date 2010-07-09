Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 Jul 2010 13:45:06 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix signal strength for HFP in maemo6 telephony due to
 changed API in libcsnet.
Message-ID: <20100709164506.GA18973@vigoh>
References: <1278686657-6997-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1278686657-6997-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

* Dmitriy Paliy <dmitriy.paliy@nokia.com> [2010-07-09 17:44:17 +0300]:

> Signed-off-by: Dmitriy Paliy <dmitriy.paliy@nokia.com>

No need for Signed-off-by line on userspace code.

> ---
>  audio/telephony-maemo6.c |   50 +++++++++++++++++++++------------------------
>  1 files changed, 23 insertions(+), 27 deletions(-)
> 
> diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
> index 31704c3..da3c19a 100644
> --- a/audio/telephony-maemo6.c
> +++ b/audio/telephony-maemo6.c

Looks you are doing at least 3 differents things in the same patch.
Changing the variables names, changing the o DBus interface and your
fixes. Split it in a proper atomic patches then we can figure out what
you are doing.

> @@ -134,11 +134,12 @@ struct csd_call {
>  static struct {
>  	char *operator_name;
>  	uint8_t status;
> -	int32_t signals_bar;
> +	int32_t signal_bars;
>  } net = {
>  	.operator_name = NULL,
>  	.status = NETWORK_REG_STATUS_UNKOWN,
> -	.signals_bar = 0,
> +	.signal_bars = 0,	/* Init as 0 meaning inactive mode. In modem power off state it can */
> +				/* be -1, but we treat all values as 0s regardless inactive or power off. */
>  };
>  
>  static int get_property(const char *iface, const char *prop);
> @@ -181,7 +182,7 @@ static guint create_request_timer = 0;
>  static struct indicator maemo_indicators[] =
>  {
>  	{ "battchg",	"0-5",	5,	TRUE },
> -	{ "signal",	"0-5",	0,	TRUE },
> +	{ "signal",	"0-5",	0,	TRUE },			/* signal strength in terms of bars */
>  	{ "service",	"0,1",	0,	TRUE },
>  	{ "call",	"0,1",	0,	TRUE },
>  	{ "callsetup",	"0-3",	0,	TRUE },
> @@ -1227,43 +1228,38 @@ static void handle_registration_changed(DBusMessage *msg)
>  	update_registration_status(status);
>  }
>  
> -static void update_signal_strength(int32_t signals_bar)
> +static void update_signal_strength(int32_t signal_strength_bars)
>  {
> -	int signal;
> -
> -	if (signals_bar < 0)
> -		signals_bar = 0;
> -	else if (signals_bar > 100) {
> -		DBG("signals_bar greater than expected: %u", signals_bar);
> -		signals_bar = 100;
> +	if (signal_strength_bars < 0) {
> +		DBG("signal strength bars smaller than expected: %d", signal_strength_bars);
> +		signal_strength_bars = 0;
> +	} else if (signal_strength_bars > 5) {
> +		DBG("signal strength bars greater than expected: %d", signal_strength_bars);
> +		signal_strength_bars = 5;
>  	}

Do you really need these DBG() here?

>  
> -	if (net.signals_bar == signals_bar)
> +	if (net.signal_bars == signal_strength_bars)
>  		return;
>  
> -	/* A simple conversion from 0-100 to 0-5 (used by HFP) */
> -	signal = (signals_bar + 20) / 21;
> -
> -	telephony_update_indicator(maemo_indicators, "signal", signal);
> +	telephony_update_indicator(maemo_indicators, "signal", signal_strength_bars);
>  
> -	net.signals_bar = signals_bar;
> +	net.signal_bars = signal_strength_bars;
>  
> -	DBG("telephony-maemo6: signal strength updated: %u/100, %d/5", signals_bar, signal);

Don't overstep line 80.

> +	DBG("telephony-maemo6: signal strength bars updated: %d/5", signal_strength_bars);
>  }
>  
> -static void handle_signal_strength_changed(DBusMessage *msg)
> +static void handle_signal_bars_changed(DBusMessage *msg)
>  {
> -	int32_t signals_bar, rssi_in_dbm;
> +	int32_t signal_bars;
>  
>  	if (!dbus_message_get_args(msg, NULL,
> -					DBUS_TYPE_INT32, &signals_bar,
> -					DBUS_TYPE_INT32, &rssi_in_dbm,


What happened to rssi_in_dbm? Why are you removing it?


> +					DBUS_TYPE_INT32, &signal_bars,
>  					DBUS_TYPE_INVALID)) {
> -		error("Unexpected parameters in SignalStrengthChanged");
> +		error("Unexpected parameters in SignalBarsChanged");
>  		return;
>  	}
>  
> -	update_signal_strength(signals_bar);
> +	update_signal_strength(signal_bars);
>  }
>  
>  static gboolean iter_get_basic_args(DBusMessageIter *iter,
> @@ -1530,7 +1526,7 @@ static void get_property_reply(DBusPendingCall *call, void *user_data)
>  		dbus_message_iter_get_basic(&sub, &name);
>  		update_operator_name(name);
>  	} else if (g_strcmp0(prop, "SignalBars") == 0) {
> -		uint32_t signal_bars;
> +		int32_t signal_bars;
>  
>  		dbus_message_iter_get_basic(&sub, &signal_bars);
>  		update_signal_strength(signal_bars);
> @@ -1899,8 +1895,8 @@ static DBusHandlerResult signal_filter(DBusConnection *conn,
>  				"OperatorNameChanged"))
>  		handle_operator_name_changed(msg);
>  	else if (dbus_message_is_signal(msg, CSD_CSNET_SIGNAL,
> -				"SignalStrengthChanged"))
> -		handle_signal_strength_changed(msg);
> +				"SignalBarsChanged"))
> +		handle_signal_bars_changed(msg);
>  	else if (dbus_message_is_signal(msg, "org.freedesktop.Hal.Device",
>  					"PropertyModified"))
>  		handle_hal_property_modified(msg);
> -- 
> 1.7.0.4
> 

-- 
Gustavo F. Padovan
http://padovan.org
