Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 9/9] Bluetooth: Use 3-DH5 payload size for default ERTM
 max PDU size.
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <1281048867-32630-10-git-send-email-mathewm@codeaurora.org>
References: <1281048867-32630-1-git-send-email-mathewm@codeaurora.org>
	 <1281048867-32630-10-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 09 Aug 2010 04:44:06 -0400
Message-ID: <1281343446.12579.193.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> The previous value of 672 for L2CAP_DEFAULT_MAX_PDU_SIZE is based on
> the default L2CAP MTU.  That default MTU is calculated from the size
> of two DH5 packets, minus ACL and L2CAP b-frame header overhead.
> 
> ERTM is used with newer basebands that typically support larger 3-DH5
> packets, and i-frames and s-frames have more header overhead.  With
> clean RF conditions, basebands will typically attempt to use 1021-byte
> 3-DH5 packets for maximum throughput.  Adjusting for 2 bytes of ACL
> headers plus 10 bytes of worst-case L2CAP headers yields 1009 bytes
> of payload.
> 
> This PDU size imposes less overhead for header bytes and gives the
> baseband the option to choose 3-DH5 packets, but is small enough for
> ERTM traffic to interleave well with other L2CAP or SCO data.
> 672-byte payloads do not allow the most efficient over-the-air
> packet choice, and cannot achieve maximum throughput over BR/EDR.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

patch has been applied. Thanks.

Regards

Marcel


