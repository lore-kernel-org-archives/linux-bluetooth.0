Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Apr 2012 19:17:00 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] Bluetooth: Remove unused hci_le_ltk_reply()
Message-ID: <20120413221700.GF1680@joana>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
 <1334243001-17016-27-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334243001-17016-27-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

* Syam Sidhardhan <s.syam@samsung.com> [2012-04-12 20:33:17 +0530]:

> In this API, we were using sizeof operator for an array
> given as function argument, which is invalid.
> However this API is not used anywhere.
> 
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 -
>  net/bluetooth/hci_conn.c         |   16 ----------------
>  2 files changed, 0 insertions(+), 17 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index c0b232c..6e170de 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1069,7 +1069,6 @@ void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
>  					u16 latency, u16 to_multiplier);
>  void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
>  							__u8 ltk[16]);
> -void hci_le_ltk_reply(struct hci_conn *conn, u8 ltk[16]);

I'll let Andre comment here, I'm not sure if this is going to be used on
the future or not.

	Gustavo
