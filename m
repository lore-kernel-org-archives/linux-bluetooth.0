Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B860C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Mar 2022 20:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiC2USc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Mar 2022 16:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiC2USc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Mar 2022 16:18:32 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DA6122218
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 13:16:49 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x31so10302623pfh.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 13:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OhTLU7UuQVtBUkHtCDONKolw4/z+Tccm9QLNKcrlREY=;
        b=fwMLpu6uYTeGezy5OXw2iLMyxoKjejvpR9hbK8GnHLDGt2kVRhsA9VJ/G3QIDNy6Sl
         pWFmQY6xyKYQfhTGIoX1UWqh+LxH/Je7WIgy7v5vU+kqTsuftYz5fWOLTkBAp3t4Ab2h
         kJU5cSoARddH9Sl0aZZDMELPbFrJSSZGs3e0kY90Peo5Hru2h8piCGoRU0uAp/whRCJ7
         0GzH7Bi5a9AbghPDDHeAAf760X+n3vbGOug1Wtiw8wPS4JAbJ3ztzRERdrRR4B2eKpIE
         aXjUDiiF4oiBAk9gs+O18qKmqKJ13HYep2IJZkvcMkuOXzHQoZrBoMu/yviMBZQR/jiV
         P1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OhTLU7UuQVtBUkHtCDONKolw4/z+Tccm9QLNKcrlREY=;
        b=0KfnKstNDJ+qZTy2YDM8fDomlTMb4Ij2WlYrXaXtRnjR33gFaZ02F2ugpkgLbx/xSt
         nTGxC5rDsDPWwTkGjgxrQvlK+CFKXFfO/tAHZjfjv3aMqq4kdWtTatCcgCaxdOCymdc2
         IaXWJN+NBe3DZgaQfEMscEYK3sRwucr3JbTBJ1TaFTY5SQ7p2KfWW1pQZi8tEn6EbMSG
         dAZXcgpRnuy/FxTJLt8PsPc0/hOJasZ2y/JP7rIaco+kNkJNs5LGbOUdOpU0ukK/WM9c
         zSVCuGsy4E8vGBwFUtJ2JzcguNPax2IB8CIXQUPHVdRmkKGRChGlIo72UvTS0cuc73Qj
         hhJQ==
X-Gm-Message-State: AOAM531Kk+lJtb3A3gtsbQj2Vkn0BZjL+/hYDk6dXi0rsYH/ZIQA7n3T
        zx+ZkISu22sDdVNZtdL404qP6D31imM=
X-Google-Smtp-Source: ABdhPJz194nKdUDvllSS/YrMxz6nUx46rsVn7tJ/Y1Lxp5ld0ao82n+U4/qacKL4JP+9Qz7IEtokLQ==
X-Received: by 2002:a63:2cd1:0:b0:386:5a8a:9ff4 with SMTP id s200-20020a632cd1000000b003865a8a9ff4mr3236055pgs.129.1648585008292;
        Tue, 29 Mar 2022 13:16:48 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm20816270pfh.83.2022.03.29.13.16.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 13:16:47 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] Bluetooth: Print broken quirks
Date:   Tue, 29 Mar 2022 13:16:45 -0700
Message-Id: <20220329201646.2296314-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329201646.2296314-1-luiz.dentz@gmail.com>
References: <20220329201646.2296314-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_sync.c | 66 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 8f4c5698913d..8994ff1f94e6 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3825,6 +3825,67 @@ static int hci_init_sync(struct hci_dev *hdev)
 	return 0;
 }
 
+#define HCI_QUIRK_BROKEN(_quirk, _desc) \
+{ \
+	.quirk = _quirk, \
+	.desc = _desc, \
+}
+
+static const struct hci_quirk_broken {
+	unsigned long quirk;
+	const char *desc;
+} hci_broken_table[] = {
+	HCI_QUIRK_BROKEN(HCI_QUIRK_BROKEN_LOCAL_COMMANDS,
+			 "HCI Read Local Supported Commands not supported"),
+	HCI_QUIRK_BROKEN(HCI_QUIRK_BROKEN_STORED_LINK_KEY,
+			 "HCI Delete Stored Link Key command is advertised, "
+			 "but not supported."),
+	HCI_QUIRK_BROKEN(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING,
+			 "HCI Read Default Erroneous Data Reporting command is "
+			 "advertised, but not supported."),
+	HCI_QUIRK_BROKEN(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER,
+			 "HCI Read Transmit Power Level command is advertised, "
+			 "but not supported."),
+	HCI_QUIRK_BROKEN(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL,
+			 "HCI Set Event Filter command not supported."),
+	HCI_QUIRK_BROKEN(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN,
+			 "HCI Enhanced Setup Synchronous Connection command is "
+			 "advertised, but not supported.")
+};
+
+static void hci_dev_print_broken_quirks(struct hci_dev *hdev)
+{
+	int i;
+
+	bt_dev_dbg(hdev, "");
+
+	for (i = 0; i < ARRAY_SIZE(hci_broken_table); i++) {
+		const struct hci_quirk_broken *broken = &hci_broken_table[i];
+
+		if (test_bit(broken->quirk, &hdev->quirks))
+			bt_dev_warn(hdev, "%s", broken->desc);
+	}
+}
+
+static int hci_dev_setup_sync(struct hci_dev *hdev)
+{
+	bt_dev_dbg(hdev, "");
+
+	hci_sock_dev_event(hdev, HCI_DEV_SETUP);
+
+	if (hdev->setup) {
+		int ret;
+
+		ret = hdev->setup(hdev);
+		if (ret)
+			return ret;
+
+		hci_dev_print_broken_quirks(hdev);
+	}
+
+	return 0;
+}
+
 int hci_dev_open_sync(struct hci_dev *hdev)
 {
 	int ret = 0;
@@ -3887,10 +3948,7 @@ int hci_dev_open_sync(struct hci_dev *hdev)
 	    test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
 		bool invalid_bdaddr;
 
-		hci_sock_dev_event(hdev, HCI_DEV_SETUP);
-
-		if (hdev->setup)
-			ret = hdev->setup(hdev);
+		ret = hci_dev_setup_sync(hdev);
 
 		/* The transport driver can set the quirk to mark the
 		 * BD_ADDR invalid before creating the HCI device or in
-- 
2.35.1

