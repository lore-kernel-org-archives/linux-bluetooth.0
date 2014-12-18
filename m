Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [RFC 1/2] Bluetooth: 6lowpan: Add IPSP PSM value
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1418905432-19793-2-git-send-email-jukka.rissanen@linux.intel.com>
Date: Thu, 18 Dec 2014 17:26:43 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <252F0925-4F61-4E1A-A2C8-F79B115476DE@holtmann.org>
References: <1418905432-19793-1-git-send-email-jukka.rissanen@linux.intel.com> <1418905432-19793-2-git-send-email-jukka.rissanen@linux.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> The Internet Protocol Support Profile a.k.a BT 6LoWPAN spesification
> is ready so PSM value for it is now known.
> 
> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
> include/net/bluetooth/l2cap.h | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index eee3ef5..f71644f 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -248,6 +248,7 @@ struct l2cap_conn_rsp {
> #define L2CAP_PSM_SDP		0x0001
> #define L2CAP_PSM_RFCOMM	0x0003
> #define L2CAP_PSM_3DSP		0x0021
> +#define L2CAP_PSM_LE_PSM_IPSP	0x0023 /* 6LoWPAN */

as long as LE and BR/EDR does not overlap, lets keep this simple. So L2CAP_PSM_IPSP.

Regards

Marcel

