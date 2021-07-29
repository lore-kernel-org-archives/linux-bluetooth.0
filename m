Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEB1C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 11:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CD55604DC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 11:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhG2LkC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 07:40:02 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:55300 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhG2LkC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 07:40:02 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3B7EBCED14;
        Thu, 29 Jul 2021 13:39:58 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [RFC PATCH v4 01/11] Bluetooth: Add support hdev to allocate
 private data
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZJEQ+aqyUx_6zY5db4F_VPV4dPVN0QjoGhrHvpqHrj=3Q@mail.gmail.com>
Date:   Thu, 29 Jul 2021 13:39:57 +0200
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <3F19A4DD-4BF8-4BC2-BA98-82C44EED82C2@holtmann.org>
References: <20210727235127.173149-1-hj.tedd.an@gmail.com>
 <20210727235127.173149-2-hj.tedd.an@gmail.com>
 <CABBYNZJEQ+aqyUx_6zY5db4F_VPV4dPVN0QjoGhrHvpqHrj=3Q@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>> This patch adds support hdev to allocate extra size for private data.
>> The size of private data is specified in the hdev_alloc_size(priv_size)
>> and the allocated buffer can be accessed with hci_get_priv(hdev).
>> 
>> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
>> ---
>> drivers/bluetooth/bfusb.c        |  2 +-
>> drivers/bluetooth/bluecard_cs.c  |  2 +-
>> drivers/bluetooth/bpa10x.c       |  2 +-
>> drivers/bluetooth/bt3c_cs.c      |  2 +-
>> drivers/bluetooth/btmrvl_main.c  |  2 +-
>> drivers/bluetooth/btmtksdio.c    |  2 +-
>> drivers/bluetooth/btmtkuart.c    |  2 +-
>> drivers/bluetooth/btqcomsmd.c    |  2 +-
>> drivers/bluetooth/btrsi.c        |  2 +-
>> drivers/bluetooth/btsdio.c       |  2 +-
>> drivers/bluetooth/btusb.c        |  2 +-
>> drivers/bluetooth/dtl1_cs.c      |  2 +-
>> drivers/bluetooth/hci_ldisc.c    |  2 +-
>> drivers/bluetooth/hci_serdev.c   |  2 +-
>> drivers/bluetooth/hci_vhci.c     |  2 +-
>> drivers/bluetooth/virtio_bt.c    |  2 +-
>> include/net/bluetooth/hci_core.h |  7 ++++++-
>> net/bluetooth/hci_core.c         | 11 +++++++++--
>> 18 files changed, 31 insertions(+), 19 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
>> index 5a321b4076aa..430e230999fa 100644
>> --- a/drivers/bluetooth/bfusb.c
>> +++ b/drivers/bluetooth/bfusb.c
>> @@ -651,7 +651,7 @@ static int bfusb_probe(struct usb_interface *intf, const struct usb_device_id *i
>>        release_firmware(firmware);
>> 
>>        /* Initialize and register HCI device */
>> -       hdev = hci_alloc_dev();
>> +       hdev = hci_alloc_dev(0);
>>        if (!hdev) {
>>                BT_ERR("Can't allocate HCI device");
>>                goto done;
>> diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
>> index 36eabf61717f..d62b878aff7e 100644
>> --- a/drivers/bluetooth/bluecard_cs.c
>> +++ b/drivers/bluetooth/bluecard_cs.c
>> @@ -694,7 +694,7 @@ static int bluecard_open(struct bluecard_info *info)
>>        info->rx_skb = NULL;
>> 
>>        /* Initialize HCI device */
>> -       hdev = hci_alloc_dev();
>> +       hdev = hci_alloc_dev(0);
>>        if (!hdev) {
>>                BT_ERR("Can't allocate HCI device");
>>                return -ENOMEM;
>> diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
>> index 1fa58c059cbf..bd670352a336 100644
>> --- a/drivers/bluetooth/bpa10x.c
>> +++ b/drivers/bluetooth/bpa10x.c
>> @@ -380,7 +380,7 @@ static int bpa10x_probe(struct usb_interface *intf,
>>        init_usb_anchor(&data->tx_anchor);
>>        init_usb_anchor(&data->rx_anchor);
>> 
>> -       hdev = hci_alloc_dev();
>> +       hdev = hci_alloc_dev(0);
>>        if (!hdev)
>>                return -ENOMEM;
>> 
>> diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
>> index 54713833951a..cd135a736688 100644
>> --- a/drivers/bluetooth/bt3c_cs.c
>> +++ b/drivers/bluetooth/bt3c_cs.c
>> @@ -550,7 +550,7 @@ static int bt3c_open(struct bt3c_info *info)
>>        info->rx_skb = NULL;
>> 
>>        /* Initialize HCI device */
>> -       hdev = hci_alloc_dev();
>> +       hdev = hci_alloc_dev(0);
>>        if (!hdev) {
>>                BT_ERR("Can't allocate HCI device");
>>                return -ENOMEM;
>> diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
>> index 8b9d78ce6bb2..0157fa4ce528 100644
>> --- a/drivers/bluetooth/btmrvl_main.c
>> +++ b/drivers/bluetooth/btmrvl_main.c
>> @@ -680,7 +680,7 @@ int btmrvl_register_hdev(struct btmrvl_private *priv)
>>        struct btmrvl_sdio_card *card = priv->btmrvl_dev.card;
>>        int ret;
>> 
>> -       hdev = hci_alloc_dev();
>> +       hdev = hci_alloc_dev(0);
>>        if (!hdev) {
>>                BT_ERR("Can not allocate HCI device");
>>                goto err_hdev;
>> diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
>> index 9872ef18f9fe..b48aec25c09d 100644
>> --- a/drivers/bluetooth/btmtksdio.c
>> +++ b/drivers/bluetooth/btmtksdio.c
>> @@ -959,7 +959,7 @@ static int btmtksdio_probe(struct sdio_func *func,
>>        skb_queue_head_init(&bdev->txq);
>> 
>>        /* Initialize and register HCI device */
>> -       hdev = hci_alloc_dev();
>> +       hdev = hci_alloc_dev(0);
>>        if (!hdev) {
>>                dev_err(&func->dev, "Can't allocate HCI device\n");
>>                return -ENOMEM;
>> diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
>> index e9d91d7c0db4..96ee364507c5 100644
>> --- a/drivers/bluetooth/btmtkuart.c
>> +++ b/drivers/bluetooth/btmtkuart.c
>> @@ -987,7 +987,7 @@ static int btmtkuart_probe(struct serdev_device *serdev)
>>        skb_queue_head_init(&bdev->txq);
>> 
>>        /* Initialize and register HCI device */
>> -       hdev = hci_alloc_dev();
>> +       hdev = hci_alloc_dev(0);
>>        if (!hdev) {
>>                dev_err(&serdev->dev, "Can't allocate HCI device\n");
>>                return -ENOMEM;
>> diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
>> index 2acb719e596f..47aaffceb8c1 100644
>> --- a/drivers/bluetooth/btqcomsmd.c
>> +++ b/drivers/bluetooth/btqcomsmd.c
>> @@ -147,7 +147,7 @@ static int btqcomsmd_probe(struct platform_device *pdev)
>>                goto destroy_acl_channel;
>>        }
>> 
>> -       hdev = hci_alloc_dev();
>> +       hdev = hci_alloc_dev(0);
>>        if (!hdev) {
>>                ret = -ENOMEM;
>>                goto destroy_cmd_channel;
>> diff --git a/drivers/bluetooth/btrsi.c b/drivers/bluetooth/btrsi.c
>> index 8646b6dd11e9..2f8d186e4807 100644
>> --- a/drivers/bluetooth/btrsi.c
>> +++ b/drivers/bluetooth/btrsi.c
>> @@ -121,7 +121,7 @@ static int rsi_hci_attach(void *priv, struct rsi_proto_ops *ops)
>>        ops->set_bt_context(priv, h_adapter);
>>        h_adapter->proto_ops = ops;
>> 
>> -       hdev = hci_alloc_dev();
>> +       hdev = hci_alloc_dev(0);
>>        if (!hdev) {
>>                BT_ERR("Failed to alloc HCI device");
>>                goto err;
>> diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
>> index 199e8f7d426d..69d2a26ed5db 100644
>> --- a/drivers/bluetooth/btsdio.c
>> +++ b/drivers/bluetooth/btsdio.c
>> @@ -310,7 +310,7 @@ static int btsdio_probe(struct sdio_func *func,
>> 
>>        skb_queue_head_init(&data->txq);
>> 
>> -       hdev = hci_alloc_dev();
>> +       hdev = hci_alloc_dev(0);
>>        if (!hdev)
>>                return -ENOMEM;
>> 
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 1876a960b3dc..baf0934657d8 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -4575,7 +4575,7 @@ static int btusb_probe(struct usb_interface *intf,
>>                data->recv_bulk = btusb_recv_bulk;
>>        }
>> 
>> -       hdev = hci_alloc_dev();
>> +       hdev = hci_alloc_dev(0);
>>        if (!hdev)
>>                return -ENOMEM;
>> 
>> diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
>> index 2adfe4fade76..f06c8151f0ea 100644
>> --- a/drivers/bluetooth/dtl1_cs.c
>> +++ b/drivers/bluetooth/dtl1_cs.c
>> @@ -449,7 +449,7 @@ static int dtl1_open(struct dtl1_info *info)
>>        set_bit(XMIT_WAITING, &(info->tx_state));
>> 
>>        /* Initialize HCI device */
>> -       hdev = hci_alloc_dev();
>> +       hdev = hci_alloc_dev(0);
>>        if (!hdev) {
>>                BT_ERR("Can't allocate HCI device");
>>                return -ENOMEM;
>> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
>> index 5ed2cfa7da1d..89eb9d7685ae 100644
>> --- a/drivers/bluetooth/hci_ldisc.c
>> +++ b/drivers/bluetooth/hci_ldisc.c
>> @@ -627,7 +627,7 @@ static int hci_uart_register_dev(struct hci_uart *hu)
>>        BT_DBG("");
>> 
>>        /* Initialize and register HCI device */
>> -       hdev = hci_alloc_dev();
>> +       hdev = hci_alloc_dev(0);
>>        if (!hdev) {
>>                BT_ERR("Can't allocate HCI device");
>>                return -ENOMEM;
>> diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
>> index 3b00d82d36cf..327fa2ecc5e7 100644
>> --- a/drivers/bluetooth/hci_serdev.c
>> +++ b/drivers/bluetooth/hci_serdev.c
>> @@ -313,7 +313,7 @@ int hci_uart_register_device(struct hci_uart *hu,
>>        set_bit(HCI_UART_PROTO_READY, &hu->flags);
>> 
>>        /* Initialize and register HCI device */
>> -       hdev = hci_alloc_dev();
>> +       hdev = hci_alloc_dev(0);
>>        if (!hdev) {
>>                BT_ERR("Can't allocate HCI device");
>>                err = -ENOMEM;
>> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
>> index 8ab26dec5f6e..5486aa3945da 100644
>> --- a/drivers/bluetooth/hci_vhci.c
>> +++ b/drivers/bluetooth/hci_vhci.c
>> @@ -96,7 +96,7 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
>>        if (!skb)
>>                return -ENOMEM;
>> 
>> -       hdev = hci_alloc_dev();
>> +       hdev = hci_alloc_dev(0);
>>        if (!hdev) {
>>                kfree_skb(skb);
>>                return -ENOMEM;
>> diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
>> index 57908ce4fae8..28576ec4860e 100644
>> --- a/drivers/bluetooth/virtio_bt.c
>> +++ b/drivers/bluetooth/virtio_bt.c
>> @@ -283,7 +283,7 @@ static int virtbt_probe(struct virtio_device *vdev)
>>        if (err)
>>                return err;
>> 
>> -       hdev = hci_alloc_dev();
>> +       hdev = hci_alloc_dev(0);
>>        if (!hdev) {
>>                err = -ENOMEM;
>>                goto failed;
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index a53e94459ecd..5c689c5dc089 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -1223,10 +1223,15 @@ static inline void hci_set_drvdata(struct hci_dev *hdev, void *data)
>>        dev_set_drvdata(&hdev->dev, data);
>> }
>> 
>> +static inline void *hci_get_priv(struct hci_dev *hdev)
>> +{
>> +       return (char *)hdev + sizeof(*hdev);
>> +}
>> +
>> struct hci_dev *hci_dev_get(int index);
>> struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src, u8 src_type);
>> 
>> -struct hci_dev *hci_alloc_dev(void);
>> +struct hci_dev *hci_alloc_dev(int sizeof_priv);
> 
> Just a minor suggestion here, we could perhaps have an alternative
> version of hci_alloc_dev e.g hci_alloc_dev_priv so we don't need to
> touch all the drivers like you did above.

I agree. Lets do hci_alloc_dev_priv first and we can decide to touch all drivers later on.

Regards

Marcel

