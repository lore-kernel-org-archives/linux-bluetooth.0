Return-Path: <SRS0=mBsK=AM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F9EC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 22:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 687C420780
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 22:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="obwcbVEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgGAWI6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Jul 2020 18:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgGAWI5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Jul 2020 18:08:57 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05DAC08C5C1
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2020 15:08:57 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id u133so638735vsc.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2020 15:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K9SoVgLaXTOuNBg/am0VwKPBGo7WwjBx/4VauGhgdfs=;
        b=obwcbVEWRj3UW5eiy1ypSu6BqSlU937IPIHoxW3XA9ESlcz8HvcQSPTXGuO369mmHx
         xUuFadHywnYVncOEbvFb1x4KKMvQLi7Te2vrRPKv+yLisudxiiSAlc/g9cioUVHpBGL5
         r5NA4IGOYyjlAoDNXsWNpram/JRi8DT5Jdroc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K9SoVgLaXTOuNBg/am0VwKPBGo7WwjBx/4VauGhgdfs=;
        b=mjtfv7N14Prtk9fuCAa1O4qySXKMEBCI7FuxfCo6PbVqRRhFGz81rQtYa0VRS7/F26
         ReuP/ZUYJaDh36vV/uYjO3MxxBXa3WGT5X6vDrRYrJ5ocpDq+IE8wKmr5Rv5830uGAXm
         mggGPZh+BdYj8XXYhRCYH2LZSZRpU0Gc92a4YF6mPXxDkIpLSZVguKj5cffa0fhCzJXJ
         B0Q3nSRC2gHJuU6StcfXGQ6Iirrd5O0V3myXjprpDA38cLHY/QpPxxmtvyCQdB4F0TAW
         Fni2M7f3dNdumyyhM7LxIg4TG19t4XeodzydBjCQYxu8cORo2JyMOoLmeBsZFs7Jqx8j
         tjpg==
X-Gm-Message-State: AOAM532asJ/8XLLIUpe2kLlueXxEZfCCVfCfizKF9Y+gkNXHteTNHO4T
        BjlMR5cOhLNPZYOQRj5Ne02be5cUuiw=
X-Google-Smtp-Source: ABdhPJzPFVgnIBDBIw+hIlNvpDcdeS3BnnjhNdV6hClAXd+GbnTdIsgBlNp6CroCBv3wahfYyMtDUA==
X-Received: by 2002:a67:d519:: with SMTP id l25mr20403031vsj.176.1593641336533;
        Wed, 01 Jul 2020 15:08:56 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id s4sm976678vsc.11.2020.07.01.15.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 15:08:55 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v2] Bluetooth: le_supported_roles experimental feature
Date:   Wed,  1 Jul 2020 22:08:53 +0000
Message-Id: <20200701220853.421445-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds an le_supported_roles features which allows a
clients to determine if the controller is able to support peripheral and
central connections separately and at the same time.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

Changes in v2:
 - Slight change of design based on offline feedback

 net/bluetooth/mgmt.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5e9b9728eeac..c13fcc21745f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3753,10 +3753,36 @@ static const u8 debug_uuid[16] = {
 };
 #endif
 
+/* 671b10b5-42c0-4696-9227-eb28d1b049d6 */
+static const u8 le_supported_roles[16] = {
+	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb, 0x27, 0x92,
+	0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67,
+};
+
+static u32 get_le_roles_flags(struct hci_dev *hdev)
+{
+	u32 flags = 0;
+
+	/* Central connections supported */
+	if (hdev->le_states[4] & 0x08)
+		flags |= BIT(0);
+
+	/* Peripheral connections supported */
+	if (hdev->le_states[4] & 0x40)
+		flags |= BIT(1);
+
+	/* Simult central and peripheral connections supported */
+	if (test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks) &&
+	    (hdev->le_states[3] & 0x10))
+		flags |= BIT(2);
+
+	return flags;
+}
+
 static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 				  void *data, u16 data_len)
 {
-	char buf[42];
+	char buf[44];
 	struct mgmt_rp_read_exp_features_info *rp = (void *)buf;
 	u16 idx = 0;
 
@@ -3774,6 +3800,14 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 	}
 #endif
 
+	if (hdev) {
+		memcpy(rp->features[idx].uuid, le_supported_roles,
+		       sizeof(le_supported_roles));
+
+		rp->features[idx].flags = cpu_to_le32(get_le_roles_flags(hdev));
+		++idx;
+	}
+
 	rp->feature_count = cpu_to_le16(idx);
 
 	/* After reading the experimental features information, enable
-- 
2.27.0.212.ge8ba1cc988-goog

