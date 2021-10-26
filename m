Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE01BC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C88C7610A0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240172AbhJZXF7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Oct 2021 19:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240159AbhJZXF5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Oct 2021 19:05:57 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12614C061745
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:33 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n11so642939plf.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GbX85W/YGaYvNA0IpzNqt4m0nOtyaoxDSWZRLuKJtWc=;
        b=D/8NGKeMjZv9QTFVbcfez+tk4/wjI6I4D8XF0vNLV+5JM0RgVPNEarToaWe1QmGDYf
         8njmXZVQ6RRWVtOijdoXBRv9EAgbOpeY5oWmnv7zwAxaCGEEEdDV7VnEFaBJroYdk+2N
         zei68utanraifCXgBObOlg4858T/6/azfMQj90Z7DyPsnMAuf7nirNg/neDKbvVwV/bT
         W+yWHg31O2RBATwR+vR5dlmmflfy7rGgacdCELYObtg13r5rkUggFepmwYBu3dc5Y+Sm
         gn16fju/fvwWpWmWlU/mSxTwD7F0xAYnrASNhrGhJpYm82YtrMTnsOpYA0BaxZptNOYf
         wKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GbX85W/YGaYvNA0IpzNqt4m0nOtyaoxDSWZRLuKJtWc=;
        b=OLUl7JyheO4Kt2Y2YgAmxfR6A79Y41/Tlm9xdQ+n2Pjt/FN5AE9FMpeQPtmCoXtCOd
         hJXnSaXDZaCZh3iq5wTp8mmDk/PvbzkdNPUXMQfmauTci+OnTzREVXiVjPozJ7blqcqM
         EiGGW6gf4BahywcJCPV7623sGNlueucqBshZZ45EDB/amnOisDauY7lhBdtaAnSMd/fG
         Lqm9K/JK6iJHQ4u6DLadpkNMLCzGmQyIkyQhVGnTkioHQz/Kl5unTo8/6BbuNjw5h8/B
         zArqR1r8R7Nx47Xcq39e/uge7PKjBOEkGOODnvi6ncYmUPDwKAhjjrU0pKOvtiOwGECG
         D6xQ==
X-Gm-Message-State: AOAM532kUZARSBIwlIihUMqebEV9CKnbQ1uSYBDOGM4VOdmmmwT3kOGl
        uwymMtZRc4dLc8g/T2Cqw6xfo7IaNTM=
X-Google-Smtp-Source: ABdhPJzmudr0hpIwvq1ukayrVflQXVS2afU8F0HSuJTyhRaS7djL9RYUGaaHiYZ10OxW7yzCrXxStw==
X-Received: by 2002:a17:902:b68b:b0:13a:1239:b8d9 with SMTP id c11-20020a170902b68b00b0013a1239b8d9mr25165838pls.25.1635289412056;
        Tue, 26 Oct 2021 16:03:32 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a2sm20697558pgn.20.2021.10.26.16.03.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 16:03:31 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 08/23] Bluetooth: hci_sync: Convert MGMT_OP_START_DISCOVERY
Date:   Tue, 26 Oct 2021 16:03:09 -0700
Message-Id: <20211026230324.1533907-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026230324.1533907-1-luiz.dentz@gmail.com>
References: <20211026230324.1533907-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This make use of hci_cmd_sync_queue for MGMT_OP_START_DISCOVERY,
MGMT_OP_START_SERVICE_DISCOVERY and MGMT_OP_STOP_DISCOVERY to use
hci_cmd_sync_queue so they no longer depend on hdev->discov_update work
to send any commands.

Tested with:

tools/mgmt-tester -s "Start Discovery"

Test Summary
------------
Start Discovery - Not powered 1                      Passed
Start Discovery - Invalid parameters 1               Passed
Start Discovery - Not supported 1                    Passed
Start Discovery - Success 1                          Passed
Start Discovery - Success 2                          Passed
Start Discovery - Power Off 1                        Passed
Start Discovery BREDR LE - (Ext Scan Enable)         Passed
Start Discovery LE - (Ext Scan Enable)               Passed
Start Discovery LE - (Ext Scan Param)                Passed
Start Discovery - (2m, Scan Param)                   Passed
Start Discovery - (coded, Scan Param)                Passed
Start Discovery - (1m, 2m, coded, Scan Param)        Passed
LL Privacy - Start Discovery 1 (Disable RL)          Passed
LL Privacy - Start Discovery 2 (Disable RL)          Passed
Total: 14, Passed: 14 (100.0%), Failed: 0, Not Run: 0

