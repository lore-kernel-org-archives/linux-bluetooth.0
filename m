Return-Path: <cyrus@holtmann.org>
Message-ID: <4A49C2CD.2060207@jts-sro.sk>
Date: Tue, 30 Jun 2009 09:46:21 +0200
From: Martin Sucha <martin.sucha@jts-sro.sk>
MIME-Version: 1.0
To: Forrest Zhao <forrest.zhao@intel.com>
CC: linux-bluetooth@vger.kernel.org, forrest.zhao@gmail.com
Subject: Re: [PATCH] fix bugs in HFP HF role audio part
References: <1246346181-25864-1-git-send-email-forrest.zhao@intel.com>
In-Reply-To: <1246346181-25864-1-git-send-email-forrest.zhao@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Forrest,

> @@ -1137,7 +1142,11 @@ gboolean gateway_request_stream(struct audio_device *dev,
>  	GError *err = NULL;
>  	GIOChannel *io;
>  
> -	if (!gw->sco) {
> +	if (!gw->rfcomm) {
> +		gw->sco_start_cb = cb;
> +		gw->sco_start_cb_data = user_data;
> +		get_records(dev);
> +	} else if (!gw->sco) {
>  		if (!gw->rfcomm)
>  			return FALSE;
It seems that this return FALSE statement would never be reached. Is
it left there intentionally?

Regards

Martin Sucha
