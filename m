Return-Path: <cyrus@holtmann.org>
Message-ID: <4B4C15F1.6010104@linux.intel.com>
Date: Tue, 12 Jan 2010 14:25:53 +0800
From: Zhu Yanhai <yanhai.zhu@linux.intel.com>
MIME-Version: 1.0
To: Zhu Yanhai <yanhai.zhu@linux.intel.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Don't pass down NULL path to dbus if no modem.
References: <1263276935-7456-1-git-send-email-yanhai.zhu@linux.intel.com>
In-Reply-To: <1263276935-7456-1-git-send-email-yanhai.zhu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 01/12/2010 02:15 PM, Zhu Yanhai wrote:
> We shouldn't pass down NULL object path to dbus if there's no modems,
> which is a common case on many netbooks.
> 
> Signed-off-by: Zhu Yanhai <yanhai.zhu@linux.intel.com>
> ---
>  audio/telephony-ofono.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
> index 2778cfc..4f4bf88 100644
> --- a/audio/telephony-ofono.c
> +++ b/audio/telephony-ofono.c
> @@ -574,12 +574,20 @@ static void list_modem_reply(DBusPendingCall *call, void *user_data)
>  	while (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_INVALID) {
>  
>  		dbus_message_iter_get_basic(&sub, &modem_obj_path_local);
> +		if (modem_obj_path_local == NULL)
> +			continue;
> +
>  		modem_obj_path = g_strdup(modem_obj_path_local);
> -		debug("modem_obj_path is %p, %s\n", modem_obj_path,
> +		debug("modem_obj_path is %p, %s", modem_obj_path,
>  						modem_obj_path);
>  		dbus_message_iter_next(&sub);
>  	}
>  
> +	if (modem_obj_path == NULL) {
> +		debug("no modem found.");
> +		goto done;
> +	}
> +
>  	ret = get_registration_and_signal_status();
>  	if (ret < 0)
>  		error("get_registration_and_signal_status() failed(%d)", ret);

Johan,
Please correct me if there's some coding style issues.

Thanks
Zhu Yanhai
