Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED6FC432BE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 07:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B662E60EB1
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 07:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbhGXGtr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 24 Jul 2021 02:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbhGXGtk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 24 Jul 2021 02:49:40 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0C2C061575
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Jul 2021 00:30:10 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id p5-20020a17090a8685b029015d1a9a6f1aso8147189pjn.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Jul 2021 00:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TgkdDMM3q147x2DO66poDEhjv+kw2aSJ9uTtRb1vkAI=;
        b=WdD0rPpcd64qv8zUaMt1qD9fxuNNma9t/Fmni/AuULjksuvOQRfz1X05GrkZRIBz7F
         d1/AegbQhNKBZHUhpTR05TvU4dkDFG21zFlz6yhoEvwoB6uL0Nd+2VcpvmDK/q0NpVz1
         B9lbuDDWkD5afs6h6YAHrzl48H0ErHLi9QE5QKa1oZgJXj3ZCZcCVUs0VjTnvVINCKTV
         FfbdDlp3XHUhTfIlRb3gZBqe4Yvs5UHdCe9xharJDlPTwFfo6xl5LPO2q0FUSdQgHWFZ
         096FuTN/GutlAP1djRjKuCZp9Aw1+hqgwAabj96ygt/zpncwvoP4qxh8qEY8ezJP0YXQ
         Nhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TgkdDMM3q147x2DO66poDEhjv+kw2aSJ9uTtRb1vkAI=;
        b=Kns2DLqJqBgoDbQFTs3FL+r+aPFu6QoTWa40ccKqn0Wuf2AfUnKr/PSpEjFp/3OtFH
         cu5oFB5hCpt9lS2Q686REYLIfywtzcxTXxZj1LrHzT2JsqDM+VuivFQ7vnCNg+Lz8EeL
         St+UFRPOukK3f4HG08i5QI3EvxG1CmcjBHHjF/KpXJ91p17Q7oeT85k326cD47Pi6cOZ
         U3XomA3vBst/T6keEHlKwt3RN2UCeER5gjyP3+gfcKMkoEpr6gMECFE22G8fTojVA2dr
         IPOnG4POZXz/H/uqVZoADOkHlqgJUl78NCPEV3VbfwmsYvjoFT3/VqQPur6XTPNFtN9U
         M7gQ==
X-Gm-Message-State: AOAM5302lbtngljK7CU7UkONaWT5NNsMPbyzF0FM/sYgsDrnbIEXhn4W
        6BjYBwg4MrpjfM4PALTgtbji0BnhDhU=
X-Google-Smtp-Source: ABdhPJxnoyuhah26GJ71kNvP0MCz7TNOheB/dd1FDHYFs+6BarTKwIY+eYLTVHzpSXD5RML5v+cZEQ==
X-Received: by 2002:a17:902:fe11:b029:12b:9108:c068 with SMTP id g17-20020a170902fe11b029012b9108c068mr6746033plj.36.1627111810141;
        Sat, 24 Jul 2021 00:30:10 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830::1291])
        by smtp.gmail.com with ESMTPSA id u24sm38510919pfm.141.2021.07.24.00.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 00:30:09 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [RFC PATCH v3 1/9] Bluetooth: Add support hdev to allocate private data
