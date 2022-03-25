Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC67C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Mar 2022 21:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiCYVOx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Mar 2022 17:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiCYVOw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Mar 2022 17:14:52 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243C033345
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 14:13:17 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id k14so7425276pga.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 14:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MhU2Pfja8KJMxCzNCsyf0c4V4oVBFH42tFVi+3QvVCo=;
        b=lUTPXMVYmX1QayXI5+NnHApi+Ixr/FlJhR2OZINLSWtsKNhhvsujVuJ6gdxxVEXjFr
         xBGJIPlVgAFhC9Nm+yn5xcquL/35p8OPy4QY4GTcLBCGIM//UXGCo8iDcTq3l6vjZdUi
         ymejc/ycp6PpK9GQgh6fC7hfFmf3vk/dQnTMTyiLe6hVPGLZbZTF+qM85WQ2PAHu+yc5
         SO6unGfc8wOkJb4u1wsgpTzwuPVlYHD/l1BwI9K7Bs+sD2sLoku6v75f6xUjw2bCXTiM
         RrGzJKQXQt8NIIcrTH1Ax6cearOpQELVYpEoRL5S3i92UWPBDEd2E8+Rkkv4dotYgt5P
         VrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MhU2Pfja8KJMxCzNCsyf0c4V4oVBFH42tFVi+3QvVCo=;
        b=yqhAKB0zb1eW5AmhgWlA6y15wZj+x1p4KSw5+eEPunKoH59nepdXu3ab0VAem1xKxV
         YU9NUDJQ4AkSpew7Y87mgc54VJy16YUNdVglsYbIWjpl/4wJ8FM0rz91E8t585CqKR2y
         NhGYC3fR3enQ3HoY0ZCEfrbbciR+UiIeOqn2K1qcBDZ+y/dQ01aVNHlBo9dT7nzAws/B
         5nnsMI9+k9pghpJklMuLItszovh44V0D9l38lpqLw3YanssjFgvdcfgANCWmykwS6tkN
         iVEU/5urhFLmpn20KdJqm3pkz3VNphbZ7ms4tAP5AFw9ee0toV+S2zS1NDwboRly5hCp
         La9w==
X-Gm-Message-State: AOAM530s5d7ykdB8prifaoNoElYbJ15QGwpu80D7t+RzNtyHDhDRghmR
        8Mu7xPi2xYJ0DweqWwXrbrpRZTRBf7c=
X-Google-Smtp-Source: ABdhPJzs3g0dUWvtTETsnAAlErFDPdQNQQSL5i0UyO8Ewjghb7ZYE2hbahqcA8Vr+9nOohW4/7h8mA==
X-Received: by 2002:a62:684:0:b0:4f7:803:d1b0 with SMTP id 126-20020a620684000000b004f70803d1b0mr11934633pfg.10.1648242796333;
        Fri, 25 Mar 2022 14:13:16 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090a588600b001c699d77503sm6582009pji.2.2022.03.25.14.13.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 14:13:16 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Print broken quirks
Date:   Fri, 25 Mar 2022 14:13:14 -0700
Message-Id: <20220325211314.425364-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325211314.425364-1-luiz.dentz@gmail.com>
References: <20220325211314.425364-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This prints warnings for controllers setting broken quirks to increase
their visibility and warn about broken controllers firmware that
probably needs updates to behave properly.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 8f4c5698913d..089500136096 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3825,6 +3825,48 @@ static int hci_init_sync(struct hci_dev *hdev)
 	return 0;
 }
 
+#define HCI_BROKEN(_quirk, _desc) \
+{ \
+	.quirk = _quirk, \
+	.desc = _desc, \
+}
+
+struct hci_broken {
+	unsigned long quirk;
+	const char *desc;
+} hci_broken_table[] = {
+	HCI_BROKEN(HCI_QUIRK_BROKEN_LOCAL_COMMANDS,
+		   "HCI Read Local Supported Commands not supported"),
+	HCI_BROKEN(HCI_QUIRK_BROKEN_STORED_LINK_KEY,
+		   "HCI Delete Stored Link Key command is advertised, "
+		   "but not supported."),
+	HCI_BROKEN(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING,
+		   "HCI Read Default Erroneous Data Reporting command is "
+		   "advertised, but not supported."),
+	HCI_BROKEN(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER,
+		   "HCI Read Transmit Power Level command is advertised, "
+		   "but not supported."),
+	HCI_BROKEN(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL,
+		   "HCI Set Event Filter command not supported."),
+	HCI_BROKEN(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN,
+		   "HCI Enhanced Setup Synchronous Connection command is "
+		   "advertised, but not supported.")
+};
+
+static void hci_dev_print_broken(struct hci_dev *hdev)
+{
+	int i;
+
+	bt_dev_dbg(hdev, "");
+
+	for (i = 0; i < ARRAY_SIZE(hci_broken_table); i++) {
+		struct hci_broken *broken = &hci_broken_table[i];
+
+		if (test_bit(broken->quirk, &hdev->quirks))
+			bt_dev_warn(hdev, "%s", broken->desc);
+	}
+}
+
 int hci_dev_open_sync(struct hci_dev *hdev)
 {
 	int ret = 0;
@@ -4031,6 +4073,8 @@ int hci_dev_open_sync(struct hci_dev *hdev)
 	}
 
 done:
+	hci_dev_print_broken(hdev);
+
 	return ret;
 }
 
-- 
2.35.1

