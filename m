Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA18FC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD041610A6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240167AbhJZXF6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Oct 2021 19:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240155AbhJZXFz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Oct 2021 19:05:55 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C05FC061570
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:31 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id v20so628378plo.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EfaQjZheU0ac+KUKfur2Fe1uy2v3sj7dbM+heIk7fqg=;
        b=ZA+Kh4dk0WUIxiaLTMzewjQkGF4ul0lBf84aDYPLjzxkSOMOc+MzZTBSlPD8WM2yMG
         ZsTglts7IYhjXuZ8XsFYDKwIzZ9f1FUEz85ZnZgfty9oCfRHa5zZAn5LEp1BGMONvN+O
         Tkvp8JfH7PV5ONf3+7Vb4CSiuuWzmvVZJzlHi9Djz0pDm+S/0mHghDy7oGfL1lvR7tmu
         yR0I6WDZzlseseSJkF/AgY5H6m7EP3L2rfEwPfoPXGimbv3qIiho34HXSVfuMyMG5qgL
         RgVpXsPiz1lkYGgrsgfcJ5QcLr6Iyw7B0vbaJRxrd1XP8MTdlJT8CRFfEGlOCLA2CiqM
         DlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EfaQjZheU0ac+KUKfur2Fe1uy2v3sj7dbM+heIk7fqg=;
        b=ANBH5i39k5qvZs4ZirVjSXigB5FgZR5o4zHhEEUs9orkvsV1gCwP/QFUVpf851AP+6
         m7Dp4rSMG1MBOSokNjKQNXfBcN1MrkGwLRebUd8Cp3nNaWADI/MNGqdxk0ivpP0xvy0p
         Dlyi9RrBBpYNUdSIht7gzcrf+Hhx1iqgvxDrlzsOrSq+zuwRflq1Tg0qh6e8frwTq6C0
         tWPhM4DkoSP0a/SnhRybo0rH/7eaYl6/Bx/8rZ0G+//s2nklVuPrPUI16hYH2U8Mrr6Y
         W9ymCLjf6Mu1ml9pF9uy/16ZFnKCliTwXG3N2sDl1LwVZcRYSiGXQSNKH94bHFrtOLCV
         aC+g==
X-Gm-Message-State: AOAM533JiV4i3Iy+IPBV0NHLyDAUfILiD9TzNr5+J0Yvnm/NbJvNECwM
        oWOuPEboptoP8T3qH0+FFUfn6KFtNDQ=
X-Google-Smtp-Source: ABdhPJxXRsiY0twPgVT06jyKUqIw8knOdx49tZflhxWQtYceR9B3bG/cXkgxbKAfgDzFYwEq36Rp9g==
X-Received: by 2002:a17:903:28d:b0:141:52ab:590e with SMTP id j13-20020a170903028d00b0014152ab590emr6224718plr.18.1635289410488;
        Tue, 26 Oct 2021 16:03:30 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a2sm20697558pgn.20.2021.10.26.16.03.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 16:03:30 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 06/23] Bluetooth: hci_sync: Rework background scan
Date:   Tue, 26 Oct 2021 16:03:07 -0700
Message-Id: <20211026230324.1533907-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026230324.1533907-1-luiz.dentz@gmail.com>
References: <20211026230324.1533907-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This replaces the use of hci_update_background_scan with
hci_update_passive_scan which runs from cmd_work_sync and deal properly
with resolving list when LL privacy is enabled.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c  |  6 +++---
 net/bluetooth/hci_core.c  | 14 +++++++-------
 net/bluetooth/hci_event.c |  4 ++--
 net/bluetooth/hci_sync.c  |  9 +++++++++
 net/bluetooth/mgmt.c      |  8 ++++----
 net/bluetooth/msft.c      |  2 +-
 6 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index bd669c95b9a7..1783ec5f6e3e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -108,7 +108,7 @@ static void hci_connect_le_scan_cleanup(struct hci_conn *conn)
 		break;
 	}
 
-	hci_update_background_scan(hdev);
+	hci_update_passive_scan(hdev);
 }
 
 static void hci_conn_cleanup(struct hci_conn *conn)
@@ -913,7 +913,7 @@ void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 	/* Since we may have temporarily stopped the background scanning in
 	 * favor of connection establishment, we should restart it.
 	 */
-	hci_update_background_scan(hdev);
+	hci_update_passive_scan(hdev);
 
 	/* Re-enable advertising in case this was a failed connection
 	 * attempt as a peripheral.
@@ -1411,7 +1411,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 	conn->conn_timeout = conn_timeout;
 	conn->conn_reason = conn_reason;
 
-	hci_update_background_scan(hdev);
+	hci_update_passive_scan(hdev);
 
 done:
 	hci_conn_hold(conn);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fdc1cce5eb5b..8c54b1d4d41b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -975,7 +975,7 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 
 	switch (state) {
 	case DISCOVERY_STOPPED:
-		hci_update_background_scan(hdev);
+		hci_update_passive_scan(hdev);
 
 		if (old_state != DISCOVERY_STARTING)
 			mgmt_discovering(hdev, 0);
@@ -1850,7 +1850,7 @@ int hci_dev_reset_stat(__u16 dev)
 	return ret;
 }
 
-static void hci_update_scan_state(struct hci_dev *hdev, u8 scan)
+static void hci_update_passive_scan_state(struct hci_dev *hdev, u8 scan)
 {
 	bool conn_changed, discov_changed;
 
@@ -1951,7 +1951,7 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 		 * get correctly modified as this was a non-mgmt change.
 		 */
 		if (!err)
