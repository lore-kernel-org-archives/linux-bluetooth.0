Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Oct 2011 15:19:59 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 2/5] Bluetooth: EWS: l2cap extended control field
 support
Message-ID: <20111006181959.GG5652@joana>
References: <1316180379-31607-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1316180379-31607-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316180379-31607-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-09-16 16:39:36 +0300]:

>  /* L2CAP Supervisory Function */
> -#define L2CAP_SUPER_RCV_READY           0x0000
> -#define L2CAP_SUPER_REJECT              0x0004
> -#define L2CAP_SUPER_RCV_NOT_READY       0x0008
> -#define L2CAP_SUPER_SELECT_REJECT       0x000C
> +#define L2CAP_SUPER_RR		0x00
> +#define L2CAP_SUPER_REJ		0x01
> +#define L2CAP_SUPER_RNR		0x02
> +#define L2CAP_SUPER_SREJ	0x03
>  
>  /* L2CAP Segmentation and Reassembly */
> -#define L2CAP_SDU_UNSEGMENTED       0x0000
> -#define L2CAP_SDU_START             0x4000
> -#define L2CAP_SDU_END               0x8000
> -#define L2CAP_SDU_CONTINUE          0xC000
> +#define L2CAP_SAR_UNSEGMENTED	0x00
> +#define L2CAP_SAR_START		0x01
> +#define L2CAP_SAR_END		0x02
> +#define L2CAP_SAR_CONTINUE	0x03

I want a separate patch of these macro renames. This patch is already big.

>  
>  /* L2CAP Command rej. reasons */
> -#define L2CAP_REJ_NOT_UNDERSTOOD      0x0000
> -#define L2CAP_REJ_MTU_EXCEEDED        0x0001
> -#define L2CAP_REJ_INVALID_CID         0x0002
> -
> +#define L2CAP_REJ_NOT_UNDERSTOOD	0x0000
> +#define L2CAP_REJ_MTU_EXCEEDED		0x0001
> +#define L2CAP_REJ_INVALID_CID		0x0002
>  
>  /* L2CAP structures */
>  struct l2cap_hdr {
> @@ -150,6 +168,11 @@ struct l2cap_hdr {
>  	__le16     cid;
>  } __packed;
>  #define L2CAP_HDR_SIZE		4
> +#define L2CAP_ENHANCED_HDR_SIZE	6
> +#define L2CAP_EXTENDED_HDR_SIZE	8

Use ENH and EXT instead.

> +
> +#define L2CAP_FCS_SIZE		2
> +#define L2CAP_SDULEN_SIZE	2

A separate patch for this 4 new macros as well.

	Gustavo
