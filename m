Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Jul 2011 11:43:01 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: ilia.kolominsky@gmail.com
Cc: linux-bluetooth@vger.kernel.org, Ilia Kolomisnky <iliak@ti.com>
Subject: Re: [PATCH] Bluetooth-next: Fixes l2cap "command reject" reply
 according to spec.
Message-ID: <20110706144301.GA7786@joana>
References: <1309676174-20157-1-git-send-email-iliak@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309676174-20157-1-git-send-email-iliak@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilia,

I may have missed this patch, sorry.

* ilia.kolominsky@gmail.com <ilia.kolominsky@gmail.com> [2011-07-03 09:56:14 +0300]:

> From: Ilia Kolomisnky <iliak@ti.com>
> 
> There can 3 reasons for the "command reject" reply produced
> by the stack. Each such reply should be accompanied by the
> relevand data ( as defined in spec. ). Currently there is one
> instance of "command reject" reply with reason "invalid cid"
> wich is fixed. Also, added clean-up definitions related to the
> "command reject" replies.
> 
> Signed-off-by: Ilia Kolomisnky <iliak@ti.com>
> ---
>  include/net/bluetooth/l2cap.h |   19 ++++++++++++++++++-
>  net/bluetooth/l2cap_core.c    |   15 +++++++++------
>  2 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 9c18e55..6dee791 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -130,6 +130,12 @@ struct l2cap_conninfo {
>  #define L2CAP_SDU_END               0x8000
>  #define L2CAP_SDU_CONTINUE          0xC000
>  
> +/* L2CAP Command rej. reasons */
> +#define L2CAP_CMD_NOT_UNDERSTOOD      0x0000
> +#define L2CAP_CMD_MTU_EXCEEDED	       0x0001

s/CMD/REJ

> +#define L2CAP_CMD_INV_CID             0x0002

#define L2CAP_REJ_INVALID_CID

> +
> +
>  /* L2CAP structures */
>  struct l2cap_hdr {
>  	__le16     len;
> @@ -144,8 +150,19 @@ struct l2cap_cmd_hdr {
>  } __packed;
>  #define L2CAP_CMD_HDR_SIZE	4
>  
> -struct l2cap_cmd_rej {
> +struct l2cap_cmd_rej_unk {
> +	__le16     reason;
> +} __packed;
> +
> +struct l2cap_cmd_rej_mtu {
> +	__le16     reason;
> +	__le16     max_mtu;
> +} __packed;
> +
> +struct l2cap_cmd_rej_cid {
>  	__le16     reason;
> +	__le16     loc_cid;
> +	__le16     rem_cid;

call theses scid and dcid.

	Gustavo
