Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 2/2] bcsp: Change tx window size in configuration
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1418368478-13956-3-git-send-email-tristan@lelong.xyz>
Date: Fri, 12 Dec 2014 14:58:30 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Tristan Lelong <tlelong@adeneo-embedded.us>
Message-Id: <4DDEED41-D60D-47D0-9AB6-6FD43A0BCE0C@holtmann.org>
References: <1418368478-13956-1-git-send-email-tristan@lelong.xyz> <1418368478-13956-3-git-send-email-tristan@lelong.xyz>
To: Tristan Lelong <tristan@lelong.xyz>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tristan,

> This patch make the TX window size configurable using the kernel configuration interface.
> The default value used is the previous value: 4
> 
> Signed-off-by: Tristan Lelong <tristan@lelong.xyz>
> ---
> drivers/bluetooth/Kconfig    | 7 +++++++
> drivers/bluetooth/hci_bcsp.c | 5 +----
> 2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 364f080..9f634cb 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -59,6 +59,13 @@ config BT_HCIUART_BCSP
> 
> 	  Say Y here to compile support for HCI BCSP protocol.
> 
> +config BT_HCIUART_BCSP_WINSIZE
> +	int "BCSP reliable packet TX window size"
> +	default 4
> +	depends on BT_HCIUART_BCSP
> +	help
> +	  Defines the number of packets that can be sent before receiving a ACK.
> +

I would prefer if we get a bit more help text here.

> config BT_HCIUART_ATH3K
> 	bool "Atheros AR300x serial support"
> 	depends on BT_HCIUART
> diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
> index 142b42b..bb18f2a 100644
> --- a/drivers/bluetooth/hci_bcsp.c
> +++ b/drivers/bluetooth/hci_bcsp.c
> @@ -59,9 +59,6 @@ static u8 conf_rsp_pkt[4] = { 0xde, 0xad, 0xd0, 0xd0 };
> static u8 sync_pkt[4]     = { 0xda, 0xdc, 0xed, 0xed };
> static u8 sync_rsp_pkt[4] = { 0xac, 0xaf, 0xef, 0xee };
> 
> -
> -#define BCSP_TXWINSIZE	4
> -
> #define BCSP_PKT_LEN(data)	((data[1] >> 4) + (data[2]))
> #define BCSP_LE_PKT_LEN	0x04
> 
> @@ -331,7 +328,7 @@ static struct sk_buff *bcsp_dequeue(struct hci_uart *hu)
> 
> 	spin_lock_irqsave_nested(&bcsp->unack.lock, flags, SINGLE_DEPTH_NESTING);
> 
> -	if (bcsp->unack.qlen < BCSP_TXWINSIZE) {
> +	if (bcsp->unack.qlen < CONFIG_BT_HCIUART_BCSP_WINSIZE) {
> 		skb = skb_dequeue(&bcsp->rel);
> 		if (skb != NULL) {
> 			struct sk_buff *nskb = bcsp_prepare_pkt(bcsp, skb->data, skb->len,

This is fine with me, but we might also want to add a module parameter to allow changing it. If people want to play with it then they do not need to rebuild their module.

Another alternative is to provide an ioctl for changing it.

Regards

Marcel

