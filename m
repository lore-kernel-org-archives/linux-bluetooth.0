Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C367EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Nov 2021 00:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C3166134F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Nov 2021 00:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbhKLAvh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Nov 2021 19:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbhKLAvg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Nov 2021 19:51:36 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BC9C061766
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Nov 2021 16:48:47 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so5949862pjl.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Nov 2021 16:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3qVduaINksaY5XQnvmK0Y8caooxBPdfxkn+qgpNl30g=;
        b=QLq0Y58y8f/9Yb7CVhaAGW3bmw7sk1DY2tk8Luxq8SraAOKt3+OtBExMrRHzcg0yOo
         GwW4WyqApM9CNHKfYFCXy0mg6Uyw8K7TdbehngjWKiVZGxaKUaQ6hMZZRP6dxgwqlQxD
         TbTLay0+TIuTo+ibcV/LY+DNbBtzequhzwb2acukNEemM6/KYdQQ4lzcJh3G0ir65+8p
         EG5KmNU70IhWng+hlJq5bgbuSukbrDV532fhpGVvpekfZtTD1/J/Nm8345nRaUN32HO2
         A+SuBbJ/q5+O1puGjj32fSrKsY1wDRiJjtq1qbbCpFDN3GbNCsq7oa4zcxz2iAuPT02X
         6fSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3qVduaINksaY5XQnvmK0Y8caooxBPdfxkn+qgpNl30g=;
        b=KiSvrdDot1CnSyTZj69QIddIM3sL50Sva2fMzLZAteV4Olyii8K+FE0d8NGOxuqQU1
         QwSaSkzugdku89W5f2fLsg2vYSW+JxwicupcC3VBCzDQ/J4qzChFkhps2tF1I6RqEqSq
         RgSVppjqbQ3eXtorDOdmlYCz7kIIEpd6gXpt8M6OqAuWP77SC492NYL1uDj/RcPH8cxw
         KIDVZkvlRoQwGhJKuUSwkO+OfNRrZluaNXuh9TZZiSp2VoLxrWagDye3+RRvwvXIal4L
         HkSNbF6rz0UKb6qAa9rVPgMAG23BWk7MMvAHboI/MHvFUWZP0LMQPbBj5We9AKpSt5r/
         +khw==
X-Gm-Message-State: AOAM532C/rP091X7rNrQVMyqt7NRgf7F9YbT3e3xBXQ37vUKdJgjnRC2
        zHNR3O6Ln6hADK40nldTIyQ9+uPkMrw=
X-Google-Smtp-Source: ABdhPJwTy11Hhv2rjr/+2P/cSkJROXJ3HMCUydGkZApoKcvT79zPiGH1w3m29VhWNx5+wJyQ+E2B/w==
X-Received: by 2002:a17:90b:2251:: with SMTP id hk17mr13112341pjb.31.1636678126205;
        Thu, 11 Nov 2021 16:48:46 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 7sm3206442pgk.55.2021.11.11.16.48.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 16:48:45 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: hci_sync: Convert MGMT_OP_SET_DISCOVERABLE to use cmd_sync
Date:   Thu, 11 Nov 2021 16:48:42 -0800
Message-Id: <20211112004844.176271-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes MGMT_OP_SET_DISCOVERABLE use hci_cmd_sync_queue instead of
use a dedicated discoverable_update work.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 -
 include/net/bluetooth/hci_sync.h |  3 ++
 net/bluetooth/hci_request.c      | 12 -----
 net/bluetooth/hci_sync.c         | 90 +++++++++++++++++++++++++++++++-
 net/bluetooth/mgmt.c             | 43 +++++++--------
 5 files changed, 112 insertions(+), 38 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index cb5684da3ed4..9a56957c5967 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -497,7 +497,6 @@ struct hci_dev {
 	struct work_struct	bg_scan_update;
 	struct work_struct	scan_update;
 	struct work_struct	connectable_update;
-	struct work_struct	discoverable_update;
 	struct delayed_work	le_scan_disable;
 	struct delayed_work	le_scan_restart;
 
@@ -1833,7 +1832,6 @@ void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
 void mgmt_smp_complete(struct hci_conn *conn, bool complete);
 bool mgmt_get_connectable(struct hci_dev *hdev);
 void mgmt_set_connectable_complete(struct hci_dev *hdev, u8 status);
-void mgmt_set_discoverable_complete(struct hci_dev *hdev, u8 status);
 u8 mgmt_get_adv_discov_flags(struct hci_dev *hdev);
 void mgmt_advertising_added(struct sock *sk, struct hci_dev *hdev,
 			    u8 instance);
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 00b13e8ca800..d335c0ce8c5d 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -90,6 +90,9 @@ int hci_dev_close_sync(struct hci_dev *hdev);
 int hci_powered_update_sync(struct hci_dev *hdev);
 int hci_set_powered_sync(struct hci_dev *hdev, u8 val);
 
+int hci_update_discoverable_sync(struct hci_dev *hdev);
+int hci_update_discoverable(struct hci_dev *hdev);
+
 int hci_start_discovery_sync(struct hci_dev *hdev);
 int hci_stop_discovery_sync(struct hci_dev *hdev);
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 8aa6e1840c9a..9f355d8c34f2 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -2131,16 +2131,6 @@ static int discoverable_update(struct hci_request *req, unsigned long opt)
 	return 0;
 }
 
