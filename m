Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 4/9] Bluetooth: Fix endianness issue with L2CAP MPS
 configuration.
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <1281048867-32630-5-git-send-email-mathewm@codeaurora.org>
References: <1281048867-32630-1-git-send-email-mathewm@codeaurora.org>
	 <1281048867-32630-5-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 09 Aug 2010 04:36:09 -0400
Message-ID: <1281342969.12579.190.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Incoming configuration values must be converted to native CPU order
> before use.  This fixes a bug where a little-endian MPS value is
> compared to a native CPU value.  On big-endian processors, this
> can cause ERTM and streaming mode segmentation to produce PDUs
> that are larger than the remote stack is expecting, or that would
> produce fragmented skbs that the current FCS code cannot handle.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)

patch has been applied. Thanks.

Regards

Marcel


