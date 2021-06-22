Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90235C49EA4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jun 2021 00:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 722CF610EA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jun 2021 00:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhFVAn1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jun 2021 20:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbhFVAn0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jun 2021 20:43:26 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5CAC06175F
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 17:41:11 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id u18so9659027pfk.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 17:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7HK2NBgKrTY5eJfpC7Iz55GsN4bxjtwWbBvF3BvVIsY=;
        b=V1aqfcZzANdyhzo/RhhGuOXvgh1wtMEwfrb65WwjvSB5EUhSpXdK46p8gmpb+ADYIT
         DV1UAd4H9ch8BVGUkyVSOdpEhI15awIq3yxt3LF9iVhbK0hKK9D1/k1GA9DGypS4MQ20
         gQnO3Em4A67nzB6Tx7JVvAJGtgsVfyQM/RPBjCIV2ctnVwcCo7TbCG4CjUY9YY8gCMDP
         /WQ/JXZSLqEoLKFmfvmJLDaEfB+/ltshotaQ+BdQzRbCkIhRi7yjhj0nLFQr4ikt3wdB
         chmYowyg6lJKyGEi6sPOUIE7PxV/Jlpht9nIuiR80QWKXJsPcLtUdtWi0Hm5eoi9Ybr0
         kpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7HK2NBgKrTY5eJfpC7Iz55GsN4bxjtwWbBvF3BvVIsY=;
        b=cWdSaSxTbFsrXE3Kbhv/Vo/RGo4j+APFjaT4HzJJDBNVIlsoJ0qBq1qSvXmKkQbUDU
         KwVras0T7bhirpEZlY4X8mmCSv8JIzh1/9zd8CR7uNK4nZeuur1LMeWrsyJPFYxFk5QP
         YtjJ1336vDP8ZC/Ik6/P3I7LwD5wdw6UVGCoYPz/CuuiIduRwDtXCNkPV2hFYMICUnY6
         Pm9mMDas8SzX1rQKOcnm8sntbNHBkXEMXOs5C8htz2nq0BD1176uRZqPMxC/IHplojaQ
         L/3jnILsc0JnjH/FEE++hviMCUH5uKIvHt1xxa1tMLnyVI+uQ+Y5cgi1hJR603m4OzkD
         cUmA==
X-Gm-Message-State: AOAM533gBOJmuVO8PxfSt90kfJnE7SkILNxEkAqtA+pghpAD4jAwquWC
        yMEEK6dTWx0J+YuVjNKA8u3sjZJ9AiyJaA==
X-Google-Smtp-Source: ABdhPJw3joiLnZkB2Xdvi3ri6jwFhgBEviD8vxddBAnCwucILsUCm3o1mpvCZYvdCxx6Tz2H6opINg==
X-Received: by 2002:a05:6a00:d53:b029:303:9c38:7d50 with SMTP id n19-20020a056a000d53b02903039c387d50mr896336pfv.2.1624322470776;
        Mon, 21 Jun 2021 17:41:10 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h22sm6491985pfc.21.2021.06.21.17.41.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 17:41:10 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 7/7] Bluetooth: Replace use of hci_update_background_scan with hci_update_scan
Date:   Mon, 21 Jun 2021 17:41:04 -0700
Message-Id: <20210622004104.3179217-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622004104.3179217-1-luiz.dentz@gmail.com>
References: <20210622004104.3179217-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This replaces the use of hci_update_background_scan with hci_update_scan
which runs from cmd_work_sync and deal properly with resolving list when
LL privacy is enabled.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c  |  7 ++++---
 net/bluetooth/hci_core.c  | 11 ++++++-----
 net/bluetooth/hci_event.c |  5 +++--
 net/bluetooth/mgmt.c      |  8 ++++----
 net/bluetooth/msft.c      |  3 ++-
 5 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2b5059a56cda..716171b8fe70 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -31,6 +31,7 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 
+#include "hci_sync.h"
 #include "hci_request.h"
 #include "smp.h"
 #include "a2mp.h"
@@ -108,7 +109,7 @@ static void hci_connect_le_scan_cleanup(struct hci_conn *conn)
 		break;
 	}
 
-	hci_update_background_scan(hdev);
+	hci_update_scan(hdev);
 }
 
 static void hci_conn_cleanup(struct hci_conn *conn)
@@ -785,7 +786,7 @@ void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 	/* Since we may have temporarily stopped the background scanning in
 	 * favor of connection establishment, we should restart it.
 	 */