-static void discoverable_update_work(struct work_struct *work)
-{
-	struct hci_dev *hdev = container_of(work, struct hci_dev,
-					    discoverable_update);
-	u8 status;
-
-	hci_req_sync(hdev, discoverable_update, 0, HCI_CMD_TIMEOUT, &status);
-	mgmt_set_discoverable_complete(hdev, status);
-}
-
 void __hci_abort_conn(struct hci_request *req, struct hci_conn *conn,
 		      u8 reason)
 {
@@ -2852,7 +2842,6 @@ void hci_request_setup(struct hci_dev *hdev)
 	INIT_WORK(&hdev->bg_scan_update, bg_scan_update);
 	INIT_WORK(&hdev->scan_update, scan_update_work);
 	INIT_WORK(&hdev->connectable_update, connectable_update_work);
-	INIT_WORK(&hdev->discoverable_update, discoverable_update_work);
 	INIT_DELAYED_WORK(&hdev->discov_off, discov_off);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
 	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
@@ -2868,7 +2857,6 @@ void hci_request_cancel_all(struct hci_dev *hdev)
 	cancel_work_sync(&hdev->bg_scan_update);
 	cancel_work_sync(&hdev->scan_update);
 	cancel_work_sync(&hdev->connectable_update);
-	cancel_work_sync(&hdev->discoverable_update);
 	cancel_delayed_work_sync(&hdev->discov_off);
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
 	cancel_delayed_work_sync(&hdev->le_scan_restart);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 32ed7da3b6dd..205823f21fff 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1740,7 +1740,6 @@ static int hci_resume_advertising_sync(struct hci_dev *hdev)
 	hdev->advertising_paused = false;
 	if (hdev->advertising_old_state) {
 		hci_dev_set_flag(hdev, HCI_ADVERTISING);
-		queue_work(hdev->req_workqueue, &hdev->discoverable_update);
 		hdev->advertising_old_state = 0;
 	}
 
@@ -4429,6 +4428,95 @@ int hci_set_powered_sync(struct hci_dev *hdev, u8 val)
 	return hci_power_off_sync(hdev);
 }
 
+static int hci_write_iac_sync(struct hci_dev *hdev)
+{
+	struct hci_cp_write_current_iac_lap cp;
+
+	if (!hci_dev_test_flag(hdev, HCI_DISCOVERABLE))
+		return 0;
+
+	memset(&cp, 0, sizeof(cp));
+
+	if (hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE)) {
+		/* Limited discoverable mode */
+		cp.num_iac = min_t(u8, hdev->num_iac, 2);
+		cp.iac_lap[0] = 0x00;	/* LIAC */
+		cp.iac_lap[1] = 0x8b;
+		cp.iac_lap[2] = 0x9e;
+		cp.iac_lap[3] = 0x33;	/* GIAC */
+		cp.iac_lap[4] = 0x8b;
+		cp.iac_lap[5] = 0x9e;
+	} else {
+		/* General discoverable mode */
+		cp.num_iac = 1;
+		cp.iac_lap[0] = 0x33;	/* GIAC */
+		cp.iac_lap[1] = 0x8b;
+		cp.iac_lap[2] = 0x9e;
+	}
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_WRITE_CURRENT_IAC_LAP,
+				     (cp.num_iac * 3) + 1, &cp,
+				     HCI_CMD_TIMEOUT);
+}
+
+int hci_update_discoverable_sync(struct hci_dev *hdev)
+{
+	int err = 0;
+
+	if (hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
+		err = hci_write_iac_sync(hdev);
+		if (err)
+			return err;
+
+		err = hci_update_scan_sync(hdev);
+		if (err)
+			return err;
+
+		err = hci_update_class_sync(hdev);
+		if (err)
+			return err;
+	}
+
+	/* Advertising instances don't use the global discoverable setting, so
+	 * only update AD if advertising was enabled using Set Advertising.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
+		err = hci_update_adv_data_sync(hdev, 0x00);
+		if (err)
+			return err;
+
+		/* Discoverable mode affects the local advertising
+		 * address in limited privacy mode.
+		 */
+		if (hci_dev_test_flag(hdev, HCI_LIMITED_PRIVACY)) {
+			if (ext_adv_capable(hdev))
+				err = hci_start_ext_adv_sync(hdev, 0x00);
+			else
+				err = hci_enable_advertising_sync(hdev);
+		}
+	}
+
+	return err;
+}
+
+static int update_discoverable_sync(struct hci_dev *hdev, void *data)
+{
+	return hci_update_discoverable_sync(hdev);
+}
+
+int hci_update_discoverable(struct hci_dev *hdev)
+{
+	/* Only queue if it would have any effect */
+	if (hdev_is_powered(hdev) &&
+	    hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
+	    hci_dev_test_flag(hdev, HCI_DISCOVERABLE) &&
+	    hci_dev_test_flag(hdev, HCI_LIMITED_PRIVACY))
+		return hci_cmd_sync_queue(hdev, update_discoverable_sync, NULL,
+					  NULL);
+
+	return 0;
+}
+
 static int hci_inquiry_sync(struct hci_dev *hdev, u8 length)
 {
 	const u8 giac[3] = { 0x33, 0x8b, 0x9e };
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8a8376d32be3..1cb5d9113863 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1370,23 +1370,20 @@ static u8 mgmt_le_support(struct hci_dev *hdev)
 		return MGMT_STATUS_SUCCESS;
 }
 
