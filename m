Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EA8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Mar 2022 18:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiC3S3T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Mar 2022 14:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351728AbiC3S3F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Mar 2022 14:29:05 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9834D9EB
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 11:25:54 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id bo5so69895pfb.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 11:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OfwNIGOKqJblu5U4H8BCSE4eIec5ZuLanyU6of7IWus=;
        b=ORsX9I/P1zUFLnv7BgjZya7YbQ07Qu8KSXsffQkD2mdW6xcsKNHUSGEAkIRBtcRPYV
         2U2AMcwiGNcdZgJc9Sun0p/B0gI7qRfe+WedACqD5KlUsMVo0jCLr09HlKVtSjIBxsY1
         UFPjkm69BEl8etJtthG0VKg8OSsD6pbUw0itlXNb2EzDQR9zJzSalo2wcMNShj9tURvZ
         Qr+YIalXu9q5rI1+5SkhpFLI+sqtrjerXqiY4CDMc0M07JrgOYl2fgPJQgYdIHPlusAB
         rRuuRJOOXaWzUuuGeke9HWa8HJ5s8i5Zjmn3rrx4/h58kXeRvONn21OoqN+Ey2ODEAHS
         jAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OfwNIGOKqJblu5U4H8BCSE4eIec5ZuLanyU6of7IWus=;
        b=wQ9osGCiODyCBPT3R+zx9jiO8VZlhG72pr43PirBkucjzCbpV1gDku9w2eGelCYbGl
         43E5MOBjo4tzZJCfJYR4ZnAbRKh5xTG4/W4qKJ29ZjdAvKTKHdzBvFEeAR8xHUAARacX
         JIu5XzE8JCC/E4LdOs+g+xuvTABS7wzotZJNLobzpo+8k5bXi0mUm7x+XKiGtE9qSiny
         BdN94HlkxNTCyCO/rnrcgSWaPOojWB8iLKA1ckRLazGzYLMNbh7qcfelXIV4Jl/L6RCO
         JefP2bw15Zl6gcSxpOLKjBuH2+eQ/p8U87psl30S11hmy5QuUW8V2XNVY7f6ygEQeFfZ
         Z+lg==
X-Gm-Message-State: AOAM531dGPPK8QFKMmpk9rDc5kTTwJ6y9PAWvm3owykNgJ6ZlCOWYQSG
        gT8clprGD2GstXm/6zWjLiTtfmfraiM=
X-Google-Smtp-Source: ABdhPJwYA5rsfQeZOuf4cE/1DnFBP5CH8jP2FwBY0Cfihovvckq9DOW+C18i+8ktc4/WmfwduIoHwg==
X-Received: by 2002:a63:b40a:0:b0:35e:d274:5f54 with SMTP id s10-20020a63b40a000000b0035ed2745f54mr3325980pgf.200.1648664753871;
        Wed, 30 Mar 2022 11:25:53 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a000a8200b004f1111c66afsm26758551pfl.148.2022.03.30.11.25.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 11:25:53 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/3] Bluetooth: Print broken quirks
Date:   Wed, 30 Mar 2022 11:25:51 -0700
Message-Id: <20220330182552.2613523-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330182552.2613523-1-luiz.dentz@gmail.com>
References: <20220330182552.2613523-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_sync.c | 53 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 8f4c5698913d..e97880d7bdb2 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3825,6 +3825,54 @@ static int hci_init_sync(struct hci_dev *hdev)
 	return 0;
 }
 
+#define HCI_QUIRK_BROKEN(_quirk, _desc) { HCI_QUIRK_BROKEN_##_quirk, _desc }
+
+static const struct {
+	unsigned long quirk;
+	const char *desc;
+} hci_broken_table[] = {
+	HCI_QUIRK_BROKEN(LOCAL_COMMANDS,
+			 "HCI Read Local Supported Commands not supported"),
+	HCI_QUIRK_BROKEN(STORED_LINK_KEY,
+			 "HCI Delete Stored Link Key command is advertised, "
+			 "but not supported."),
+	HCI_QUIRK_BROKEN(ERR_DATA_REPORTING,
+			 "HCI Read Default Erroneous Data Reporting command is "
+			 "advertised, but not supported."),
+	HCI_QUIRK_BROKEN(READ_TRANSMIT_POWER,
+			 "HCI Read Transmit Power Level command is advertised, "
+			 "but not supported."),
+	HCI_QUIRK_BROKEN(FILTER_CLEAR_ALL,
+			 "HCI Set Event Filter command not supported."),
+	HCI_QUIRK_BROKEN(ENHANCED_SETUP_SYNC_CONN,
+			 "HCI Enhanced Setup Synchronous Connection command is "
+			 "advertised, but not supported.")
+};
+
+static int hci_dev_setup_sync(struct hci_dev *hdev)
+{
+	size_t i;
+
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
+	}
+
+	for (i = 0; i < ARRAY_SIZE(hci_broken_table); i++) {
+		if (test_bit(hci_broken_table[i].quirk, &hdev->quirks))
+			bt_dev_warn(hdev, "%s", hci_broken_table[i].desc);
+	}
+
+	return 0;
+}
+
 int hci_dev_open_sync(struct hci_dev *hdev)
 {
 	int ret = 0;
@@ -3887,10 +3935,7 @@ int hci_dev_open_sync(struct hci_dev *hdev)
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