tools/mgmt-tester -s "Start Service"

Test Summary
------------
Start Service Discovery - Not powered 1              Passed
Start Service Discovery - Invalid parameters 1       Passed
Start Service Discovery - Not supported 1            Passed
Start Service Discovery - Success 1                  Passed
Start Service Discovery - Success 2                  Passed
Total: 5, Passed: 5 (100.0%), Failed: 0, Not Run: 0

tools/mgmt-tester -s "Stop Discovery"

Test Summary
------------
Stop Discovery - Success 1                           Passed
Stop Discovery - BR/EDR (Inquiry) Success 1          Passed
Stop Discovery - Rejected 1                          Passed
Stop Discovery - Invalid parameters 1                Passed
Stop Discovery - (Ext Scan Disable)                  Passed
Total: 5, Passed: 5 (100.0%), Failed: 0, Not Run: 0

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_sync.h |   4 +
 net/bluetooth/hci_conn.c         |   4 +-
 net/bluetooth/hci_event.c        |  15 +-
 net/bluetooth/hci_sync.c         | 238 +++++++++++++++++++++++++++++--
 net/bluetooth/mgmt.c             | 105 ++++++++++----
 5 files changed, 310 insertions(+), 56 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 00203077e656..c4fa77321b31 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -59,6 +59,7 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance);
 int hci_start_ext_adv_sync(struct hci_dev *hdev, u8 instance);
 int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance);
 int hci_enable_advertising_sync(struct hci_dev *hdev);
+int hci_enable_advertising(struct hci_dev *hdev);
 
 int hci_remove_advertising_sync(struct hci_dev *hdev, struct sock *sk,
 				u8 instance, bool force);
@@ -72,3 +73,6 @@ int hci_dev_close_sync(struct hci_dev *hdev);
 
 int hci_powered_update_sync(struct hci_dev *hdev);
 int hci_set_powered_sync(struct hci_dev *hdev, u8 val);
+
+int hci_start_discovery_sync(struct hci_dev *hdev);
+int hci_stop_discovery_sync(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 1783ec5f6e3e..dbd737b62f98 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -915,10 +915,10 @@ void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 	 */
 	hci_update_passive_scan(hdev);
 
-	/* Re-enable advertising in case this was a failed connection
+	/* Enable advertising in case this was a failed connection
 	 * attempt as a peripheral.
 	 */
-	hci_req_reenable_advertising(hdev);
+	hci_enable_advertising(hdev);
 }
 
 static void create_le_conn_complete(struct hci_dev *hdev, u8 status, u16 opcode)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c4b588ace96d..64f4b5edb721 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1512,16 +1512,10 @@ static void le_set_scan_enable_complete(struct hci_dev *hdev, u8 enable)
 
 		/* The HCI_LE_SCAN_INTERRUPTED flag indicates that we
 		 * interrupted scanning due to a connect request. Mark
-		 * therefore discovery as stopped. If this was not
-		 * because of a connect request advertising might have
-		 * been disabled because of active scanning, so
-		 * re-enable it again if necessary.
+		 * therefore discovery as stopped.
 		 */
 		if (hci_dev_test_and_clear_flag(hdev, HCI_LE_SCAN_INTERRUPTED))
 			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
-		else if (!hci_dev_test_flag(hdev, HCI_LE_ADV) &&
-			 hdev->discovery.state == DISCOVERY_FINDING)
-			hci_req_reenable_advertising(hdev);
 
 		break;
 
@@ -2438,7 +2432,7 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 
 		if (conn->type == LE_LINK && conn->role == HCI_ROLE_SLAVE) {
 			hdev->cur_adv_instance = conn->adv_instance;
-			hci_req_reenable_advertising(hdev);
+			hci_enable_advertising(hdev);
 		}
 
 		/* If the disconnection failed for any reason, the upper layer
@@ -3048,7 +3042,7 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	 */
 	if (conn->type == LE_LINK && conn->role == HCI_ROLE_SLAVE) {
 		hdev->cur_adv_instance = conn->adv_instance;
-		hci_req_reenable_advertising(hdev);
+		hci_enable_advertising(hdev);
 	}
 
 	hci_conn_del(conn);
