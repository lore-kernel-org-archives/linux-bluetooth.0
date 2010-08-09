Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 5/9] Bluetooth: Fix incorrect setting of remote_tx_win
 for L2CAP ERTM.
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <1281048867-32630-6-git-send-email-mathewm@codeaurora.org>
References: <1281048867-32630-1-git-send-email-mathewm@codeaurora.org>
	 <1281048867-32630-6-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 09 Aug 2010 04:41:48 -0400
Message-ID: <1281343308.12579.192.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> remote_tx_win is intended to be set on receipt of an L2CAP
> configuration request.  The value is used to determine the size of the
> transmit window on the remote side of an ERTM connection, so L2CAP
> can stop sending frames when that remote window is full.
> 
> An incorrect remote_tx_win value will cause the stack to not fully
> utilize the tx window (performance impact), or to overfill the remote
> tx window (causing dropped frames or a disconnect).
> 
> This patch removes an extra setting of remote_tx_win when a
> configuration response is received.  The transmit window has a
> different meaning in a response - it is an informational value
> less than or equal to the local tx_win.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)

patch has been applied. Thanks.

Regards

Marcel


