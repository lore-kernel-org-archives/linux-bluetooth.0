Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 Jul 2009 17:47:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] gstreamer a2dp as marginal plugin
Message-ID: <20090703144723.GA19203@jh-x301>
References: <1246446957-15477-1-git-send-email-filippo@esaurito.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1246446957-15477-1-git-send-email-filippo@esaurito.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Filippo,

On Wed, Jul 01, 2009, Filippo Giunchedi wrote:
> This patch avoids taking over the default output sink by registering a2dp as
> RANK_MARGINAL.
> I'm not sure this is desiderable in general but at least autoaudiosink does the
> right thing and selects ALSA/OSS which are RANK_PRIMARY.
> 
> Filippo Giunchedi (1):
>   Register the a2dp gst sink as marginal
> 
>  audio/gsta2dpsink.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

This one has been pushed upstream too.

Johan