@@ -5498,9 +5492,6 @@ static void hci_le_enh_conn_complete_evt(struct hci_dev *hdev,
 			     le16_to_cpu(ev->interval),
 			     le16_to_cpu(ev->latency),
 			     le16_to_cpu(ev->supervision_timeout));
-
-	if (hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION))
-		hci_req_disable_address_resolution(hdev);
 }
 
 static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 0645804ee242..471ee5bc5665 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -189,9 +189,6 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 		return ERR_PTR(err);
 	}
 
-	if (!skb)
-		return ERR_PTR(-ENODATA);
-
 	return skb;
 }
 EXPORT_SYMBOL(__hci_cmd_sync_sk);
@@ -241,12 +238,19 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 	u8 status;
 
 	skb = __hci_cmd_sync_sk(hdev, opcode, plen, param, event, timeout, sk);
-	if (IS_ERR_OR_NULL(skb)) {
+	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Opcode 0x%4x failed: %ld", opcode,
 			   PTR_ERR(skb));
 		return PTR_ERR(skb);
 	}
 
+	/* If command return a status event skb will be set to NULL as there are
+	 * no parameters, in case of failure IS_ERR(skb) would have be set to
+	 * the actual error would be found with PTR_ERR(skb).
+	 */
+	if (!skb)
+		return 0;
+
 	status = skb->data[0];
 
 	kfree_skb(skb);
@@ -1017,8 +1021,22 @@ int hci_enable_advertising_sync(struct hci_dev *hdev)
 				     sizeof(enable), &enable, HCI_CMD_TIMEOUT);
 }
 
-static int hci_remove_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance,
-					    struct sock *sk)
+static int enable_advertising_sync(struct hci_dev *hdev, void *data)
+{
+	return hci_enable_advertising_sync(hdev);
+}
+
+int hci_enable_advertising(struct hci_dev *hdev)
+{
+	if (!hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
+	    list_empty(&hdev->adv_instances))
+		return 0;
+
+	return hci_cmd_sync_queue(hdev, enable_advertising_sync, NULL, NULL);
+}
+
+int hci_remove_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance,
+				     struct sock *sk)
 {
 	int err;
 
@@ -1622,7 +1640,7 @@ static int hci_pause_advertising_sync(struct hci_dev *hdev)
 	return 0;
 }
 
-/* This function disables all user advertising instances (excluding 0x00) */
+/* This function enables all user advertising instances (excluding 0x00) */
 static int hci_resume_advertising_sync(struct hci_dev *hdev)
 {
 	struct adv_info *adv, *tmp;
@@ -1870,7 +1888,8 @@ static int hci_le_set_scan_param_sync(struct hci_dev *hdev, u8 type,
 }
 
 static int hci_start_scan_sync(struct hci_dev *hdev, u8 type, u16 interval,
-			       u16 window, u8 own_addr_type, u8 filter_policy)
+			       u16 window, u8 own_addr_type, u8 filter_policy,
+			       u8 filter_dup)
 {
 	int err;
 
@@ -1884,8 +1903,7 @@ static int hci_start_scan_sync(struct hci_dev *hdev, u8 type, u16 interval,
 	if (err)
 		return err;
 
-	return hci_le_set_scan_enable_sync(hdev, LE_SCAN_ENABLE,
-					   LE_SCAN_FILTER_DUP_ENABLE);
+	return hci_le_set_scan_enable_sync(hdev, LE_SCAN_ENABLE, filter_dup);
 }
 
 int hci_passive_scan_sync(struct hci_dev *hdev)
@@ -1960,7 +1978,8 @@ int hci_passive_scan_sync(struct hci_dev *hdev)
 	bt_dev_dbg(hdev, "LE passive scan with acceptlist = %d", filter_policy);
 
 	return hci_start_scan_sync(hdev, LE_SCAN_PASSIVE, interval, window,
-				   own_addr_type, filter_policy);
+				   own_addr_type, filter_policy,
+				   LE_SCAN_FILTER_DUP_ENABLE);
 }
 
 /* This function controls the passive scanning based on hdev->pend_le_conns
@@ -2419,7 +2438,7 @@ static int hci_remote_name_cancel_sync(struct hci_dev *hdev, bdaddr_t *addr)
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
-static int hci_stop_discovery_sync(struct hci_dev *hdev)
+int hci_stop_discovery_sync(struct hci_dev *hdev)
 {
 	struct discovery_state *d = &hdev->discovery;
 	struct inquiry_entry *e;
@@ -2450,6 +2469,10 @@ static int hci_stop_discovery_sync(struct hci_dev *hdev)
 			return err;
 	}
 
+	/* Resume advertising if it was paused */
+	if (use_ll_privacy(hdev))
+		hci_resume_advertising_sync(hdev);
+
 	/* No further actions needed for LE-only discovery */
 	if (d->type == DISCOV_TYPE_LE)
 		return 0;
