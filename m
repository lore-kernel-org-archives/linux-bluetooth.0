Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Jan 2010 15:53:25 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Zhu Yanhai <yanhai.zhu@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Don't pass down NULL path to dbus if no modem.
Message-ID: <20100111135325.GA10569@jh-x301>
References: <1263195386-15072-1-git-send-email-yanhai.zhu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1263195386-15072-1-git-send-email-yanhai.zhu@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Jan 11, 2010, Zhu Yanhai wrote:
> index 2778cfc..2970e43 100644
> --- a/audio/telephony-ofono.c
> +++ b/audio/telephony-ofono.c
> @@ -579,6 +579,11 @@ static void list_modem_reply(DBusPendingCall *call, void *user_data)
>  						modem_obj_path);
>  		dbus_message_iter_next(&sub);
>  	}
> +	if (modem_obj_path == NULL)
> +	{
> +		debug("no modem found.\n");	
> +		goto done;
> +	}

Functionally the patch seems fine, but could you fix a few coding style
issues please:

 * empty line before the if-statement
 * opening { on the same line as the if statement
 * no \n in the debug statement (that gets added automatically).
 * Remove whitespace from the end of the debug line (right now you have
   a tab after the semicolon)

Johan
