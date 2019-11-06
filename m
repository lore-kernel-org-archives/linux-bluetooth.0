Return-Path: <SRS0=igZI=Y6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE25AC5DF60
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Nov 2019 00:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595EC21D7C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Nov 2019 00:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZOQEjBet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbfKFAaL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Nov 2019 19:30:11 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43831 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730620AbfKFAaJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Nov 2019 19:30:09 -0500
Received: by mail-pf1-f196.google.com with SMTP id 3so17406882pfb.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Nov 2019 16:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qn/J/1PPzN9yYPx8ms3UdKQj06L6swPahcKzYXCyGo4=;
        b=ZOQEjBetAhlpeBEjjy35YzhHVGrbMEHXWH4SxMAcEk6gHOyX7cYfh0qG3+v3Gnxete
         swT0iYfkaaiadSbE9Sqn6OK0nwyZ9P3n6d9NzICQ6h5urypunAwaZBqNk6fuXPcAgtEr
         FuKAnkmA3RLkbRVUYXbtQPDrh8e+iM3AsTFHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qn/J/1PPzN9yYPx8ms3UdKQj06L6swPahcKzYXCyGo4=;
        b=INUDN1qimyTiPP04g0Stgq1iVV/QjuLwJhbi7HTcTu23F5adoBgdjkGZft9tVW5UaN
         aCGwtjHj1Ds0n5ns8XQHWEED84iOngVx6BmwFh7c4CBbDMSHx27ORfPEpG1rqxx+FgSQ
         aFid6K2KF0Cew0bQ3+WVBGwy8GQpCLJwy42Ts63Vg49py3p/jGJt2NBbtUq7FVL+2LIW
         gKQwlVH06A2R2paZZPEjrigvp2Y+rZx+GEjwj3woBF4E56acdEnRhrFlcaeqf6XErHyv
         0cAlFFMBqTm9AQPwYHHKUi3iNRyjRirjU27OQtTjKgTHVWQPjEv89HPEt/an0RRPzhx0
         gRfw==
X-Gm-Message-State: APjAAAU7dUUXM2f9fF9g3hzF2IzvMRaL6pamo632BhwIFaB94M9uNYEe
        yfH7/XzFvYtpm/+RVTtxR92nYw==
X-Google-Smtp-Source: APXvYqz5mZO2Oz5hXUS9MiNZ+n6TppXtk7hqUvUmmoCt0zqNVUdHs6HA1fpCBkFRp53KYB3tWDd6IQ==
X-Received: by 2002:a63:ff26:: with SMTP id k38mr40736136pgi.128.1573000208956;
        Tue, 05 Nov 2019 16:30:08 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id k9sm21032835pfk.72.2019.11.05.16.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 16:30:08 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: hci_bcm: Support pcm params in dts
Date:   Tue,  5 Nov 2019 16:29:22 -0800
Message-Id: <20191106002923.109344-4-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191106002923.109344-1-abhishekpandit@chromium.org>
References: <20191106002923.109344-1-abhishekpandit@chromium.org>
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

 drivers/bluetooth/hci_bcm.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 4fe66e52927d..e94908a7e407 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -79,6 +79,7 @@
  * @hu: pointer to HCI UART controller struct,
  *	used to disable flow control during runtime suspend and system sleep
  * @is_suspended: whether flow control is currently disabled
+ * @pcm_params: Bytestring of pcm int and format params.
  */
 struct bcm_device {
 	/* Must be the first member, hci_serdev.c expects this. */
@@ -112,6 +113,9 @@ struct bcm_device {
 	struct hci_uart		*hu;
 	bool			is_suspended;
 #endif
+
+	bool			has_pcm_params;
+	u8			pcm_params[BCM_PCM_PARAMS_COUNT];
 };
 
 /* generic bcm uart resources */
@@ -529,6 +533,8 @@ static int bcm_setup(struct hci_uart *hu)
 	const struct firmware *fw;
 	unsigned int speed;
 	int err;
+	struct bcm_set_pcm_int_params int_params;
+	struct bcm_set_pcm_format_params format_params;
 
 	bt_dev_dbg(hu->hdev, "hu %p", hu);
 
@@ -576,6 +582,23 @@ static int bcm_setup(struct hci_uart *hu)
 			host_set_baudrate(hu, speed);
 	}
 
+	/* PCM parameters if any*/
+	if (bcm->dev && bcm->dev->has_pcm_params) {
+		memcpy(&int_params, &(bcm->dev->pcm_params[0]),
+		       sizeof(int_params));
+		memcpy(&format_params, &(bcm->dev->pcm_params[5]),
+		       sizeof(format_params));
+
+		err = btbcm_set_pcm_params(hu->hdev, &int_params,
+					   &format_params);
+
+		if (err) {
+			bt_dev_info(hu->hdev, "BCM: Set pcm params failed (%d)",
+				    err);
+		}
+
+	}
+
 finalize:
 	release_firmware(fw);
 
@@ -1112,7 +1135,15 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 
 static int bcm_of_probe(struct bcm_device *bdev)
 {
+	int plen;
+
 	device_property_read_u32(bdev->dev, "max-speed", &bdev->oper_speed);
+	plen = device_property_read_u8_array(bdev->dev, "pcm-parameters",
+					     bdev->pcm_params,
+					     BCM_PCM_PARAMS_COUNT);
+	if (plen == 0)
+		bdev->has_pcm_params = true;
+
 	return 0;
 }
 
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

