Return-Path: <SRS0=2Kq+=ZE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591F3C17440
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 23:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310F2222BD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 23:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nKKRyPq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfKLXKO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Nov 2019 18:10:14 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46216 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbfKLXKO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Nov 2019 18:10:14 -0500
Received: by mail-pl1-f193.google.com with SMTP id l4so161003plt.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2019 15:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OUwCOpGGevpZeid7mwzdv9OSg11AIX45PGSablIpMsk=;
        b=nKKRyPq8yRpB6YFcsUoedlOm/u4gIwku6f0qA0wk5vyxivksJNMVGNKLXqbf3+d56f
         DKaxdvDLDBePFO+4mhsd3nQMkGQWorouTZlQZyUUJQ4fb9sW09nzSM1ByKkVvC/gJC70
         1QsJeEI6R8MFepyR6MNOg5g3zDc9eufF2G9U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OUwCOpGGevpZeid7mwzdv9OSg11AIX45PGSablIpMsk=;
        b=jgMtdsD6wixcgPwft3hk4/UB3EbOZ7g3mVRzM+/qlP/X5vrecSer2GOxsSTTzKD+TI
         dlFuMUfjN4j04ESZ6eKgdVbb7I35YtrY+0p7P0B71LKUFPcwzvFkhglhbMkrtot6Tv5/
         8faB2EauB9PHmOM/7CII9xmHfQ/shU9JzRk0s4quXbZ4FpVLwyUjEy2zZMkCwapvxwOo
         aA64aQFLMKytqeYQhKa2KACq2SkxYQoefQoHKKmPb+PP1P+CEhj4iHSu2PWb60KeSHhZ
         4TIpqZih8aWGCSWhJt7afULCd1X+DB2Pcw61r3I0mZNC5s9EUWrzvcKbWaNbPtRGFB2d
         MuVQ==
X-Gm-Message-State: APjAAAWG9TtmUh9SRJl7E7w8PTVuWzr2auHCyfs4r1kBSXjc3UTYU3mm
        eibaQ3knWTsWuBm+7OqifYTnBw==
X-Google-Smtp-Source: APXvYqyWiG939mF2ySxbBU6okGki8HAwc4B8xcaOeaG8zYyLPrWggenVYOsU2dGIpzgQrFuNv4NS5g==
X-Received: by 2002:a17:902:854c:: with SMTP id d12mr341549plo.264.1573600213881;
        Tue, 12 Nov 2019 15:10:13 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id w27sm67694pgc.20.2019.11.12.15.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:10:12 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-bluetooth@vger.kernel.org, dianders@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] Bluetooth: hci_bcm: Support pcm params in dts
Date:   Tue, 12 Nov 2019 15:09:43 -0800
Message-Id: <20191112230944.48716-4-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191112230944.48716-1-abhishekpandit@chromium.org>
References: <20191112230944.48716-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

BCM chips may require configuration of PCM to operate correctly and
there is a vendor specific HCI command to do this. Add support in the
hci_bcm driver to parse this from devicetree and configure the chip.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/bluetooth/hci_bcm.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 6134bff58748..4ee0b45be7e2 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -88,6 +88,8 @@ struct bcm_device_data {
  *	used to disable flow control during runtime suspend and system sleep
  * @is_suspended: whether flow control is currently disabled
  * @disallow_set_baudrate: don't allow set_baudrate
+ * @has_pcm_params: whether PCM parameters need to be configured
+ * @pcm_params: PCM and routing parameters
  */
 struct bcm_device {
 	/* Must be the first member, hci_serdev.c expects this. */
@@ -122,6 +124,9 @@ struct bcm_device {
 	bool			is_suspended;
 #endif
 	bool			disallow_set_baudrate;
+
+	bool				has_pcm_params;
+	struct bcm_set_pcm_int_params	pcm_params;
 };
 
 /* generic bcm uart resources */
@@ -596,6 +601,16 @@ static int bcm_setup(struct hci_uart *hu)
 			host_set_baudrate(hu, speed);
 	}
 
+	/* PCM parameters if any*/
+	if (bcm->dev && bcm->dev->has_pcm_params) {
+		err = btbcm_set_pcm_int_params(hu->hdev, &bcm->dev->pcm_params);
+
+		if (err) {
+			bt_dev_info(hu->hdev, "BCM: Set pcm params failed (%d)",
+				    err);
+		}
+	}
+
 finalize:
 	release_firmware(fw);
 
@@ -1132,7 +1147,24 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 
 static int bcm_of_probe(struct bcm_device *bdev)
 {
+	int err;
+
 	device_property_read_u32(bdev->dev, "max-speed", &bdev->oper_speed);
+
+	err = device_property_read_u8(bdev->dev, "brcm,bt-sco-routing",
+				      &bdev->pcm_params.routing);
+	if (!err)
+		bdev->has_pcm_params = true;
+
+	device_property_read_u8(bdev->dev, "brcm,pcm-interface-rate",
+				&bdev->pcm_params.rate);
+	device_property_read_u8(bdev->dev, "brcm,pcm-frame-type",
+				&bdev->pcm_params.frame_sync);
+	device_property_read_u8(bdev->dev, "brcm,pcm-sync-mode",
+				&bdev->pcm_params.sync_mode);
+	device_property_read_u8(bdev->dev, "brcm,pcm-clock-mode",
+				&bdev->pcm_params.clock_mode);
+
 	return 0;
 }
 
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