@@ -2617,3 +2640,194 @@ int hci_set_powered_sync(struct hci_dev *hdev, u8 val)
 
 	return hci_power_off_sync(hdev);
 }
+
+static int hci_inquiry_sync(struct hci_dev *hdev, u8 length)
+{
+	const u8 giac[3] = { 0x33, 0x8b, 0x9e };
+	const u8 liac[3] = { 0x00, 0x8b, 0x9e };
+	struct hci_cp_inquiry cp;
+
+	bt_dev_dbg(hdev, "");
+
+	if (hci_dev_test_flag(hdev, HCI_INQUIRY))
+		return 0;
+
+	hci_dev_lock(hdev);
+	hci_inquiry_cache_flush(hdev);
+	hci_dev_unlock(hdev);
+
+	memset(&cp, 0, sizeof(cp));
+
+	if (hdev->discovery.limited)
+		memcpy(&cp.lap, liac, sizeof(cp.lap));
+	else
+		memcpy(&cp.lap, giac, sizeof(cp.lap));
+
+	cp.length = length;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_INQUIRY,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
+static int hci_active_scan_sync(struct hci_dev *hdev, uint16_t interval)
+{
+	u8 own_addr_type;
+	/* Accept list is not used for discovery */
+	u8 filter_policy = 0x00;
+	/* Default is to enable duplicates filter */
+	u8 filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
+	int err;
+
+	bt_dev_dbg(hdev, "");
+
+	/* If controller is scanning, it means the passive scanning is
+	 * running. Thus, we should temporarily stop it in order to set the
+	 * discovery scanning parameters.
+	 */
+	err = hci_scan_disable_sync(hdev);
+	if (err) {
+		bt_dev_err(hdev, "Unable to disable scanning: %d", err);
+		return err;
+	}
+
+	cancel_interleave_scan(hdev);
+
+	/* Pause advertising since active scanning disables address resolution
+	 * which advertising depend on in order to generate its RPAs.
+	 */
+	if (use_ll_privacy(hdev)) {
+		err = hci_pause_advertising_sync(hdev);
+		if (err) {
+			bt_dev_err(hdev, "pause advertising failed: %d", err);
+			goto failed;
+		}
+	}
+
+	/* Disable address resolution while doing active scanning since the
+	 * accept list shall not be used and all reports shall reach the host
+	 * anyway.
+	 */
+	err = hci_le_set_addr_resolution_enable_sync(hdev, 0x00);
+	if (err) {
+		bt_dev_err(hdev, "Unable to disable Address Resolution: %d",
+			   err);
+		goto failed;
+	}
+
+	/* All active scans will be done with either a resolvable private
+	 * address (when privacy feature has been enabled) or non-resolvable
+	 * private address.
+	 */
+	err = hci_update_random_address_sync(hdev, true, scan_use_rpa(hdev),
+					     &own_addr_type);
+	if (err < 0)
+		own_addr_type = ADDR_LE_DEV_PUBLIC;
+
+	if (hci_is_adv_monitoring(hdev)) {
+		/* Duplicate filter should be disabled when some advertisement
+		 * monitor is activated, otherwise AdvMon can only receive one
+		 * advertisement for one peer(*) during active scanning, and
+		 * might report loss to these peers.
+		 *
+		 * Note that different controllers have different meanings of
+		 * |duplicate|. Some of them consider packets with the same
+		 * address as duplicate, and others consider packets with the
+		 * same address and the same RSSI as duplicate. Although in the
+		 * latter case we don't need to disable duplicate filter, but
+		 * it is common to have active scanning for a short period of
+		 * time, the power impact should be neglectable.
+		 */
+		filter_dup = LE_SCAN_FILTER_DUP_DISABLE;
+	}
+
+	err = hci_start_scan_sync(hdev, LE_SCAN_ACTIVE, interval,
+				  hdev->le_scan_window_discovery,
+				  own_addr_type, filter_policy, filter_dup);
+	if (!err)
+		return err;
+
+failed:
+	/* Resume advertising if it was paused */
+	if (use_ll_privacy(hdev))
+		hci_resume_advertising_sync(hdev);
+
+	/* Resume passive scanning */
+	hci_update_passive_scan_sync(hdev);
+	return err;
+}
+
+static int hci_start_interleaved_discovery_sync(struct hci_dev *hdev)
+{
+	int err;
+
+	bt_dev_dbg(hdev, "");
+
+	err = hci_active_scan_sync(hdev, hdev->le_scan_int_discovery * 2);
+	if (err)
+		return err;
+
+	return hci_inquiry_sync(hdev, DISCOV_BREDR_INQUIRY_LEN);
+}
+
+int hci_start_discovery_sync(struct hci_dev *hdev)
+{
+	unsigned long timeout;
+	int err;
+
+	bt_dev_dbg(hdev, "type %u", hdev->discovery.type);
+
+	switch (hdev->discovery.type) {
+	case DISCOV_TYPE_BREDR:
+		return hci_inquiry_sync(hdev, DISCOV_BREDR_INQUIRY_LEN);
+	case DISCOV_TYPE_INTERLEAVED:
+		/* When running simultaneous discovery, the LE scanning time
+		 * should occupy the whole discovery time sine BR/EDR inquiry
+		 * and LE scanning are scheduled by the controller.
+		 *
+		 * For interleaving discovery in comparison, BR/EDR inquiry
+		 * and LE scanning are done sequentially with separate
+		 * timeouts.
+		 */
+		if (test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY,
+			     &hdev->quirks)) {
+			timeout = msecs_to_jiffies(DISCOV_LE_TIMEOUT);
+			/* During simultaneous discovery, we double LE scan
+			 * interval. We must leave some time for the controller
+			 * to do BR/EDR inquiry.
+			 */
+			err = hci_start_interleaved_discovery_sync(hdev);
+			break;
+		}
+
+		timeout = msecs_to_jiffies(hdev->discov_interleaved_timeout);
+		err = hci_active_scan_sync(hdev, hdev->le_scan_int_discovery);
+		break;
+	case DISCOV_TYPE_LE:
+		timeout = msecs_to_jiffies(DISCOV_LE_TIMEOUT);
+		err = hci_active_scan_sync(hdev, hdev->le_scan_int_discovery);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (err)
+		return err;
+
+	bt_dev_dbg(hdev, "timeout %u ms", jiffies_to_msecs(timeout));
+
+	/* When service discovery is used and the controller has a
+	 * strict duplicate filter, it is important to remember the
+	 * start and duration of the scan. This is required for
+	 * restarting scanning during the discovery phase.
+	 */
+	if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks) &&
+	    hdev->discovery.result_filtering) {
+		hdev->discovery.scan_start = jiffies;
+		hdev->discovery.scan_duration = timeout;
+	}
+
+	queue_delayed_work(hdev->req_workqueue, &hdev->le_scan_disable,
+			   timeout);
+
+	return 0;
+}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9490663ee3fb..663049821bed 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5111,6 +5111,32 @@ static bool discovery_type_is_valid(struct hci_dev *hdev, uint8_t type,
 	return true;
 }
 
