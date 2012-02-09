Return-Path: <cyrus@holtmann.org>
Message-ID: <1328795085.28848.14.camel@aeonflux>
Subject: Re: [PATCH 1/2] Bluetooth: Fix possible missing I-Frame
 acknowledgement
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Ulisses Furquim <ulisses@profusion.mobi>,
	kanak.gupta@stericsson.com
Date: Thu, 09 Feb 2012 14:44:45 +0100
In-Reply-To: <1328625782-19624-1-git-send-email-szymon.janc@tieto.com>
References: <1328625782-19624-1-git-send-email-szymon.janc@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> Make l2cap_ertm_send return number of pending I-Frames transmitted
> instead of all (pending + retransmitted) I-Frames transmitted.
> 
> As only pending I-Frames are considered as acknowledgement, this could
> lead to situation when no ACK was sent in __l2cap_send_ack (if only
> already transmitted I-Frames were retransmitted).
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  net/bluetooth/l2cap_core.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


