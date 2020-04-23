Return-Path: <SRS0=6Duj=6H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB736C54FD0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 21:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAA6120724
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 21:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6Sj4Hpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgDWVzJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgDWVzI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Apr 2020 17:55:08 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DF7C09B042
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 14:55:08 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x77so3691627pfc.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 14:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=w0VM6HpkuAzq7+rMk+7jnjDTZrAvvMg7HoEcEum2Phc=;
        b=a6Sj4Hpbqi2TgjgDdmp6x4KsPDGr51IwLFoD0gFfyVzXr6PmGWX8zihHH51PEJEd9N
         lDmFlz9bcWhSSoEjqeYYdHgjW5heGcofTQJPFrqxqJy49kOFRv6biHsK5LiN73/oURzG
         ClVTU/sx/Z+eJnqdmJcE6e9B0maxR5p6V6z9ZEMYFss+wyCsA3PAGmgFcZTM7WB3pHhD
         6zkJsav+hVbhlofgsxwjU21WOwG5z/RnWaMnh4D1+KH/37zoag08IHRdKVTIr4wAw0tx
         1yAkN5QhKlnDymNZvqy54sAKKpMuuK/SFAMRW8fHeXyXmpYr3jXnxJ8ztisI3DksgEee
         A4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w0VM6HpkuAzq7+rMk+7jnjDTZrAvvMg7HoEcEum2Phc=;
        b=GZ6Fx21lS77o5uSrS5VcpKQha4zF9QA2W3aUGMHSFH2HXH7lgFF/7QowpzoCTe91VT
         93Bzf66DhHQrzigrj1ogkYfcisB+qGjVsI3R3zEQlLh84TfWlWHnFGBT8ZP0citkThZx
         qMisLgpbhIw/Yl3BoGaurAB4YGlR1xOS513f+GHcPqx4tGya8hYv/q5mY/i43+j0jTja
         uSO5b+K/TA9qtgF6iSWUUbl3TZaRUpxAg0T0rAhsl79ZfYoD+XFEcPmPeXl1vNVlsik5
         5FaPTeAL2dyiUeycoSc96hb1QQesTcqYCWoiDQN+DP86e5ErsNdvAPLG89vx8iMfj95s
         v2kg==
X-Gm-Message-State: AGi0PuaWI91Y+vpU4WGFY74HM9OwOvE6HnHGdaP2VcKGLLLqrKYxaTW1
        D8K6buUzZYDkfKykYdehQ8ZPKLogUe8=
X-Google-Smtp-Source: APiQypJMxSA6sgEvRgqq9MA5LpLEiBhDu6ZNdUX9FTs3SYBkQWEVwcOJ5j3HJO2t2mLBUP2pvMf2CQ==
X-Received: by 2002:a63:e942:: with SMTP id q2mr5836733pgj.34.1587678907819;
        Thu, 23 Apr 2020 14:55:07 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id k12sm2972294pgj.33.2020.04.23.14.55.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 14:55:07 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/6] emulator: Add support for LE Setup ISO Data Path
Date:   Thu, 23 Apr 2020 14:55:00 -0700
Message-Id: <20200423215501.427266-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200423215501.427266-1-luiz.dentz@gmail.com>
References: <20200423215501.427266-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements support for LE Setup ISO Data Path command.
---
 emulator/btdev.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index cd355e73a..1b3ad6442 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -148,6 +148,7 @@ struct btdev {
 		struct bt_hci_cmd_le_set_cig_params params;
 		struct bt_hci_cis_params cis;
 	} __attribute__ ((packed)) le_cig;
+	uint8_t  le_iso_path[2];
 
 	uint8_t le_local_sk256[32];
 
@@ -2418,6 +2419,38 @@ static void btdev_reset(struct btdev *btdev)
 	btdev->le_adv_enable		= 0x00;
 }
 
+static void le_setup_iso_path(struct btdev *dev, uint16_t handle,
+					uint8_t dir, uint8_t path)
+{
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	if (!dev->conn || handle != ISO_HANDLE) {
+		status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		goto done;
+	}
+
+	/* Only support HCI or disabled paths */
+	if (path && path != 0xff) {
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	switch (dir) {
+	case 0x00:
+		dev->le_iso_path[0] = path;
+		break;
+	case 0x01:
+		dev->le_iso_path[1] = path;
+		break;
+	default:
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+	}
+
+done:
+	cmd_complete(dev, BT_HCI_CMD_LE_SETUP_ISO_PATH, &status,
+						sizeof(status));
+}
+
 static void default_cmd(struct btdev *btdev, uint16_t opcode,
 						const void *data, uint8_t len)
 {
@@ -2541,6 +2574,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		struct bt_hci_rsp_le_set_cig_params params;
 		uint16_t handle;
 	} __attribute__ ((packed)) lscp;
+	struct bt_hci_cmd_le_setup_iso_path *lesip;
 	uint8_t status, page;
 
 	switch (opcode) {
@@ -3862,6 +3896,17 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 
 		break;
 
+	case BT_HCI_CMD_LE_SETUP_ISO_PATH:
+		if (btdev->type != BTDEV_TYPE_BREDRLE52)
+			goto unsupported;
+
+		lesip = (void *)data;
+
+		le_setup_iso_path(btdev, le16_to_cpu(lesip->handle),
+					lesip->direction, lesip->path);
+
+		break;
+
 	case BT_HCI_CMD_LE_SET_HOST_FEATURE:
 		if (btdev->type != BTDEV_TYPE_BREDRLE52)
 			goto unsupported;
-- 
2.25.3

