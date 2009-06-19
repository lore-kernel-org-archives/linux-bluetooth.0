Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Jun 2009 16:01:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Forrest Zhao <forrest.zhao@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] fix the bug introduced by commit "re-use the
	sco_server initiated by audio plugin"
Message-ID: <20090619130138.GA14451@jh-x301>
References: <1245389422-22318-1-git-send-email-forrest.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1245389422-22318-1-git-send-email-forrest.zhao@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Forrest,

On Fri, Jun 19, 2009, Forrest Zhao wrote:
> @@ -1079,9 +1079,6 @@ int gateway_connect_sco(struct audio_device *dev, GIOChannel *io)
>  {
>  	struct gateway *gw = dev->gateway;
>  
> -	if (gw->sco)
> -		return -EISCONN;
> -
>  	gw->sco = g_io_channel_ref(io);

This part looks wrong. If gw->sco is non-NULL you'd be causing a memory
leak. Why do you think that returning -EISCONN is wrong here?

Johan