Date:   Sat, 24 Jul 2021 00:29:57 -0700
Message-Id: <20210724073005.714003-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210724073005.714003-1-hj.tedd.an@gmail.com>
References: <20210724073005.714003-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds support hdev to allocate extra size for private data.
The size of private data is specified in the hdev_alloc_size(priv_size)
and the allocated buffer can be accessed with hci_get_priv(hdev).

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/bfusb.c        |  2 +-
 drivers/bluetooth/bluecard_cs.c  |  2 +-
 drivers/bluetooth/bpa10x.c       |  2 +-
 drivers/bluetooth/bt3c_cs.c      |  2 +-
 drivers/bluetooth/btmrvl_main.c  |  2 +-
 drivers/bluetooth/btmtksdio.c    |  2 +-
 drivers/bluetooth/btmtkuart.c    |  2 +-
 drivers/bluetooth/btqcomsmd.c    |  2 +-
 drivers/bluetooth/btrsi.c        |  2 +-
 drivers/bluetooth/btsdio.c       |  2 +-
 drivers/bluetooth/btusb.c        |  2 +-
 drivers/bluetooth/dtl1_cs.c      |  2 +-
 drivers/bluetooth/hci_ldisc.c    |  2 +-
 drivers/bluetooth/hci_serdev.c   |  2 +-
 drivers/bluetooth/hci_vhci.c     |  2 +-
 drivers/bluetooth/virtio_bt.c    |  2 +-
 include/net/bluetooth/hci_core.h |  7 ++++++-
 net/bluetooth/hci_core.c         | 11 +++++++++--
 18 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 5a321b4076aa..430e230999fa 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -651,7 +651,7 @@ static int bfusb_probe(struct usb_interface *intf, const struct usb_device_id *i
 	release_firmware(firmware);
 
 	/* Initialize and register HCI device */
-	hdev = hci_alloc_dev();
+	hdev = hci_alloc_dev(0);
 	if (!hdev) {
 		BT_ERR("Can't allocate HCI device");
 		goto done;
diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index 36eabf61717f..d62b878aff7e 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -694,7 +694,7 @@ static int bluecard_open(struct bluecard_info *info)
 	info->rx_skb = NULL;
 
 	/* Initialize HCI device */
-	hdev = hci_alloc_dev();
+	hdev = hci_alloc_dev(0);
 	if (!hdev) {
 		BT_ERR("Can't allocate HCI device");
 		return -ENOMEM;
diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index 1fa58c059cbf..bd670352a336 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -380,7 +380,7 @@ static int bpa10x_probe(struct usb_interface *intf,
 	init_usb_anchor(&data->tx_anchor);
 	init_usb_anchor(&data->rx_anchor);
 
-	hdev = hci_alloc_dev();
+	hdev = hci_alloc_dev(0);
 	if (!hdev)
 		return -ENOMEM;
 
diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index 54713833951a..cd135a736688 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -550,7 +550,7 @@ static int bt3c_open(struct bt3c_info *info)
 	info->rx_skb = NULL;
 
 	/* Initialize HCI device */
-	hdev = hci_alloc_dev();
+	hdev = hci_alloc_dev(0);
 	if (!hdev) {
 		BT_ERR("Can't allocate HCI device");
 		return -ENOMEM;
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 8b9d78ce6bb2..0157fa4ce528 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -680,7 +680,7 @@ int btmrvl_register_hdev(struct btmrvl_private *priv)
 	struct btmrvl_sdio_card *card = priv->btmrvl_dev.card;
 	int ret;
 
-	hdev = hci_alloc_dev();
+	hdev = hci_alloc_dev(0);
 	if (!hdev) {
 		BT_ERR("Can not allocate HCI device");
 		goto err_hdev;
diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 9872ef18f9fe..b48aec25c09d 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -959,7 +959,7 @@ static int btmtksdio_probe(struct sdio_func *func,
 	skb_queue_head_init(&bdev->txq);
 
 	/* Initialize and register HCI device */
-	hdev = hci_alloc_dev();
+	hdev = hci_alloc_dev(0);
 	if (!hdev) {
 		dev_err(&func->dev, "Can't allocate HCI device\n");
 		return -ENOMEM;
diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index e9d91d7c0db4..96ee364507c5 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -987,7 +987,7 @@ static int btmtkuart_probe(struct serdev_device *serdev)
 	skb_queue_head_init(&bdev->txq);
 
 	/* Initialize and register HCI device */
-	hdev = hci_alloc_dev();
+	hdev = hci_alloc_dev(0);
 	if (!hdev) {
 		dev_err(&serdev->dev, "Can't allocate HCI device\n");
 		return -ENOMEM;
diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
index 2acb719e596f..47aaffceb8c1 100644
--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -147,7 +147,7 @@ static int btqcomsmd_probe(struct platform_device *pdev)
 		goto destroy_acl_channel;
 	}
 
-	hdev = hci_alloc_dev();
+	hdev = hci_alloc_dev(0);
 	if (!hdev) {
 		ret = -ENOMEM;
 		goto destroy_cmd_channel;
diff --git a/drivers/bluetooth/btrsi.c b/drivers/bluetooth/btrsi.c
index bea1595f6432..90e398c42a41 100644
--- a/drivers/bluetooth/btrsi.c
+++ b/drivers/bluetooth/btrsi.c
@@ -121,7 +121,7 @@ static int rsi_hci_attach(void *priv, struct rsi_proto_ops *ops)
 	ops->set_bt_context(priv, h_adapter);
 	h_adapter->proto_ops = ops;
 
-	hdev = hci_alloc_dev();
+	hdev = hci_alloc_dev(0);
 	if (!hdev) {
 		BT_ERR("Failed to alloc HCI device");
 		goto err;
diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 199e8f7d426d..69d2a26ed5db 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -310,7 +310,7 @@ static int btsdio_probe(struct sdio_func *func,
 
 	skb_queue_head_init(&data->txq);
 
-	hdev = hci_alloc_dev();
+	hdev = hci_alloc_dev(0);
 	if (!hdev)
 		return -ENOMEM;
 
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a9855a2dd561..66936a1862e3 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4560,7 +4560,7 @@ static int btusb_probe(struct usb_interface *intf,
 		data->recv_bulk = btusb_recv_bulk;
 	}
 
-	hdev = hci_alloc_dev();
+	hdev = hci_alloc_dev(0);
 	if (!hdev)
 		return -ENOMEM;
 
diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index 2adfe4fade76..f06c8151f0ea 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -449,7 +449,7 @@ static int dtl1_open(struct dtl1_info *info)
 	set_bit(XMIT_WAITING, &(info->tx_state));
 
 	/* Initialize HCI device */
-	hdev = hci_alloc_dev();
+	hdev = hci_alloc_dev(0);
 	if (!hdev) {
 		BT_ERR("Can't allocate HCI device");
 		return -ENOMEM;
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 71a4ca505e09..7ad61bdb2023 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -627,7 +627,7 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 	BT_DBG("");
 
 	/* Initialize and register HCI device */
-	hdev = hci_alloc_dev();
+	hdev = hci_alloc_dev(0);
 	if (!hdev) {
 		BT_ERR("Can't allocate HCI device");
 		return -ENOMEM;
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 3b00d82d36cf..327fa2ecc5e7 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -313,7 +313,7 @@ int hci_uart_register_device(struct hci_uart *hu,
 	set_bit(HCI_UART_PROTO_READY, &hu->flags);
 
 	/* Initialize and register HCI device */
-	hdev = hci_alloc_dev();
+	hdev = hci_alloc_dev(0);
 	if (!hdev) {
 		BT_ERR("Can't allocate HCI device");
 		err = -ENOMEM;
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 8ab26dec5f6e..5486aa3945da 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -96,7 +96,7 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	if (!skb)
 		return -ENOMEM;
 
-	hdev = hci_alloc_dev();
+	hdev = hci_alloc_dev(0);
 	if (!hdev) {
 		kfree_skb(skb);
 		return -ENOMEM;
diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 57908ce4fae8..28576ec4860e 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -283,7 +283,7 @@ static int virtbt_probe(struct virtio_device *vdev)
 	if (err)
 		return err;
 
-	hdev = hci_alloc_dev();
+	hdev = hci_alloc_dev(0);
 	if (!hdev) {
 		err = -ENOMEM;
 		goto failed;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a53e94459ecd..5c689c5dc089 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1223,10 +1223,15 @@ static inline void hci_set_drvdata(struct hci_dev *hdev, void *data)
 	dev_set_drvdata(&hdev->dev, data);
 }
 
+static inline void *hci_get_priv(struct hci_dev *hdev)
+{
+	return (char *)hdev + sizeof(*hdev);
+}
+
 struct hci_dev *hci_dev_get(int index);
 struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src, u8 src_type);
 
-struct hci_dev *hci_alloc_dev(void);
+struct hci_dev *hci_alloc_dev(int sizeof_priv);
 void hci_free_dev(struct hci_dev *hdev);
 int hci_register_dev(struct hci_dev *hdev);
 void hci_unregister_dev(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2560ed2f144d..66b72c7efa3d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3751,11 +3751,18 @@ static int hci_suspend_notifier(struct notifier_block *nb, unsigned long action,
 }
 
 /* Alloc HCI device */
-struct hci_dev *hci_alloc_dev(void)
+struct hci_dev *hci_alloc_dev(int sizeof_priv)
 {
 	struct hci_dev *hdev;
+	unsigned int alloc_size;
 
-	hdev = kzalloc(sizeof(*hdev), GFP_KERNEL);
+	alloc_size = sizeof(*hdev);
+	if (sizeof_priv) {
+		/* Fixme: May need ALIGN-ment? */
+		alloc_size += sizeof_priv;
+	}
+
+	hdev = kzalloc(alloc_size, GFP_KERNEL);
 	if (!hdev)
 		return NULL;
 
-- 
2.26.3

