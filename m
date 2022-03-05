Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52BAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Mar 2022 01:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiCEBXe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Mar 2022 20:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiCEBX2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Mar 2022 20:23:28 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38003656A
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 17:22:39 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id s11so8982212pfu.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Mar 2022 17:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Hl0evxxrqp/Qfdb5sN8zGAfs6IrTTpCQEbp1CLx/B74=;
        b=KbZ4LOrERifi50YqDZOiZnPSeNVA8ZqKxDhspUkftd6i0RVsg8ZNlod/03BQPn+xHX
         8HZsruhUUTq3LmRH0IpRmw8T0vpuy0Sj/JAFbWKkyPZKhiqghUn451L1dn/zg58ZveUp
         gK1LefIKxvgslhv2bZUHAI19TTHtHAkhHaeEK+QL4Nc2qMBu+WSWKX1G2WLgZFQGOGdN
         VYcqTX3W6vBZrkZPKy807SwZRSVHS+HF6n/tCGNlsJs7jbiQmIZdnZGl9uYSqxIr7Acj
         s3W3SCUCi3qbB6ffKDrAPcG9fvbDIAjK7jdYFILN+kbKmxw8mj6wnmoU7ZyexfziaTFS
         4iJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hl0evxxrqp/Qfdb5sN8zGAfs6IrTTpCQEbp1CLx/B74=;
        b=YRiwyXUhCR+LtBVNzFbCcjhVcUJ2EtroXfVipm/tptBq8+fWXfdTUhGbXyGeX4CCmf
         AdvVUno5C3eldMOonHmTbmcMddk7CCJeqCFqtt5mTNZSv/nl5Nk1NCtlDCL+uuE43iqY
         o/tChhSWfLoPta6v1riLHXc0+sxdO77fU+tZ6uqL7wMmfqcccGVctH+xCQLwiHEjBR7T
         9MTsZHUxJMRnxktTzHiZeOr88McW6+T/lSiR036h1z6qxmEGfMRw+9ZfGZJMxwpO4Nhb
         suZ1YXC07wzbDnzyEuJg+AfAr1SuLoJed6GxJI+qg5nWY8Ni8Tt849x2I1KzaGxiX0OJ
         Pgyg==
X-Gm-Message-State: AOAM533zai877ElCvBx+AJAyhD92reTixrFibBz1s5DdOHo+7GnrenEW
        UhJ5UKrHRjIQ/40rKMZW5LajxqeNk6k=
X-Google-Smtp-Source: ABdhPJxiVxlUwXP+uOwz1CF5JvdMCAg84b+EXR+Fp08GkGR3epOe6buXEb7vcEUXPKHEJOSY84JOXA==
X-Received: by 2002:a63:2a96:0:b0:37c:46b0:add7 with SMTP id q144-20020a632a96000000b0037c46b0add7mr933904pgq.50.1646443358484;
        Fri, 04 Mar 2022 17:22:38 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m16-20020a638c10000000b0037c4cf366c0sm5363932pgd.61.2022.03.04.17.22.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 17:22:38 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 09/12] btdev: Implements BT_HCI_CMD_LE_BIG_TERM_SYNC
Date:   Fri,  4 Mar 2022 17:22:26 -0800
Message-Id: <20220305012229.853784-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220305012229.853784-1-luiz.dentz@gmail.com>
References: <20220305012229.853784-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This sends BT_HCI_EVT_DISCONNECT_COMPLETE when handling
BT_HCI_CMD_LE_BIG_TERM_SYNC.
---
 emulator/btdev.c | 39 +++++++++++++++++++++++++++++++++++++--
 monitor/bt.h     |  5 +++++
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 567377caa..6834ec1c2 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -6055,8 +6055,43 @@ static int cmd_big_create_sync_complete(struct btdev *dev, const void *data,
 
 static int cmd_big_term_sync(struct btdev *dev, const void *data, uint8_t len)
 {
-	/* TODO */
-	return -ENOTSUP;
+	const struct bt_hci_cmd_le_big_term_sync *cmd = data;
+	struct bt_hci_rsp_le_big_term_sync rsp;
+	const struct queue_entry *entry;
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	/* If the Host issues this command with a BIG_Handle that does not
+	 * exist, the Controller shall return the error code Unknown
+	 * Advertising Identifier (0x42).
+	 */
+	if (dev->big_handle != cmd->handle) {
+		rsp.status = BT_HCI_ERR_UNKNOWN_ADVERTISING_ID;
+		goto done;
+	}
+
+	rsp.status = BT_HCI_ERR_COMMAND_DISALLOWED;
+	rsp.handle = cmd->handle;
+
+	/* Cleanup existing connections */
+	for (entry = queue_get_entries(dev->conns); entry;
+					entry = entry->next) {
+		struct btdev_conn *conn = entry->data;
+
+		if (!conn->data)
+			continue;
+
+		rsp.status = BT_HCI_ERR_SUCCESS;
+		disconnect_complete(dev, conn->handle, BT_HCI_ERR_SUCCESS,
+								0x16);
+
+		conn_remove(conn);
+	}
+
+done:
+	cmd_complete(dev, BT_HCI_CMD_LE_BIG_TERM_SYNC, &rsp, sizeof(rsp));
+
+	return 0;
 }
 
 static int cmd_req_peer_sca(struct btdev *dev, const void *data, uint8_t len)
diff --git a/monitor/bt.h b/monitor/bt.h
index 3bee11868..6ce6384a4 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2817,6 +2817,11 @@ struct bt_hci_cmd_le_big_term_sync {
 	uint8_t  handle;
 } __attribute__ ((packed));
 
+struct bt_hci_rsp_le_big_term_sync {
+	uint8_t  status;
+	uint8_t  handle;
+} __attribute__ ((packed));
+
 #define BT_HCI_CMD_LE_REQ_PEER_SCA		0x206d
 #define BT_HCI_BIT_LE_REQ_PEER_SCA		BT_HCI_CMD_BIT(43, 2)
 struct bt_hci_cmd_le_req_peer_sca {
-- 
2.35.1

