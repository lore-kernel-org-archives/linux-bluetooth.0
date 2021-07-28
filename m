Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4289BC432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 00:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DDE160E9B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 00:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbhG1Alo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jul 2021 20:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbhG1Aln (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jul 2021 20:41:43 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BCEC061764
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 17:41:43 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id v46so1087956ybi.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 17:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sj+A4wU1QLkj4wHdbWMn3kvuqK7zOyIN+pX68hpsamI=;
        b=PryTSGSVBlf8UrrCgRrtr6hPnJ4NAzCdHn9OXsk5s2Mkr2zRhoTLwzKboH4Qa3rnf+
         6oek1/RxxKfM0jpN+5V93/sS7pLDtaX4/+jv89Ce7cE0DX5z7JB3VPOX0tP0OdJ/1ivW
         pSkEQdcvhLTAvywjT03msoWeZu0PLXcn/ma4YFWVhmp3b0Y9EY5rHkoCAMlxUOIw49i8
         sav6NtPoJUD40gis9ap9jREzC53iJCd86nfhvZqK1h/JJFDEW7mP+FMe1XberGSp1KHs
         aOwJvlmUFhAw4hcFY7z0pxIWvl62Y9V9sRlJLjCbr7XzOF4QJqtgBQq5TOVQVoZpjitF
         K2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sj+A4wU1QLkj4wHdbWMn3kvuqK7zOyIN+pX68hpsamI=;
        b=KS5J4dmiMQuuSKMyi6Fdp1hpDsquDJNPEf/nUb0xddle3jDoehkXtrIqQB3NIcORRs
         CbtalGnRBb2IMBDeV7gW9fs8XExBECmxQ8RzUpSFsu+ffefm/XBFc8cRbuqi4iq0xP5L
         BBxY3usSpb0raRmHPJ/yzhonSogp+VhsVnTIoKKDttnABIOjE493NK1XJk/ZdEcuzHd2
         p0BLsZDkuW0oROpa1gaZ8u3goxcM0dY0HVRbis1RmipvGoehgmDf0mrRHAjZbkBtGUJb
         v8/kJM4yfy6Jb3Te2ElEN3sgHw6cC4WXeaTIn8xmbEsOdHcRh4Sg/CNLrw/i6orgx6b/
         6nOA==
X-Gm-Message-State: AOAM531nGOLIOzDz/KhO0uDJjOdn5vt8A/9ETlYgAU8PJtISPXfIXKKm
        73v+bZc1TNzwmcE2mscN0UNPnKwdcyVzeRURmYU=
X-Google-Smtp-Source: ABdhPJwJB9osVedCMhJRKCT45Wx0CCE2ulZq7q43v1suKJ1gsSQJq+4xXk0bTIZa0wsJLpm5L/qWMSwTuBaHM5DeIOk=
X-Received: by 2002:a25:7e86:: with SMTP id z128mr34852741ybc.222.1627432902218;
 Tue, 27 Jul 2021 17:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210727235127.173149-1-hj.tedd.an@gmail.com> <20210727235127.173149-2-hj.tedd.an@gmail.com>
In-Reply-To: <20210727235127.173149-2-hj.tedd.an@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 27 Jul 2021 17:41:31 -0700
Message-ID: <CABBYNZJEQ+aqyUx_6zY5db4F_VPV4dPVN0QjoGhrHvpqHrj=3Q@mail.gmail.com>
Subject: Re: [RFC PATCH v4 01/11] Bluetooth: Add support hdev to allocate
 private data
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Tue, Jul 27, 2021 at 4:53 PM Tedd Ho-Jeong An <hj.tedd.an@gmail.com> wrote:
>
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> This patch adds support hdev to allocate extra size for private data.
> The size of private data is specified in the hdev_alloc_size(priv_size)
> and the allocated buffer can be accessed with hci_get_priv(hdev).
>
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
>  drivers/bluetooth/bfusb.c        |  2 +-
>  drivers/bluetooth/bluecard_cs.c  |  2 +-
>  drivers/bluetooth/bpa10x.c       |  2 +-
>  drivers/bluetooth/bt3c_cs.c      |  2 +-
>  drivers/bluetooth/btmrvl_main.c  |  2 +-
>  drivers/bluetooth/btmtksdio.c    |  2 +-
>  drivers/bluetooth/btmtkuart.c    |  2 +-
>  drivers/bluetooth/btqcomsmd.c    |  2 +-
>  drivers/bluetooth/btrsi.c        |  2 +-
>  drivers/bluetooth/btsdio.c       |  2 +-
>  drivers/bluetooth/btusb.c        |  2 +-
>  drivers/bluetooth/dtl1_cs.c      |  2 +-
>  drivers/bluetooth/hci_ldisc.c    |  2 +-
>  drivers/bluetooth/hci_serdev.c   |  2 +-
>  drivers/bluetooth/hci_vhci.c     |  2 +-
>  drivers/bluetooth/virtio_bt.c    |  2 +-
>  include/net/bluetooth/hci_core.h |  7 ++++++-
>  net/bluetooth/hci_core.c         | 11 +++++++++--
>  18 files changed, 31 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
> index 5a321b4076aa..430e230999fa 100644
> --- a/drivers/bluetooth/bfusb.c
> +++ b/drivers/bluetooth/bfusb.c
> @@ -651,7 +651,7 @@ static int bfusb_probe(struct usb_interface *intf, const struct usb_device_id *i
>         release_firmware(firmware);
>
>         /* Initialize and register HCI device */
> -       hdev = hci_alloc_dev();
> +       hdev = hci_alloc_dev(0);
>         if (!hdev) {
>                 BT_ERR("Can't allocate HCI device");
>                 goto done;
> diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
> index 36eabf61717f..d62b878aff7e 100644
> --- a/drivers/bluetooth/bluecard_cs.c
> +++ b/drivers/bluetooth/bluecard_cs.c
> @@ -694,7 +694,7 @@ static int bluecard_open(struct bluecard_info *info)
>         info->rx_skb = NULL;
>
>         /* Initialize HCI device */
> -       hdev = hci_alloc_dev();
> +       hdev = hci_alloc_dev(0);
>         if (!hdev) {
>                 BT_ERR("Can't allocate HCI device");
>                 return -ENOMEM;
> diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
> index 1fa58c059cbf..bd670352a336 100644
> --- a/drivers/bluetooth/bpa10x.c
> +++ b/drivers/bluetooth/bpa10x.c
> @@ -380,7 +380,7 @@ static int bpa10x_probe(struct usb_interface *intf,
>         init_usb_anchor(&data->tx_anchor);
>         init_usb_anchor(&data->rx_anchor);
>
> -       hdev = hci_alloc_dev();
> +       hdev = hci_alloc_dev(0);
>         if (!hdev)
>                 return -ENOMEM;
>
> diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
> index 54713833951a..cd135a736688 100644
> --- a/drivers/bluetooth/bt3c_cs.c
> +++ b/drivers/bluetooth/bt3c_cs.c
> @@ -550,7 +550,7 @@ static int bt3c_open(struct bt3c_info *info)
>         info->rx_skb = NULL;
>
>         /* Initialize HCI device */
> -       hdev = hci_alloc_dev();
> +       hdev = hci_alloc_dev(0);
>         if (!hdev) {
>                 BT_ERR("Can't allocate HCI device");
>                 return -ENOMEM;
> diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
> index 8b9d78ce6bb2..0157fa4ce528 100644
> --- a/drivers/bluetooth/btmrvl_main.c
> +++ b/drivers/bluetooth/btmrvl_main.c
> @@ -680,7 +680,7 @@ int btmrvl_register_hdev(struct btmrvl_private *priv)
>         struct btmrvl_sdio_card *card = priv->btmrvl_dev.card;
>         int ret;
>
> -       hdev = hci_alloc_dev();
> +       hdev = hci_alloc_dev(0);
>         if (!hdev) {
>                 BT_ERR("Can not allocate HCI device");
>                 goto err_hdev;
> diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
> index 9872ef18f9fe..b48aec25c09d 100644
> --- a/drivers/bluetooth/btmtksdio.c
> +++ b/drivers/bluetooth/btmtksdio.c
> @@ -959,7 +959,7 @@ static int btmtksdio_probe(struct sdio_func *func,
>         skb_queue_head_init(&bdev->txq);
>
>         /* Initialize and register HCI device */
> -       hdev = hci_alloc_dev();
> +       hdev = hci_alloc_dev(0);
>         if (!hdev) {
>                 dev_err(&func->dev, "Can't allocate HCI device\n");
>                 return -ENOMEM;
> diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
> index e9d91d7c0db4..96ee364507c5 100644
> --- a/drivers/bluetooth/btmtkuart.c
> +++ b/drivers/bluetooth/btmtkuart.c
> @@ -987,7 +987,7 @@ static int btmtkuart_probe(struct serdev_device *serdev)
>         skb_queue_head_init(&bdev->txq);
>
>         /* Initialize and register HCI device */
> -       hdev = hci_alloc_dev();
> +       hdev = hci_alloc_dev(0);
>         if (!hdev) {
>                 dev_err(&serdev->dev, "Can't allocate HCI device\n");
>                 return -ENOMEM;
> diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
> index 2acb719e596f..47aaffceb8c1 100644
> --- a/drivers/bluetooth/btqcomsmd.c
> +++ b/drivers/bluetooth/btqcomsmd.c
> @@ -147,7 +147,7 @@ static int btqcomsmd_probe(struct platform_device *pdev)
>                 goto destroy_acl_channel;
>         }
>
> -       hdev = hci_alloc_dev();
> +       hdev = hci_alloc_dev(0);
>         if (!hdev) {
>                 ret = -ENOMEM;
>                 goto destroy_cmd_channel;
> diff --git a/drivers/bluetooth/btrsi.c b/drivers/bluetooth/btrsi.c
> index 8646b6dd11e9..2f8d186e4807 100644
> --- a/drivers/bluetooth/btrsi.c
> +++ b/drivers/bluetooth/btrsi.c
> @@ -121,7 +121,7 @@ static int rsi_hci_attach(void *priv, struct rsi_proto_ops *ops)
>         ops->set_bt_context(priv, h_adapter);
>         h_adapter->proto_ops = ops;
>
> -       hdev = hci_alloc_dev();
> +       hdev = hci_alloc_dev(0);
>         if (!hdev) {
>                 BT_ERR("Failed to alloc HCI device");
>                 goto err;
> diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
> index 199e8f7d426d..69d2a26ed5db 100644
> --- a/drivers/bluetooth/btsdio.c
> +++ b/drivers/bluetooth/btsdio.c
> @@ -310,7 +310,7 @@ static int btsdio_probe(struct sdio_func *func,
>
>         skb_queue_head_init(&data->txq);
>
> -       hdev = hci_alloc_dev();
> +       hdev = hci_alloc_dev(0);
>         if (!hdev)
>                 return -ENOMEM;
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 1876a960b3dc..baf0934657d8 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4575,7 +4575,7 @@ static int btusb_probe(struct usb_interface *intf,
>                 data->recv_bulk = btusb_recv_bulk;
>         }
>
> -       hdev = hci_alloc_dev();
> +       hdev = hci_alloc_dev(0);
>         if (!hdev)
>                 return -ENOMEM;
>
> diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
> index 2adfe4fade76..f06c8151f0ea 100644
> --- a/drivers/bluetooth/dtl1_cs.c
> +++ b/drivers/bluetooth/dtl1_cs.c
> @@ -449,7 +449,7 @@ static int dtl1_open(struct dtl1_info *info)
>         set_bit(XMIT_WAITING, &(info->tx_state));
>
>         /* Initialize HCI device */
> -       hdev = hci_alloc_dev();
> +       hdev = hci_alloc_dev(0);
>         if (!hdev) {
>                 BT_ERR("Can't allocate HCI device");
>                 return -ENOMEM;
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index 5ed2cfa7da1d..89eb9d7685ae 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -627,7 +627,7 @@ static int hci_uart_register_dev(struct hci_uart *hu)
>         BT_DBG("");
>
>         /* Initialize and register HCI device */
> -       hdev = hci_alloc_dev();
> +       hdev = hci_alloc_dev(0);
>         if (!hdev) {
>                 BT_ERR("Can't allocate HCI device");
>                 return -ENOMEM;
> diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
> index 3b00d82d36cf..327fa2ecc5e7 100644
> --- a/drivers/bluetooth/hci_serdev.c
> +++ b/drivers/bluetooth/hci_serdev.c
> @@ -313,7 +313,7 @@ int hci_uart_register_device(struct hci_uart *hu,
>         set_bit(HCI_UART_PROTO_READY, &hu->flags);
>
>         /* Initialize and register HCI device */
> -       hdev = hci_alloc_dev();
> +       hdev = hci_alloc_dev(0);
>         if (!hdev) {
>                 BT_ERR("Can't allocate HCI device");
>                 err = -ENOMEM;
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index 8ab26dec5f6e..5486aa3945da 100644
> --- a/drivers/bluetooth/hci_vhci.c
> +++ b/drivers/bluetooth/hci_vhci.c
> @@ -96,7 +96,7 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
>         if (!skb)
>                 return -ENOMEM;
>
> -       hdev = hci_alloc_dev();
> +       hdev = hci_alloc_dev(0);
>         if (!hdev) {
>                 kfree_skb(skb);
>                 return -ENOMEM;
> diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
> index 57908ce4fae8..28576ec4860e 100644
> --- a/drivers/bluetooth/virtio_bt.c
> +++ b/drivers/bluetooth/virtio_bt.c
> @@ -283,7 +283,7 @@ static int virtbt_probe(struct virtio_device *vdev)
>         if (err)
>                 return err;
>
> -       hdev = hci_alloc_dev();
> +       hdev = hci_alloc_dev(0);
>         if (!hdev) {
>                 err = -ENOMEM;
>                 goto failed;
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index a53e94459ecd..5c689c5dc089 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1223,10 +1223,15 @@ static inline void hci_set_drvdata(struct hci_dev *hdev, void *data)
>         dev_set_drvdata(&hdev->dev, data);
>  }
>
> +static inline void *hci_get_priv(struct hci_dev *hdev)
> +{
> +       return (char *)hdev + sizeof(*hdev);
> +}
> +
>  struct hci_dev *hci_dev_get(int index);
>  struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src, u8 src_type);
>
> -struct hci_dev *hci_alloc_dev(void);
> +struct hci_dev *hci_alloc_dev(int sizeof_priv);

Just a minor suggestion here, we could perhaps have an alternative
version of hci_alloc_dev e.g hci_alloc_dev_priv so we don't need to
touch all the drivers like you did above.

>  void hci_free_dev(struct hci_dev *hdev);
>  int hci_register_dev(struct hci_dev *hdev);
>  void hci_unregister_dev(struct hci_dev *hdev);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 2560ed2f144d..66b72c7efa3d 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3751,11 +3751,18 @@ static int hci_suspend_notifier(struct notifier_block *nb, unsigned long action,
>  }
>
>  /* Alloc HCI device */
> -struct hci_dev *hci_alloc_dev(void)
> +struct hci_dev *hci_alloc_dev(int sizeof_priv)
>  {
>         struct hci_dev *hdev;
> +       unsigned int alloc_size;
>
> -       hdev = kzalloc(sizeof(*hdev), GFP_KERNEL);
> +       alloc_size = sizeof(*hdev);
> +       if (sizeof_priv) {
> +               /* Fixme: May need ALIGN-ment? */
> +               alloc_size += sizeof_priv;
> +       }
> +
> +       hdev = kzalloc(alloc_size, GFP_KERNEL);
>         if (!hdev)
>                 return NULL;
>
> --
> 2.26.3
>


-- 
Luiz Augusto von Dentz
