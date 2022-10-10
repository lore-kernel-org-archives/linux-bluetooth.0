Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C08C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Oct 2022 17:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiJJRO6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Oct 2022 13:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiJJROz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Oct 2022 13:14:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D116613CD1
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Oct 2022 10:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665422093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rQRSSqgQ4c9BjxvZpkARxVYPlmmPTB3aVJCaeF1YLPM=;
        b=ahjgDp58/6Ccd2QEZnc9f9R63it/nHOC5kgHdH5aiG+6+mD6F2PAVpeR6ytzeDSfSejzAi
        dwO7g3OasuKM9jfASzAmeCfdyhHGlwG66SgYyd5w5AffqGPLYKJNppeJf7FwDFjDFL7jZE
        Vt1MpF7DN3D0y3eBP1A/qRMrhzdpGg4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-387-hnbqIK4WOS-wXcHbwsKVuA-1; Mon, 10 Oct 2022 13:14:44 -0400
X-MC-Unique: hnbqIK4WOS-wXcHbwsKVuA-1
Received: by mail-wm1-f71.google.com with SMTP id 3-20020a05600c020300b003c5eefe54adso968694wmi.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Oct 2022 10:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQRSSqgQ4c9BjxvZpkARxVYPlmmPTB3aVJCaeF1YLPM=;
        b=CoYOYqRdUqnOckABQoWDFqybsKWkvv0MNU0w+8wD8yGrKypD0IhWvr7bUQAk7pCrYW
         1s/UmQckh3vKF0TL29Cp9XLs6E1cp8aROTpb/0fuJKtsU9xIpJciSHdTtYXQYLuOSZD+
         AT2nuhU8FT1kJOTgRhlJWu0QPL+M0d582mMjjfMHh25ixqbYA0QYxivt/C/2WGBxBb76
         ZTTBaOVVcopcbCrt+US4Ig4Qm1LMoiGGa1YRCbaBEqr9XtzwXBgWxtWF15qIYYWlXg3L
         JE9WkEePqaFlpwF7k/XUqUhVK1dAWdpovlfIzm0eqhC0hRXYDF9k8C1WaZLxZjR+6AaI
         AxcA==
X-Gm-Message-State: ACrzQf1/SMohyMXXOnJscqIasBoAHpQVFQzIBP2EReycO+aLet1tPbel
        gsUxx8wC8ei3tD4eyXsjUBdYrXy8ZCjsY/isAkNSpoUQU+izXBZA9BqTBe0YNLe8vcyCLUvOjN9
        4YnBdIJ/7Umhy1GZf9CNn3VE1c+pp
X-Received: by 2002:a05:6000:16c3:b0:22e:c6fd:2676 with SMTP id h3-20020a05600016c300b0022ec6fd2676mr10451660wrf.141.1665422083049;
        Mon, 10 Oct 2022 10:14:43 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7OG547EaOYrk728y3uGdJpoAMAokCkwc5CJTaBezE7u5ah4gC7pKsQ+IjfdVwbM924lROjWg==
X-Received: by 2002:a05:6000:16c3:b0:22e:c6fd:2676 with SMTP id h3-20020a05600016c300b0022ec6fd2676mr10451646wrf.141.1665422082835;
        Mon, 10 Oct 2022 10:14:42 -0700 (PDT)
Received: from redhat.com ([2.55.183.131])
        by smtp.gmail.com with ESMTPSA id p18-20020adf9d92000000b0022afcc11f65sm9238215wre.47.2022.10.10.10.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 10:14:42 -0700 (PDT)
Date:   Mon, 10 Oct 2022 13:14:37 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Hulk Robot <hulkci@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 resend] Bluetooth: virtio_bt: fix device removal
Message-ID: <20220811094542.268519-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org
Message-ID: <20221010171437.UxabDLmoGUBiS-IWC4DdX6MjWUD4UnEfEhH6TWrgNRU@z>

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

The cost of the hack is a single skb wasted on an unused bt device.

NB2: with this fix in place driver still suffers from a race condition
if an interrupt triggers while device is being reset.  To fix, in the
virtbt_close() callback we should deactivate all interrupts.  To be
fixed.

squashed fixup: bluetooth: virtio_bt: fix an error code in probe()

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20220811080943.198245-1-mst@redhat.com>
---

resending due to v3 having been dropped
changes from v2:
	tkeaked commit log to make lines shorter
changes from v1:
	fixed error handling

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

