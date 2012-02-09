Return-Path: <cyrus@holtmann.org>
Message-ID: <1328795138.28848.15.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooth: Fix double acking I-Frames when sending
 pending I-Frames
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Ulisses Furquim <ulisses@profusion.mobi>,
	kanak.gupta@stericsson.com
Date: Thu, 09 Feb 2012 14:45:38 +0100
In-Reply-To: <1328625782-19624-2-git-send-email-szymon.janc@tieto.com>
References: <1328625782-19624-1-git-send-email-szymon.janc@tieto.com>
	 <1328625782-19624-2-git-send-email-szymon.janc@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> Pending I-Frame(s) are considered as acknowledgement. To void double
> acking (via I-Frame and later via RR) clear ack timer when sending
> first pending I-Frame.
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  net/bluetooth/l2cap_core.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


