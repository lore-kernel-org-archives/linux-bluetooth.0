Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Jun 2009 18:38:49 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Forrest Zhao <forrest.zhao@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] fix the bug introduced by commit "re-use the
	sco_server initiated by audio plugin"
Message-ID: <20090619153849.GA22180@jh-x301>
References: <1245389422-22318-1-git-send-email-forrest.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1245389422-22318-1-git-send-email-forrest.zhao@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Forrest,

On Fri, Jun 19, 2009, Forrest Zhao wrote:
> --- a/audio/main.c
> +++ b/audio/main.c
> @@ -93,6 +93,10 @@ static void sco_server_cb(GIOChannel *chan, GError *err, gpointer data)
>  	device = manager_find_device(NULL, &src, &dst, AUDIO_HEADSET_INTERFACE,
>  					FALSE);
>  	if (!device)
> +		device = manager_find_device(NULL, &src, &dst,
> +						AUDIO_GATEWAY_INTERFACE, FALSE);
> +
> +	if (!device)
>  		goto drop;

I went ahead and commited this second part of your patch since it looks
correct and is good too have in before the next release (due out today).

Johan
