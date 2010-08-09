Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/9] Bluetooth: Change default ERTM retransmit timeout.
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <1281048867-32630-3-git-send-email-mathewm@codeaurora.org>
References: <1281048867-32630-1-git-send-email-mathewm@codeaurora.org>
	 <1281048867-32630-3-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 09 Aug 2010 04:37:41 -0400
Message-ID: <1281343061.12579.191.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> The L2CAP spec requires that the ERTM retransmit timeout be at least 2
> seconds for BR/EDR connections.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

patch has been applied. Thanks.

Regards

Marcel


