Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Thu, 5 Aug 2010 00:29:03 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/9] Bluetooth:  Change default ERTM retransmit timeout.
Message-ID: <20100805032903.GD7870@vigoh>
References: <1280962146-22604-1-git-send-email-mathewm@codeaurora.org>
 <1280962146-22604-3-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280962146-22604-3-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2010-08-04 15:48:59 -0700]:

> The L2CAP spec requires that the ERTM retransmit timeout be at least 2
> seconds for BR/EDR connections.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 636724b..16e412f 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -33,7 +33,7 @@
>  #define L2CAP_DEFAULT_FLUSH_TO		0xffff
>  #define L2CAP_DEFAULT_TX_WINDOW		63
>  #define L2CAP_DEFAULT_MAX_TX		3
> -#define L2CAP_DEFAULT_RETRANS_TO	1000    /* 1 second */
> +#define L2CAP_DEFAULT_RETRANS_TO	2000    /* 2 seconds */
>  #define L2CAP_DEFAULT_MONITOR_TO	12000   /* 12 seconds */
>  #define L2CAP_DEFAULT_MAX_PDU_SIZE	672
>  #define L2CAP_DEFAULT_ACK_TO		200

The spec says that a 2 seconds retransmission timeout shall be used
after a move channel operation in a BR/EDR radio. (section 8.6.2.3)
For a normal ACL connection the default value is 1 second(section
8.6.2.1), so I prefer to keep L2CAP_DEFAULT_RETRANS_TO set to 1000.

-- 
Gustavo F. Padovan
http://padovan.org
