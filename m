Return-Path: <cyrus@holtmann.org>
Message-ID: <1326138778.6454.163.camel@aeonflux>
Subject: Re: [PATCH 5/5] Bluetooth: Drop L2CAP chan reference if ERTM
 ack_timer fired
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Date: Mon, 09 Jan 2012 11:52:58 -0800
In-Reply-To: <1326122391-8438-6-git-send-email-szymon.janc@tieto.com>
References: <1326122391-8438-1-git-send-email-szymon.janc@tieto.com>
	 <1326122391-8438-6-git-send-email-szymon.janc@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> Reference counter was incremented when starting ack timer but
> decremented only when clearing timer, not when timer fired.
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  net/bluetooth/l2cap_core.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


