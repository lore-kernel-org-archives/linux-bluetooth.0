Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Jan 2010 08:28:20 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Zhu Yanhai <yanhai.zhu@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Don't pass down NULL path to dbus if no modem.
Message-ID: <20100113062819.GA16896@jh-x301>
References: <1263276935-7456-1-git-send-email-yanhai.zhu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1263276935-7456-1-git-send-email-yanhai.zhu@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jan 12, 2010, Zhu Yanhai wrote:
> --- a/audio/telephony-ofono.c
> +++ b/audio/telephony-ofono.c
> @@ -574,12 +574,20 @@ static void list_modem_reply(DBusPendingCall *call, void *user_data)
>  	while (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_INVALID) {
>  
>  		dbus_message_iter_get_basic(&sub, &modem_obj_path_local);
> +		if (modem_obj_path_local == NULL)
> +			continue;

dbus_message_iter_get_basic doesn't set the pointer to NULL in the case
of failure, so this check is useless. The D-Bus documentation says the
following about dbus_message_iter_get_basic:

"Be sure you have somehow checked that dbus_message_iter_get_arg_type()
matches the type you are expecting, or you'll crash when you try to use
an integer as a string or something."

You could either change the while loop condition from
"!= DBUS_TYPE_INVALID" to "== DBUS_TYPE_STRING", or if you just want to
pick the first modem in the list (which probably makes more sense than
the current method of picking the last one and leaking the path to every
modem before it) remove the loop completely and then bail out (goto
done) if the first parameter isn't a string.

In the future, please check the reference documentation instead of
guessing the usage of the API. You can find it e.g. here:
http://dbus.freedesktop.org/doc/api/html/group__DBus.html

>  		modem_obj_path = g_strdup(modem_obj_path_local);
> -		debug("modem_obj_path is %p, %s\n", modem_obj_path,
> +		debug("modem_obj_path is %p, %s", modem_obj_path,
>  						modem_obj_path);

The removal of the unnecessary newline character is good, but there are
a few other issues that are strange with this:

1. What's the value of printing the memory address of the string here?
2. Leaking modem_obj_path if it was already set

Since there are a few different issues to fix here, feel free to split
them up into separate patches (e.g. the summary of the commit message
isn't accurate anymore).

Johan