-			hci_update_scan_state(hdev, dr.dev_opt);
+			hci_update_passive_scan_state(hdev, dr.dev_opt);
 		break;
 
 	case HCISETLINKPOL:
@@ -3096,7 +3096,7 @@ bool hci_add_adv_monitor(struct hci_dev *hdev, struct adv_monitor *monitor,
 
 	switch (hci_get_adv_monitor_offload_ext(hdev)) {
 	case HCI_ADV_MONITOR_EXT_NONE:
-		hci_update_background_scan(hdev);
+		hci_update_passive_scan(hdev);
 		bt_dev_dbg(hdev, "%s add monitor status %d", hdev->name, *err);
 		/* Message was not forwarded to controller - not an error */
 		return false;
@@ -3160,7 +3160,7 @@ bool hci_remove_single_adv_monitor(struct hci_dev *hdev, u16 handle, int *err)
 
 	pending = hci_remove_adv_monitor(hdev, monitor, handle, err);
 	if (!*err && !pending)
-		hci_update_background_scan(hdev);
+		hci_update_passive_scan(hdev);
 
 	bt_dev_dbg(hdev, "%s remove monitor handle %d, status %d, %spending",
 		   hdev->name, handle, *err, pending ? "" : "not ");
@@ -3192,7 +3192,7 @@ bool hci_remove_all_adv_monitor(struct hci_dev *hdev, int *err)
 	}
 
 	if (update)
-		hci_update_background_scan(hdev);
+		hci_update_passive_scan(hdev);
 
 	bt_dev_dbg(hdev, "%s remove all monitors status %d, %spending",
 		   hdev->name, *err, pending ? "" : "not ");
@@ -3486,7 +3486,7 @@ void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
 
 	hci_conn_params_free(params);
 
-	hci_update_background_scan(hdev);
+	hci_update_passive_scan(hdev);
 
 	BT_DBG("addr %pMR (type %u)", addr, addr_type);
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 502478a210e0..c4b588ace96d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3026,7 +3026,7 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		case HCI_AUTO_CONN_ALWAYS:
 			list_del_init(&params->action);
 			list_add(&params->action, &hdev->pend_le_conns);
-			hci_update_background_scan(hdev);
+			hci_update_passive_scan(hdev);
 			break;
 
 		default:
@@ -5469,7 +5469,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	}
 
 unlock:
-	hci_update_background_scan(hdev);
+	hci_update_passive_scan(hdev);
 	hci_dev_unlock(hdev);
 }
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c9aba2fd0301..6d53a876de85 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2029,5 +2029,14 @@ static int update_passive_scan_sync(struct hci_dev *hdev, void *data)
 
 int hci_update_passive_scan(struct hci_dev *hdev)
 {
+	/* Only queue if it would have any effect */
+	if (!test_bit(HCI_UP, &hdev->flags) ||
+	    test_bit(HCI_INIT, &hdev->flags) ||
+	    hci_dev_test_flag(hdev, HCI_SETUP) ||
+	    hci_dev_test_flag(hdev, HCI_CONFIG) ||
+	    hci_dev_test_flag(hdev, HCI_AUTO_OFF) ||
+	    hci_dev_test_flag(hdev, HCI_UNREGISTER))
+		return 0;
+
 	return hci_cmd_sync_queue(hdev, update_passive_scan_sync, NULL, NULL);
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ca2273a8979d..d09a757a5851 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1585,7 +1585,7 @@ static int set_connectable_update_settings(struct hci_dev *hdev,
 
 	if (changed) {
 		hci_req_update_scan(hdev);
-		hci_update_background_scan(hdev);
+		hci_update_passive_scan(hdev);
 		return new_settings(hdev, sk);
 	}
 
@@ -1943,7 +1943,7 @@ static void le_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 			__hci_req_update_scan_rsp_data(&req, 0x00);
 		}
 		hci_req_run(&req, NULL);
-		hci_update_background_scan(hdev);
+		hci_update_passive_scan(hdev);
 	}
 
 unlock:
@@ -4488,7 +4488,7 @@ int mgmt_add_adv_patterns_monitor_complete(struct hci_dev *hdev, u8 status)
 		hdev->adv_monitors_cnt++;
 		if (monitor->state == ADV_MONITOR_STATE_NOT_REGISTERED)
 			monitor->state = ADV_MONITOR_STATE_REGISTERED;
-		hci_update_background_scan(hdev);
+		hci_update_passive_scan(hdev);
 	}
 
 	err = mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
@@ -4714,7 +4714,7 @@ int mgmt_remove_adv_monitor_complete(struct hci_dev *hdev, u8 status)
 	rp.monitor_handle = cp->monitor_handle;
 
 	if (!status)
-		hci_update_background_scan(hdev);
+		hci_update_passive_scan(hdev);
 
 	err = mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
 				mgmt_status(status), &rp, sizeof(rp));
diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index 255cffa554ee..5205d9410ff5 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -168,7 +168,7 @@ static void reregister_monitor(struct hci_dev *hdev, int handle)
 		if (!monitor) {
 			/* All monitors have been reregistered */
 			msft->reregistering = false;
-			hci_update_background_scan(hdev);
+			hci_update_passive_scan(hdev);
 			return;
 		}
 
-- 
2.31.1

