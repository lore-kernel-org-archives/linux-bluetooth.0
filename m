Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0BEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 23:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79F126109F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 23:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhJ1ABd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 20:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhJ1ABc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 20:01:32 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E54C061745
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 16:59:06 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id m21so4533250pgu.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 16:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3zfh0HnAMiQ0xSn3r3+8SoPvF3uuWhD4k0zW8DbeY38=;
        b=D1zgCcBTJKhtAV5hpAZ7ojy9EgMnthNZsfeMZdnqhIzGYtZQa+4mwOb7bFcAmGgyDy
         ZlHdTD/zLTDvfUMEw1WVX7aRwTzwym+eg0CEfpq9zJziGt2mFMkThlAJxYUtgM9elMaS
         SzwpbNtWEYKwAzemEx8tL7WcqhOZc3cVzPuNWZwVrvpss1bLoMBDV2L9VkgEUAO2T9yf
         xu5UnG07KMk95cLRZ53FAN9ZBdMf2mpTutQ6huiafgcty93wJGsEnYMLJCXZawU2bxSB
         Dt1y7WvS9eeeqQqnVECTVkiDCHv9BKIko6uwt7jcLTdD4XVBTAyKelvbCruRnyFbSF32
         aDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3zfh0HnAMiQ0xSn3r3+8SoPvF3uuWhD4k0zW8DbeY38=;
        b=zchD8cs+4bJ1iw+qkR2FYcvzcMQaxywHwlI7Ix11n7ntvw0aDkjSBn5+tfZ9Tn+nPi
         en9E16l59RSpFXDz71BrePKxTZmYB+kuqW6EaUMqQUJ7Z1lq5MJhvMdcoIz21+J2Oc3W
         4AsoMvU/zibFMN1YdOpdelAkbauVsc04y5jnG944F/bPwku+RnCRXPSDJ6CtMS74IrLT
         8YYVDZW75s1pxxk/5N+BRVe7xEwKeLNdJEV7syEuxLTRsoCe/fnFxdIHN3Jp2HNdfNpQ
         GBpPmYBY2hQmKjlf8IAUCJIoy8KLya+voMfFkXg056U9MzQ7VDOgVY60auQGN1oFwIia
         GebQ==
X-Gm-Message-State: AOAM530dQdw3bufAFsAKD4agzbX7ZhMASZHqEkmb9+cyAPlLMUkGjCJZ
        Bqpiz934T5EYg1XpTTMuc/ea3AYwGU8=
X-Google-Smtp-Source: ABdhPJzTtxh0cLmYvZDcOGq/ELOk10SfmBaVJpAfB+FVBCxB2xjkLhT75Y/0YlHGAXTkEBY0mGtF0w==
X-Received: by 2002:a63:954a:: with SMTP id t10mr667448pgn.89.1635379145811;
        Wed, 27 Oct 2021 16:59:05 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 142sm807908pgh.22.2021.10.27.16.59.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 16:59:05 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 06/23] Bluetooth: hci_sync: Rework background scan
Date:   Wed, 27 Oct 2021 16:58:43 -0700
Message-Id: <20211027235900.1882863-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027235900.1882863-1-luiz.dentz@gmail.com>
References: <20211027235900.1882863-1-luiz.dentz@gmail.com>
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
index ed2e65a4adb8..51baad59ec14 100644
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

