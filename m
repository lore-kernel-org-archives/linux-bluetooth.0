Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCB9C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Apr 2022 23:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353425AbiDAXkZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Apr 2022 19:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353431AbiDAXkV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Apr 2022 19:40:21 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E822AC4
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Apr 2022 16:38:30 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id x9so3044905ilc.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Apr 2022 16:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5h+itaPpaVusfkPsF6oYH8QwyThNAc1BGn7bHzjyg/8=;
        b=CC5fZsAGmOciHdt+CEhL/wCHZzd28dNilLcDsanszFecm8RhUlgcY+cSh8mvF8b1tG
         ycZR1+9nct1wRRr6cKydQ9RmR7wC+g87mK7YLEIFPkVYBAEmL4DdBrrPY6UROHzjgWFp
         Zx4jdwb/2J7s5HIST6ymM5Tcv7F1TFNFWnwoBF/m4YQTaGrpAcwOVyJB22u1FDlBaz5W
         SmVfsOxhJ63pQeTE1lI8p9V0zEqInjnjt+Y7x0P7RldVLNBuviIIWR72Y0ivznAtAWmW
         34AOF121glfXXFP/JM9HNvVuWidCf7RRETE2puqZ1R+Ws6qXlHBNymM4HWohbG78YEY1
         bHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5h+itaPpaVusfkPsF6oYH8QwyThNAc1BGn7bHzjyg/8=;
        b=MiTETrw0WrmUwDRnmj/uqmkH2Lr0ZvpVD1V3hSFfob/TteLCeLCjKgv0+P2efQui12
         bIhnmOO7a9Yzv/YZUp0ZYJ/tQr3qA+hp8Epv4SyTwzC9QTGGBj9yMjs5q1dUI48/JnRb
         u4p5cg21mi9FgppGMWJBu0b1Eqn5HGM1msFGCtZ12C3zoh8saZUY4pXowx33w4j2/yyt
         xwtBGA5U7EYDHUtDsh4y8FQUEHcK1FhhTn9RAwCcMAT+uL7XwoS/vhu3qwIEQ6X4efKm
         9S0Vb07A9oRVZ0NMZRW9bOXqpfyiRM8W8zY7XSeZdNwhnGKYJVKHZY1IDdirBCGvPi60
         CoVg==
X-Gm-Message-State: AOAM530VLfD3oSuUKvxgQ+rIHudFua9MtSKZDW8QjKTTq1Qh71M4Kshe
        Mv7AEpU7hbfnFIm+w54vK6ZmrQCCSMI=
X-Google-Smtp-Source: ABdhPJwsXWTt5af9NMwZ77CBQNMxiFCd00VnQCOTbaWzEQWYdpk6v2Le6yqw3VaEJZ6sbajkcajTdw==
X-Received: by 2002:a05:6e02:1c8e:b0:2ca:b36:19f8 with SMTP id w14-20020a056e021c8e00b002ca0b3619f8mr907808ill.203.1648856309217;
        Fri, 01 Apr 2022 16:38:29 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b19-20020a5d8553000000b00649f02b1b0csm2217062ios.39.2022.04.01.16.38.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 16:38:28 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/4] Bluetooth: Print broken quirks
Date:   Fri,  1 Apr 2022 16:38:24 -0700
Message-Id: <20220401233826.122544-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220401233826.122544-1-luiz.dentz@gmail.com>
References: <20220401233826.122544-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_sync.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 8f4c5698913d..5610ec1242d6 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3825,6 +3825,30 @@ static int hci_init_sync(struct hci_dev *hdev)
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
 int hci_dev_open_sync(struct hci_dev *hdev)
 {
 	int ret = 0;
@@ -3886,12 +3910,19 @@ int hci_dev_open_sync(struct hci_dev *hdev)
 	if (hci_dev_test_flag(hdev, HCI_SETUP) ||
 	    test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
 		bool invalid_bdaddr;
+		size_t i;
 
 		hci_sock_dev_event(hdev, HCI_DEV_SETUP);
 
 		if (hdev->setup)
 			ret = hdev->setup(hdev);
 
+		for (i = 0; i < ARRAY_SIZE(hci_broken_table); i++) {
+			if (test_bit(hci_broken_table[i].quirk, &hdev->quirks))
+				bt_dev_warn(hdev, "%s",
+					    hci_broken_table[i].desc);
+		}
+
 		/* The transport driver can set the quirk to mark the
 		 * BD_ADDR invalid before creating the HCI device or in
 		 * its setup callback.
-- 
2.35.1

