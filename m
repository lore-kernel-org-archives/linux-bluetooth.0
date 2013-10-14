Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] gdbus: Check for NULL DBusPendingCall in g_dbus_send_message_with_reply
Date: Mon, 14 Oct 2013 10:12:56 +0200
Message-ID: <1996678.hfgLy9qM2S@uw000953>
In-Reply-To: <1380182555-11609-1-git-send-email-szymon.janc@tieto.com>
References: <1380182555-11609-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> From D-Bus documentation for dbus_connection_send_with_reply():
> "Warning: if the connection is disconnected or you try to send Unix file
> descriptors on a connection that does not support them, the
> DBusPendingCall will be set to NULL, so be careful with this."
> 
> Check this in g_dbus_send_message_with_reply so that callers don't need
> to double check for NULL if g_dbus_send_message_with_reply returned
> TRUE.
> 
> This also fix crash if passing FD over D-Bus is blocked e.g. by SELinux
> policy.
> 
> bluetoothd[1894]: profiles/audio/avdtp.c:session_cb()
> bluetoothd[1894]: profiles/audio/avdtp.c:avdtp_parse_cmd() Received
>     SET_CONFIGURATION_CMD
> bluetoothd[1894]: profiles/audio/a2dp.c:endpoint_setconf_ind() Source
>     0x6c5000: Set_Configuration_Ind
> bluetoothd[1894]: profiles/audio/avdtp.c:avdtp_ref() 0x6df360: ref=1
> bluetoothd[1894]: profiles/audio/a2dp.c:setup_ref() 0x6d32b0: ref=1
> process 1894: arguments to dbus_pending_call_set_notify() were incorrect,
>      assertion "pending != NULL" failed in file dbus-pending-call.c line
>      636.
> This is normally a bug in some application using the D-Bus library.
> ---
>  gdbus/object.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/gdbus/object.c b/gdbus/object.c
> index 0822fe8..268fed5 100644
> --- a/gdbus/object.c
> +++ b/gdbus/object.c
> @@ -1510,11 +1510,20 @@ gboolean g_dbus_send_message_with_reply(DBusConnection *connection,
>  					DBusMessage *message,
>  					DBusPendingCall **call, int timeout)
>  {
> +	dbus_bool_t ret;
> +
>  	/* Flush pending signal to guarantee message order */
>  	g_dbus_flush(connection);
>  
> -	return dbus_connection_send_with_reply(connection, message, call,
> +	ret = dbus_connection_send_with_reply(connection, message, call,
>  								timeout);
> +
> +	if (ret == TRUE && call != NULL && *call == NULL) {
> +		error("Unable to send message (passing fd blocked?)");
> +		return FALSE;
> +	}
> +
> +	return ret;
>  }
>  
>  gboolean g_dbus_send_error_valist(DBusConnection *connection,
> 

ping