-void mgmt_set_discoverable_complete(struct hci_dev *hdev, u8 status)
+static void mgmt_set_discoverable_complete(struct hci_dev *hdev, void *data,
+					   int err)
 {
-	struct mgmt_pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd = data;
 
-	bt_dev_dbg(hdev, "status 0x%02x", status);
+	bt_dev_dbg(hdev, "err %d", err);
 
 	hci_dev_lock(hdev);
 
-	cmd = pending_find(MGMT_OP_SET_DISCOVERABLE, hdev);
-	if (!cmd)
-		goto unlock;
-
-	if (status) {
-		u8 mgmt_err = mgmt_status(status);
+	if (err) {
+		u8 mgmt_err = mgmt_status(err);
 		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
 		hci_dev_clear_flag(hdev, HCI_LIMITED_DISCOVERABLE);
-		goto remove_cmd;
+		goto done;
 	}
 
 	if (hci_dev_test_flag(hdev, HCI_DISCOVERABLE) &&
@@ -1398,13 +1395,18 @@ void mgmt_set_discoverable_complete(struct hci_dev *hdev, u8 status)
 	send_settings_rsp(cmd->sk, MGMT_OP_SET_DISCOVERABLE, hdev);
 	new_settings(hdev, cmd->sk);
 
-remove_cmd:
-	mgmt_pending_remove(cmd);
-
-unlock:
+done:
+	mgmt_pending_free(cmd);
 	hci_dev_unlock(hdev);
 }
 
+static int set_discoverable_sync(struct hci_dev *hdev, void *data)
+{
+	BT_DBG("%s", hdev->name);
+
+	return hci_update_discoverable_sync(hdev);
+}
+
 static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 			    u16 len)
 {
@@ -1503,7 +1505,7 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_SET_DISCOVERABLE, hdev, data, len);
+	cmd = mgmt_pending_new(sk, MGMT_OP_SET_DISCOVERABLE, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -1527,8 +1529,8 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 	else
 		hci_dev_clear_flag(hdev, HCI_LIMITED_DISCOVERABLE);
 
-	queue_work(hdev->req_workqueue, &hdev->discoverable_update);
-	err = 0;
+	err = hci_cmd_sync_queue(hdev, set_discoverable_sync, cmd,
+				 mgmt_set_discoverable_complete);
 
 failed:
 	hci_dev_unlock(hdev);
@@ -1677,12 +1679,7 @@ static int set_bondable(struct sock *sk, struct hci_dev *hdev, void *data,
 		/* In limited privacy mode the change of bondable mode
 		 * may affect the local advertising address.
 		 */
-		if (hdev_is_powered(hdev) &&
-		    hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
-		    hci_dev_test_flag(hdev, HCI_DISCOVERABLE) &&
-		    hci_dev_test_flag(hdev, HCI_LIMITED_PRIVACY))
-			queue_work(hdev->req_workqueue,
-				   &hdev->discoverable_update);
+		hci_update_discoverable(hdev);
 
 		err = new_settings(hdev, sk);
 	}
-- 
2.33.1

