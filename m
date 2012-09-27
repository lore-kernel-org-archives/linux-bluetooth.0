Return-Path: <cyrus@holtmann.org>
Date: Thu, 27 Sep 2012 17:48:48 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 1/3] Bluetooth: btmrvl: Correct num_block name
Message-ID: <20120927204848.GB15463@joana>
References: <1348732308-29348-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348732308-29348-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-09-27 10:51:46 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Make code readable by correcting name from buf_block_len to num_blocks
> since it represent number of blocks; NOT a length of a block buffer.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  drivers/bluetooth/btmrvl_sdio.c |   13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
> index da4df9c..25dc53b 100644
> --- a/drivers/bluetooth/btmrvl_sdio.c
> +++ b/drivers/bluetooth/btmrvl_sdio.c
> @@ -492,7 +492,7 @@ done:
>  static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
>  {
>  	u16 buf_len = 0;
> -	int ret, buf_block_len, blksz;
> +	int ret, num_blocks, blksz;
>  	struct sk_buff *skb = NULL;
>  	u32 type;
>  	u8 *payload = NULL;
> @@ -516,18 +516,17 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
>  	BT_DBG("%s buf_len %zu", hdev->name, buf_len);
>  
>  	blksz = SDIO_BLOCK_SIZE;
> -	buf_block_len = (buf_len + blksz - 1) / blksz;
> +	num_blocks = (buf_len + blksz - 1) / blksz;
>  
>  	if (buf_len <= SDIO_HEADER_LEN
> -			|| (buf_block_len * blksz) > ALLOC_BUF_SIZE) {
> +	    || (num_blocks * blksz) > ALLOC_BUF_SIZE) {
>  		BT_ERR("invalid packet length: %d", buf_len);
>  		ret = -EINVAL;
>  		goto exit;
>  	}
>  
>  	/* Allocate buffer */
> -	skb = bt_skb_alloc(buf_block_len * blksz + BTSDIO_DMA_ALIGN,
> -								GFP_ATOMIC);
> +	skb = bt_skb_alloc(num_blocks * blksz + BTSDIO_DMA_ALIGN, GFP_ATOMIC);
>  	if (skb == NULL) {
>  		BT_ERR("No free skb");
>  		goto exit;
> @@ -543,7 +542,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
>  	payload = skb->data;
>  
>  	ret = sdio_readsb(card->func, payload, card->ioport,
> -			  buf_block_len * blksz);
> +			  num_blocks * blksz);
>  	if (ret < 0) {
>  		BT_ERR("readsb failed: %d", ret);
>  		ret = -EIO;
> @@ -594,7 +593,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
>  	default:
>  		BT_ERR("Unknown packet type:%d", type);
>  		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET, payload,
> -						blksz * buf_block_len);
> +				     blksz * num_blocks);
>  
>  		kfree_skb(skb);
>  		skb = NULL;

By some reason this patch fails to apply:

Applying: Bluetooth: btmrvl: Correct num_block name
fatal: sha1 information is lacking or useless
(drivers/bluetooth/btmrvl_sdio.c).
Repository lacks necessary blobs to fall back on 3-way merge.
Cannot fall back to three-way merge.
Patch failed at 0001 Bluetooth: btmrvl: Correct num_block name

	Gustavo
