Return-Path: <cyrus@holtmann.org>
Date: Mon, 28 Jun 2010 10:12:30 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-bluetooth@vger.kernel.org, justinmattock@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix abuse of the preincrement operator
Message-ID: <20100628131058.GA25275@vigoh>
References: <1277621246-10960-6-git-send-email-justinmattock@gmail.com>
 <20100628125752.8945.50572.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100628125752.8945.50572.stgit@warthog.procyon.org.uk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

* David Howells <dhowells@redhat.com> [2010-06-28 13:57:52 +0100]:

> Fix abuse of the preincrement operator as detected when building with gcc
> 4.6.0:
> 
> 	 CC [M]  drivers/bluetooth/hci_bcsp.o
> 	drivers/bluetooth/hci_bcsp.c: In function 'bcsp_prepare_pkt':
> 	drivers/bluetooth/hci_bcsp.c:247:20: warning: operation on 'bcsp->msgq_txseq' may be undefined
> 
> Reported-by: Justin P. Mattock <justinmattock@gmail.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  drivers/bluetooth/hci_bcsp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
> index 40aec0f..42d69d4 100644
> --- a/drivers/bluetooth/hci_bcsp.c
> +++ b/drivers/bluetooth/hci_bcsp.c
> @@ -244,7 +244,7 @@ static struct sk_buff *bcsp_prepare_pkt(struct bcsp_struct *bcsp, u8 *data,
>  	if (rel) {
>  		hdr[0] |= 0x80 + bcsp->msgq_txseq;
>  		BT_DBG("Sending packet with seqno %u", bcsp->msgq_txseq);
> -		bcsp->msgq_txseq = ++(bcsp->msgq_txseq) & 0x07;
> +		bcsp->msgq_txseq = (bcsp->msgq_txseq + 1) & 0x07;
>  	}
>  
>  	if (bcsp->use_crc)
> 

Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

-- 
Gustavo F. Padovan
http://padovan.org