+static void start_discovery_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct mgmt_pending_cmd *cmd = data;
+
+	bt_dev_dbg(hdev, "err %d", err);
+
+	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, mgmt_status(err),
+			  cmd->param, 1);
+	mgmt_pending_free(cmd);
+
+	/* Handle suspend notifier */
+	if (test_and_clear_bit(SUSPEND_UNPAUSE_DISCOVERY,
+			       hdev->suspend_tasks)) {
+		bt_dev_dbg(hdev, "Unpaused discovery");
+		wake_up(&hdev->suspend_wait_q);
+	}
+
+	hci_discovery_set_state(hdev, err ? DISCOVERY_STOPPED:
+				DISCOVERY_FINDING);
+}
+
+static int start_discovery_sync(struct hci_dev *hdev, void *data)
+{
+	return hci_start_discovery_sync(hdev);
+}
+
 static int start_discovery_internal(struct sock *sk, struct hci_dev *hdev,
 				    u16 op, void *data, u16 len)
 {
@@ -5162,17 +5188,20 @@ static int start_discovery_internal(struct sock *sk, struct hci_dev *hdev,
 	else
 		hdev->discovery.limited = false;
 
-	cmd = mgmt_pending_add(sk, op, hdev, data, len);
+	cmd = mgmt_pending_new(sk, op, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
 	}
 
-	cmd->cmd_complete = generic_cmd_complete;
+	err = hci_cmd_sync_queue(hdev, start_discovery_sync, cmd,
+				 start_discovery_complete);
+	if (err < 0) {
+		mgmt_pending_free(cmd);
+		goto failed;
+	}
 
 	hci_discovery_set_state(hdev, DISCOVERY_STARTING);
-	queue_work(hdev->req_workqueue, &hdev->discov_update);
-	err = 0;
 
 failed:
 	hci_dev_unlock(hdev);
@@ -5194,13 +5223,6 @@ static int start_limited_discovery(struct sock *sk, struct hci_dev *hdev,
 					data, len);
 }
 
-static int service_discovery_cmd_complete(struct mgmt_pending_cmd *cmd,
-					  u8 status)
-{
-	return mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, status,
-				 cmd->param, 1);
-}
-
 static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 				   void *data, u16 len)
 {
@@ -5269,15 +5291,13 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_START_SERVICE_DISCOVERY,
+	cmd = mgmt_pending_new(sk, MGMT_OP_START_SERVICE_DISCOVERY,
 			       hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
 	}
 
-	cmd->cmd_complete = service_discovery_cmd_complete;
-
 	/* Clear the discovery filter first to free any previously
 	 * allocated memory for the UUID list.
 	 */
@@ -5301,9 +5321,14 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 		}
 	}
 
