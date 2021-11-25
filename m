Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F977C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Nov 2021 17:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243657AbhKYRuG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Nov 2021 12:50:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24835 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232378AbhKYRsF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Nov 2021 12:48:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637862293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=e7BvKG8FTSCUywCGOxNtwP0noXjOs1TD9Frr4bEkwQo=;
        b=LGOR/aRJGcINTJtnI3WCI/stW2mGLxtDtzduwy+Wu14uREu8LHB7hjx94QfxW41ge7DYTf
        fVx2S845KmNd2A+BxuPBGsTn7xvNSkxnqVJpYztFt69wLSanuUj2OmBDYAYJfquHH2l+E2
        4CvRfm2VjCMARsvkshLWqE3j0fQejvk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-11-f_nCTLyBOPKCb6UfP8Xb-A-1; Thu, 25 Nov 2021 12:44:52 -0500
X-MC-Unique: f_nCTLyBOPKCb6UfP8Xb-A-1
Received: by mail-ed1-f71.google.com with SMTP id eg20-20020a056402289400b003eb56fcf6easo5950180edb.20
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Nov 2021 09:44:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=e7BvKG8FTSCUywCGOxNtwP0noXjOs1TD9Frr4bEkwQo=;
        b=hrMnHlFdef3ufvS4yMfJ5l019A+rqpZMCLUBd82sFNmK1+mNdOSrJNEi7cbNTMnH7L
         LpNmm5LNspXodcgw8icCebZ1B3Sh/QVbfDeqS3yCfT9257uxBFzdf6TGOBORTeMW0pdc
         5N4QomG6wEnJnQXwSqr8zPbF7IoRAtd5LL/GX8nWrHAMP4896hJ7HtKM+emKmrEQW1iU
         ie2b++k/UkK2ImcL7XOasWn1RHg0P1yd4DYE5+vXmZctX+dC88YOFM+GOyS3Jpbb5W5I
         l//cvYcwC7nHEpi5wJu3CiuamEhLZOD1+KASA3/fDj6kTcgOxxVGRwT+MgY9TKO75J1+
         x82g==
X-Gm-Message-State: AOAM531ZZ761a1yF76b+ebRatA4nUwxdp0+/nYMdu5GZPCdXnsj4/txd
        3uE9nzp5ld+yANH8XCGVQ0COgeuj8awyQIWtp9TTKSnqPe/AxpgSxSTzW3txm8J7Ho7ZzsGsFP6
        BMWQwmwdbZUZb0SgVSZ0FarYwOGAq
X-Received: by 2002:a05:6402:26c5:: with SMTP id x5mr41644309edd.198.1637862291205;
        Thu, 25 Nov 2021 09:44:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpwEn3VYvVMPaGoZd0qGJp74+cDdsbX2UWjVLjI4yEEPSqkH08d/TIHMG/MWFEShL7tUlQ4g==
X-Received: by 2002:a05:6402:26c5:: with SMTP id x5mr41644274edd.198.1637862291043;
        Thu, 25 Nov 2021 09:44:51 -0800 (PST)
Received: from redhat.com ([176.12.197.47])
        by smtp.gmail.com with ESMTPSA id og14sm1925383ejc.107.2021.11.25.09.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 09:44:50 -0800 (PST)
Date:   Thu, 25 Nov 2021 12:44:48 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] Bluetooth: virtio_bt: fix device removal
Message-ID: <20211125174200.133230-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Device removal is clearly out of virtio spec: it attempts to remove
unused buffers from a VQ before invoking device reset. To fix, make
open/close NOPs and do all cleanup/setup in probe/remove.

The cost here is a single skb wasted on an unused bt device - which
seems modest.

NB: with this fix in place driver still suffers from a race condition if
an interrupt triggers while device is being reset. Work on a fix for
that issue is in progress.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Note: completely untested, in particular the device isn't supported in QEMU.
Please do not queue directly - please help review and test and ack,
and I will queue this together with reset fixes.
Thanks!


 drivers/bluetooth/virtio_bt.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 24a9258962fa..aea33ba9522c 100644
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
@@ -351,8 +358,14 @@ static int virtbt_probe(struct virtio_device *vdev)
 		goto failed;
 	}
 
+	virtio_device_ready(vdev);
+	if (virtbt_open_vdev(vbt))
+		goto open_failed;
+
 	return 0;
 
+open_failed:
+	hci_free_dev(hdev);
 failed:
 	vdev->config->del_vqs(vdev);
 	return err;
@@ -365,6 +378,7 @@ static void virtbt_remove(struct virtio_device *vdev)
 
 	hci_unregister_dev(hdev);
 	vdev->config->reset(vdev);
+	virtbt_close_vdev(vbt);
 
 	hci_free_dev(hdev);
 	vbt->hdev = NULL;
-- 
MST

