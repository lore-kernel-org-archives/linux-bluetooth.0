Return-Path: <cyrus@holtmann.org>
Message-ID: <1325691896.6454.28.camel@aeonflux>
Subject: Re: [PATCH 1/2] Bluetooth: Fix sk_sndtimeo initialization for L2CAP
 socket
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Date: Wed, 04 Jan 2012 07:44:56 -0800
In-Reply-To: <1325675442-24658-2-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1325675442-24658-1-git-send-email-andrzej.kaczmarek@tieto.com>
	 <1325675442-24658-2-git-send-email-andrzej.kaczmarek@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

> sk_sndtime value should be specified in jiffies thus initial value
> needs to be converted from miliseconds. Otherwise this timeout is
> unreliable when CONFIG_HZ is not set to 1000.
> 
> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
> ---
>  net/bluetooth/l2cap_sock.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