+	err = hci_cmd_sync_queue(hdev, start_discovery_sync, cmd,
+				 start_discovery_complete);
+	if (err < 0) {
+		mgmt_pending_free(cmd);
+		goto failed;
+	}
+
 	hci_discovery_set_state(hdev, DISCOVERY_STARTING);
-	queue_work(hdev->req_workqueue, &hdev->discov_update);
-	err = 0;
 
 failed:
 	hci_dev_unlock(hdev);
@@ -5333,6 +5358,31 @@ void mgmt_stop_discovery_complete(struct hci_dev *hdev, u8 status)
 	}
 }
 
+static void stop_discovery_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct mgmt_pending_cmd *cmd = data;
+
+	bt_dev_dbg(hdev, "err %d", err);
+
+	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, mgmt_status(err),
+			  cmd->param, 1);
+	mgmt_pending_free(cmd);
+
+	/* Handle suspend notifier */
+	if (test_and_clear_bit(SUSPEND_PAUSE_DISCOVERY, hdev->suspend_tasks)) {
+		bt_dev_dbg(hdev, "Paused discovery");
+		wake_up(&hdev->suspend_wait_q);
+	}
+
+	if (!err)
+		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+}
+
+static int stop_discovery_sync(struct hci_dev *hdev, void *data)
+{
+	return hci_stop_discovery_sync(hdev);
+}
+
 static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 			  u16 len)
 {
@@ -5358,17 +5408,20 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_STOP_DISCOVERY, hdev, data, len);
+	cmd = mgmt_pending_new(sk, MGMT_OP_STOP_DISCOVERY, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto unlock;
 	}
 
-	cmd->cmd_complete = generic_cmd_complete;
+	err = hci_cmd_sync_queue(hdev, stop_discovery_sync, cmd,
+				 stop_discovery_complete);
+	if (err < 0) {
+		mgmt_pending_free(cmd);
+		goto unlock;
+	}
 
 	hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
-	queue_work(hdev->req_workqueue, &hdev->discov_update);
-	err = 0;
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -5803,16 +5856,8 @@ static int set_scan_params(struct sock *sk, struct hci_dev *hdev,
 	 * loaded.
 	 */
 	if (hci_dev_test_flag(hdev, HCI_LE_SCAN) &&
-	    hdev->discovery.state == DISCOVERY_STOPPED) {
-		struct hci_request req;
-
-		hci_req_init(&req, hdev);
-
-		hci_req_add_le_scan_disable(&req, false);
-		hci_req_add_le_passive_scan(&req);
-
-		hci_req_run(&req, NULL);
-	}
+	    hdev->discovery.state == DISCOVERY_STOPPED)
+		hci_update_passive_scan(hdev);
 
 	hci_dev_unlock(hdev);
 
-- 
2.31.1

