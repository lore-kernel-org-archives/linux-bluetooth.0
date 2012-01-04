Return-Path: <cyrus@holtmann.org>
Message-ID: <1325691976.6454.30.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooth: l2cap_set_timer needs jiffies as timeout
 value
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Date: Wed, 04 Jan 2012 07:46:16 -0800
In-Reply-To: <1325675442-24658-3-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1325675442-24658-1-git-send-email-andrzej.kaczmarek@tieto.com>
	 <1325675442-24658-3-git-send-email-andrzej.kaczmarek@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

> After moving L2CAP timers to workqueues l2cap_set_timer expects timeout
> value to be specified in jiffies but constants defined in miliseconds
> are used. This makes timeouts unreliable when CONFIG_HZ is not set to
> 1000.
> 
> __set_chan_timer macro still uses jiffies as input to avoid multiple
> conversions from/to jiffies for sk_sndtimeo value which is already
> specified in jiffies.
> 
> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
> ---
>  include/net/bluetooth/l2cap.h |    6 +++---
>  net/bluetooth/l2cap_core.c    |   12 ++++++++----
>  2 files changed, 11 insertions(+), 7 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


