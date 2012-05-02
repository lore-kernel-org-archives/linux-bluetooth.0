Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 May 2012 11:38:05 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: Andre Guedes <andre.guedes@openbossa.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] Bluetooth: Remove unused hci_le_ltk_reply()
Message-ID: <20120502143805.GA4019@samus>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
 <1334243001-17016-27-git-send-email-s.syam@samsung.com>
 <20120413221700.GF1680@joana>
 <CACJA=fW=3ZHUh1r-TzDPhsxydRkDJiN62Dg4yMetw1v+i-zf_Q@mail.gmail.com>
 <689E6E1F4998496D92F8631D325F12A3@sisodomain.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <689E6E1F4998496D92F8631D325F12A3@sisodomain.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam and Johan,

On 21:18 Tue 01 May, Syam Sidhardhan wrote:
> Hi,
> ----- Original Message ----- From: "Andre Guedes"
> <andre.guedes@openbossa.org>
> To: "Gustavo Padovan" <gustavo@padovan.org>; "Syam Sidhardhan"
> <s.syam@samsung.com>; <linux-bluetooth@vger.kernel.org>; "Vinicius
> Gomes" <vinicius.gomes@openbossa.org>
> Sent: Friday, April 20, 2012 11:43 PM
> Subject: Re: [PATCH 1/5] Bluetooth: Remove unused hci_le_ltk_reply()
> 
> 
> >Hi Syam/Gustavo,
> >
> >On Fri, Apr 13, 2012 at 7:17 PM, Gustavo Padovan
> ><gustavo@padovan.org> wrote:
> >>Hi Syam,
> >>
> >>* Syam Sidhardhan <s.syam@samsung.com> [2012-04-12 20:33:17 +0530]:
> >>
> >>>In this API, we were using sizeof operator for an array
> >>>given as function argument, which is invalid.
> >>>However this API is not used anywhere.
> >>>
> >>>Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> >>>---
> >>>include/net/bluetooth/hci_core.h | 1 -
> >>>net/bluetooth/hci_conn.c | 16 ----------------
> >>>2 files changed, 0 insertions(+), 17 deletions(-)
> >>>
> >>>diff --git a/include/net/bluetooth/hci_core.h
> >>>b/include/net/bluetooth/hci_core.h
> >>>index c0b232c..6e170de 100644
> >>>--- a/include/net/bluetooth/hci_core.h
> >>>+++ b/include/net/bluetooth/hci_core.h
> >>>@@ -1069,7 +1069,6 @@ void hci_le_conn_update(struct hci_conn
> >>>*conn, u16 min, u16 max,
> >>>u16 latency, u16 to_multiplier);
> >>>void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
> >>>__u8 ltk[16]);
> >>>-void hci_le_ltk_reply(struct hci_conn *conn, u8 ltk[16]);
> >>
> >>I'll let Andre comment here, I'm not sure if this is going to be used on
> >>the future or not.
> >
> >I'm not sure too, I think Vinicius can tell more about that.

Just in case you missed what I just said on IRC: that function can be
removed.

> >
> >Regarding the memcpy call, yes, it is definitely bogus.
> >
> 
> ping
> 
> Regards,
> Syam
> 

Cheers,
-- 
Vinicius
