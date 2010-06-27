Return-Path: <cyrus@holtmann.org>
Date: Sun, 27 Jun 2010 04:31:40 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com,
	sds@tycho.nsa.gov, lenb@kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/5]bluetooth:hci_bcsp Fix operation on
 'bcsp->msgq_txseq' may be undefined
Message-ID: <20100627073140.GA32575@vigoh>
References: <1277621246-10960-1-git-send-email-justinmattock@gmail.com>
 <1277621246-10960-6-git-send-email-justinmattock@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1277621246-10960-6-git-send-email-justinmattock@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Justin,

* Justin P. Mattock <justinmattock@gmail.com> [2010-06-26 23:47:26 -0700]:

> Im seeing this building the kernel with gcc 4.6.0
>  CC [M]  drivers/bluetooth/hci_bcsp.o
> drivers/bluetooth/hci_bcsp.c: In function 'bcsp_prepare_pkt':
> drivers/bluetooth/hci_bcsp.c:247:20: warning: operation on 'bcsp->msgq_txseq' may be undefined
> 
> Hopefully the below is a fix for this. Please let me know.
>  Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>
> 
> ---
>  drivers/bluetooth/hci_bcsp.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
> index 40aec0f..0f892e7 100644
> --- a/drivers/bluetooth/hci_bcsp.c
> +++ b/drivers/bluetooth/hci_bcsp.c
> @@ -182,7 +182,7 @@ static struct sk_buff *bcsp_prepare_pkt(struct bcsp_struct *bcsp, u8 *data,
>  	struct sk_buff *nskb;
>  	u8 hdr[4], chan;
>  	u16 BCSP_CRC_INIT(bcsp_txmsg_crc);
> -	int rel, i;
> +	int rel, i, ret;
>  
>  	switch (pkt_type) {
>  	case HCI_ACLDATA_PKT:
> @@ -243,8 +243,8 @@ static struct sk_buff *bcsp_prepare_pkt(struct bcsp_struct *bcsp, u8 *data,
>  
>  	if (rel) {
>  		hdr[0] |= 0x80 + bcsp->msgq_txseq;
> -		BT_DBG("Sending packet with seqno %u", bcsp->msgq_txseq);
> -		bcsp->msgq_txseq = ++(bcsp->msgq_txseq) & 0x07;
> +		BT_DBG("Sending packet with seqno %u", bcsp->msgq_txseq | ret);
> +		ret = ++(bcsp->msgq_txseq) & 0x07;
>  	}

What are trying to do here? That is completely wrong, you are losting
the next txseq to be sent.

And please do not bother the linux-bluetooth mailing list with patches
to other subsystems. Send them in a way that only Bluetooth patches will
come to linux-bluetooth.

Regards,

-- 
Gustavo F. Padovan
http://padovan.org