-	hci_update_background_scan(hdev);
+	hci_update_scan(hdev);
 
 	/* Re-enable advertising in case this was a failed connection
 	 * attempt as a peripheral.
@@ -1278,7 +1279,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 	conn->conn_timeout = conn_timeout;
 	conn->conn_reason = conn_reason;
 
-	hci_update_background_scan(hdev);
+	hci_update_scan(hdev);
 
 done:
 	hci_conn_hold(conn);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d63c4d6c8bc2..2c5de84646ce 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -39,6 +39,7 @@
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/mgmt.h>
 
+#include "hci_sync.h"
 #include "hci_request.h"
 #include "hci_debugfs.h"
 #include "smp.h"
@@ -1096,7 +1097,7 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 
 	switch (state) {
 	case DISCOVERY_STOPPED:
-		hci_update_background_scan(hdev);
+		hci_update_scan(hdev);
 
 		if (old_state != DISCOVERY_STARTING)
 			mgmt_discovering(hdev, 0);
@@ -3279,7 +3280,7 @@ bool hci_add_adv_monitor(struct hci_dev *hdev, struct adv_monitor *monitor,
 
 	switch (hci_get_adv_monitor_offload_ext(hdev)) {
 	case HCI_ADV_MONITOR_EXT_NONE:
-		hci_update_background_scan(hdev);
+		hci_update_scan(hdev);
 		bt_dev_dbg(hdev, "%s add monitor status %d", hdev->name, *err);
 		/* Message was not forwarded to controller - not an error */
 		return false;
@@ -3343,7 +3344,7 @@ bool hci_remove_single_adv_monitor(struct hci_dev *hdev, u16 handle, int *err)
 
 	pending = hci_remove_adv_monitor(hdev, monitor, handle, err);
 	if (!*err && !pending)
-		hci_update_background_scan(hdev);
+		hci_update_scan(hdev);
 
 	bt_dev_dbg(hdev, "%s remove monitor handle %d, status %d, %spending",
 		   hdev->name, handle, *err, pending ? "" : "not ");
@@ -3375,7 +3376,7 @@ bool hci_remove_all_adv_monitor(struct hci_dev *hdev, int *err)
 	}
 
 	if (update)
-		hci_update_background_scan(hdev);
+		hci_update_scan(hdev);
 
 	bt_dev_dbg(hdev, "%s remove all monitors status %d, %spending",
 		   hdev->name, *err, pending ? "" : "not ");
@@ -3678,7 +3679,7 @@ void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
 
 	hci_conn_params_free(params);
 
-	hci_update_background_scan(hdev);
+	hci_update_scan(hdev);
 
 	BT_DBG("addr %pMR (type %u)", addr, addr_type);
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 513fa3778673..1a4279dfb93e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -30,6 +30,7 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/mgmt.h>
 
+#include "hci_sync.h"
 #include "hci_request.h"
 #include "hci_debugfs.h"
 #include "a2mp.h"
@@ -2891,7 +2892,7 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		case HCI_AUTO_CONN_ALWAYS:
 			list_del_init(&params->action);
 			list_add(&params->action, &hdev->pend_le_conns);
-			hci_update_background_scan(hdev);
+			hci_update_scan(hdev);
 			break;
 
 		default:
@@ -5277,7 +5278,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	}
 
 unlock:
-	hci_update_background_scan(hdev);
+	hci_update_scan(hdev);
 	hci_dev_unlock(hdev);
 }
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 53cb0de0d080..fb1ff1354b2b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1586,7 +1586,7 @@ static int set_connectable_update_settings(struct hci_dev *hdev,
 
 	if (changed) {
 		hci_req_update_scan(hdev);
-		hci_update_background_scan(hdev);
+		hci_update_scan(hdev);
 		return new_settings(hdev, sk);
 	}
 
@@ -1944,7 +1944,7 @@ static void le_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 			__hci_req_update_scan_rsp_data(&req, 0x00);
 		}
 		hci_req_run(&req, NULL);
-		hci_update_background_scan(hdev);
+		hci_update_scan(hdev);
 	}
 
 unlock:
@@ -4262,7 +4262,7 @@ int mgmt_add_adv_patterns_monitor_complete(struct hci_dev *hdev, u8 status)
 		hdev->adv_monitors_cnt++;
 		if (monitor->state == ADV_MONITOR_STATE_NOT_REGISTERED)
 			monitor->state = ADV_MONITOR_STATE_REGISTERED;
-		hci_update_background_scan(hdev);
+		hci_update_scan(hdev);
 	}
 
 	err = mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
@@ -4488,7 +4488,7 @@ int mgmt_remove_adv_monitor_complete(struct hci_dev *hdev, u8 status)
 	rp.monitor_handle = cp->monitor_handle;
 
 	if (!status)
-		hci_update_background_scan(hdev);
+		hci_update_scan(hdev);
 
 	err = mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
 				mgmt_status(status), &rp, sizeof(rp));
diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index b4bfae41e8a5..b49b3d4a96c2 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -7,6 +7,7 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/mgmt.h>
 
+#include "hci_sync.h"
 #include "hci_request.h"
 #include "mgmt_util.h"
 #include "msft.h"
@@ -165,7 +166,7 @@ static void reregister_monitor_on_restart(struct hci_dev *hdev, int handle)
 		if (!monitor) {
 			/* All monitors have been reregistered */
 			msft->reregistering = false;
-			hci_update_background_scan(hdev);
+			hci_update_scan(hdev);
 			return;
 		}
 
-- 
2.31.1

