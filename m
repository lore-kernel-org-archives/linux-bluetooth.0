Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6853C25B06
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Aug 2022 08:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbiHKIRG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Aug 2022 04:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbiHKIRE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Aug 2022 04:17:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F68061D5B
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 01:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660205822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1OOrknk8wnSFx/n3LoSQep6GlbQsFGYPjQcITSJy2Bg=;
        b=dfR9EiLz8IqjkMtKwLnlTe2ahNEq7NuwKXzZYaNfnE9fz+ZPPz0hG+f41vCdSqFi4KNEDm
        iS4CQXiuQYvyHgGujg6/D9X27vqgHl0fL1R/9NWwrB6nto8aJWLYy1ldZFR0pLp6LIqPCH
        f3h6YU8RRM4rH4ACna27sX3DyQ+py1E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-q55wik3DMYihxbBuTBQ9dA-1; Thu, 11 Aug 2022 04:17:01 -0400
X-MC-Unique: q55wik3DMYihxbBuTBQ9dA-1
Received: by mail-ej1-f71.google.com with SMTP id ho13-20020a1709070e8d00b00730a655e173so5240368ejc.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 01:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=1OOrknk8wnSFx/n3LoSQep6GlbQsFGYPjQcITSJy2Bg=;
        b=Tvl1LrWKyQ94JghyB1ZsduDY49PdpIftwCYOMY4EEgPwoqd8N3SH9sg4oSM4mkiwXm
         ziEVhdbzq25nDPPMBKNAixUud+OHg/ZONGczFnjfPoef7/YW3ApYjdyDwhTMk9ZxBPBq
         Lo0VlsahjY7cKyoJDNn0LDjyGjtbUR3Wn9t9B6JXYnWjh3DTpazI/b2y6fB35hoPUNt2
         h0HL7WPvkjzVon1B2wlEE5dy9FiKvvTkrJvwLrYgpBHcY080FPU09z6Za6ARhEAq4K0P
         xWB/lxb7jlDA1VcFzxecV8bCOoFhg3J16kL5b5R8Vgnhazcl589D6EFUXubtTCFOAOLy
         3PMA==
X-Gm-Message-State: ACgBeo0RPMFX2YAVuWNMqLoXOcYvvbMOQ2+JHD+h3FiO0ue6bYrTSrpy
        zaiwN7leSFeZd2g8X4cb4glM6aIFL4j8Q7Xmkso/YWMj1KVZqj1vWw/E/Meu7e6hH+pOtT5kjiL
        U2qT9qHewNOL7ShrVpCt3yyZg6ywr
X-Received: by 2002:a50:d0da:0:b0:43d:5f5f:32c3 with SMTP id g26-20020a50d0da000000b0043d5f5f32c3mr29851719edf.192.1660205820386;
        Thu, 11 Aug 2022 01:17:00 -0700 (PDT)
X-Google-Smtp-Source: AA6agR68vSw7W3x93NsUlsYejFUy4nOPkEvkd4PRrJxSCN/xe0+b7SG/AfUzQoWeUSQ4vt3B31T8MQ==
X-Received: by 2002:a50:d0da:0:b0:43d:5f5f:32c3 with SMTP id g26-20020a50d0da000000b0043d5f5f32c3mr29851709edf.192.1660205820200;
        Thu, 11 Aug 2022 01:17:00 -0700 (PDT)
Received: from redhat.com ([2.52.152.113])
        by smtp.gmail.com with ESMTPSA id f26-20020a170906139a00b0072b55713daesm3255618ejc.56.2022.08.11.01.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 01:16:59 -0700 (PDT)
Date:   Thu, 11 Aug 2022 04:16:57 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Hulk Robot <hulkci@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: virtio_bt: fix device removal
Message-ID: <20220811080943.198245-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Device removal is clearly out of virtio spec: it attempts to remove
unused buffers from a VQ before invoking device reset. To fix, make
open/close NOPs and do all cleanup/setup in probe/remove.


NB: This is a hacky way to handle this - virtbt_{open,close} as NOP is
not really what a driver is supposed to be doing. These are transport
enable/disable callbacks from the BT core towards the driver. It maps to
a device being enabled/disabled by something like bluetoothd for
example. So if disabled, users expect that no resources/queues are in
use.  It does work with all other transports like USB, SDIO, UART etc.
There should be no buffer used if the device is powered off. We also
don’t have any USB URBs in-flight if the transport is not active.

The way to implement a proper fix would be using vq reset if supported,
or even using a full device reset.

The cost of the hack used here is a single skb wasted on an unused bt device.

NB2: with this fix in place driver still suffers from a race condition
if an interrupt triggers while device is being reset.  To fix, in the
virtbt_close() callback we should deactivate all interrupts.  To be
fixed.

Includes a squashed fixup: bluetooth: virtio_bt: fix an error code in probe()

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/bluetooth/virtio_bt.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 67c21263f9e0..f6d699fed139 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -50,8 +50,11 @@ static int virtbt_add_inbuf(struct virtio_bluetooth *vbt)
 
 static int virtbt_open(struct hci_dev *hdev)
 {
-	struct virtio_bluetooth *vbt = hci_get_drvdata(hdev);
+	return 0;
+}
 
+static int virtbt_open_vdev(struct virtio_bluetooth *vbt)
+{
 	if (virtbt_add_inbuf(vbt) < 0)
 		return -EIO;
 
@@ -61,7 +64,11 @@ static int virtbt_open(struct hci_dev *hdev)
 
 static int virtbt_close(struct hci_dev *hdev)
 {
-	struct virtio_bluetooth *vbt = hci_get_drvdata(hdev);
+	return 0;
+}
+
+static int virtbt_close_vdev(struct virtio_bluetooth *vbt)
+{
 	int i;
 
 	cancel_work_sync(&vbt->rx);
@@ -354,8 +361,15 @@ static int virtbt_probe(struct virtio_device *vdev)
 		goto failed;
 	}
 
+	virtio_device_ready(vdev);
+	err = virtbt_open_vdev(vbt);
+	if (err)
+		goto open_failed;
+
 	return 0;
 
+open_failed:
+	hci_free_dev(hdev);
 failed:
 	vdev->config->del_vqs(vdev);
 	return err;
@@ -368,6 +382,7 @@ static void virtbt_remove(struct virtio_device *vdev)
 
 	hci_unregister_dev(hdev);
 	virtio_reset_device(vdev);
+	virtbt_close_vdev(vbt);
 
 	hci_free_dev(hdev);
 	vbt->hdev = NULL;
-- 
MST

