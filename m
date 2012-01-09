Return-Path: <cyrus@holtmann.org>
Message-ID: <1326138725.6454.162.camel@aeonflux>
Subject: Re: [PATCH 4/5] Bluetooth: Don't send RNR immediately when entering
 local busy
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Date: Mon, 09 Jan 2012 11:52:05 -0800
In-Reply-To: <1326122391-8438-5-git-send-email-szymon.janc@tieto.com>
References: <1326122391-8438-1-git-send-email-szymon.janc@tieto.com>
	 <1326122391-8438-5-git-send-email-szymon.janc@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> There is no need to send RNR immediately when entring local busy.
> Also upper layer might clear local busy condition before ack timer
> expires saving few cycles for sending RNR.
> 
> This also prevents sending two RNRs in some cases where sending one
> would be enough i.e received N I-frame can trigger local busy
> (sending RNR acking up to N-1 I-frame) and later sending ack (RNR
> acking up to N I-frame).

exactly like this please.

> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  net/bluetooth/l2cap_core.c |   15 +++++----------
>  1 files changed, 5 insertions(+), 10 deletions(-)

It does not make sense without the previous patches resend, but this
patch is fine with me.

Regards

Marcel


