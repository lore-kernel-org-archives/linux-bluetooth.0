Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3446AC433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 08:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F15A32083B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 08:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="GG59YQAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgIQItP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 04:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIQIra (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 04:47:30 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6747C06178A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 01:47:29 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id di5so967277qvb.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 01:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=wGykX3HXy8uSGQU5AA3HqLAsLKRSAYz8xcbgVSMez4w=;
        b=GG59YQAeIPF3uMOrO5tePJPwi80CAvyUoaYrB+PKM3NLo811iPRwRTWaJxgdrwiYuO
         mbUxWfBFtKeOlTuPzSnSkmtHKIL0LYjjf9WoXrsNMkbshNCX2IT5VL+AsV1D7BeGPYjt
         wha0GOuRy3kaKTX+qYosplB5xCq50AuF6+eB21odgFjn9CLViL31XeJhCV9wTHV0dM+c
         2qVqvHKi4qBSmXKeIzjcFYcCkravGPskJoDkkv88BSQx5bXLgeaXkl7DWEDy/qY+n7ES
         mYqHjcKmR8AbcaWnXR+ObYGQ5f7MX5fQWRHKKXe+XeqOAvMkQ3zgeOEAMkUw3nRyhBgD
         ZlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wGykX3HXy8uSGQU5AA3HqLAsLKRSAYz8xcbgVSMez4w=;
        b=tjuGsuVDrvOJ4/jFOjmYcc6fXeCkvFuJyXXu3OyzBD4u2Jw0G4YIgF9SU4S8XisXKn
         fx08Bt6/DbC4IrN7pFZMP023C68u+ho1WoUqUQQ0OyWUia9GAodhNy91OI6J2MbooB6k
         CW61x7UpeMZJ2L/KEVNE8Gg2LdZ5o7Keesa/nq/lDVS9cvXLxGRg2vPP3dx+UEegL8bQ
         u7slZWFVLf3oefIH/iSQDmM8Uua9sYJ5HPSmabIh3IBGauqvV3GEM/tNZFDW0dvYCRKj
         XvDPNDMThAsUOcS6fa0H/Z9y/Z1InE+BzFxBSVZ/BuYBV7NzCEcZexNa5jYJCocnZgbj
         4BvA==
X-Gm-Message-State: AOAM531D5jpRuVFzxIUzVsO8GGyyejZ1MKkXhekDKdjAgRl7IzYOQwUH
        Rg4hFO4/DDKc6hZF92DnxQ69XNVXKFie12K+2A+R/WFD8v1siMOjqafqenPkt2NGcniY/ryCjbl
        3Ctsbbn+0cSI1SSPmFd3VVVQPMqGUIdi5TeAfs6+UwAP/EtsFiRDGpMphawPcD8u8dGMd7yTGjJ
        l3vDywOmNid8A=
X-Google-Smtp-Source: ABdhPJxGj+Q9BZ6wsmjP938dzB3v+npuVzH0FOG5OvkRUnc8Ltl2fmZFJzYqkmYpZVE6l4JQ/QwGWFdMn2k2vK7cTw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:ad4:57a7:: with SMTP id
 g7mr27601946qvx.10.1600332448783; Thu, 17 Sep 2020 01:47:28 -0700 (PDT)
Date:   Thu, 17 Sep 2020 16:47:12 +0800
In-Reply-To: <20200917164632.BlueZ.v2.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
Message-Id: <20200917164632.BlueZ.v2.3.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
Mime-Version: 1.0
References: <20200917164632.BlueZ.v2.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [BlueZ PATCH v2 3/6] Bluetooth: Interleave with allowlist scan
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, mmandlik@chromium.org,
        mcchou@chromium.org, howardchung@google.com, alainm@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch implements the interleaving between allowlist scan and
no-filter scan. It'll be used to save power when at least one monitor is
registered and at least one pending connection or one device to be
scanned for.

The durations of the allowlist scan and the no-filter scan are
controlled by MGMT command: Set Default System Configuration. The
default values are set randomly for now.

Signed-off-by: Howard Chung <howardchung@google.com>
Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
---

Changes in v2:
- remove 'case 0x001c' in mgmt_config.c

 include/net/bluetooth/hci_core.h |  10 +++
 net/bluetooth/hci_core.c         |   4 +
 net/bluetooth/hci_request.c      | 137 +++++++++++++++++++++++++++++--
 net/bluetooth/mgmt_config.c      |  12 +++
 4 files changed, 155 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9873e1c8cd163..179350f869fdb 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -361,6 +361,8 @@ struct hci_dev {
 	__u8		ssp_debug_mode;
 	__u8		hw_error_code;
 	__u32		clock;
+	__u16		advmon_allowlist_duration;
+	__u16		advmon_no_filter_duration;
 
 	__u16		devid_source;
 	__u16		devid_vendor;
@@ -542,6 +544,14 @@ struct hci_dev {
 	struct delayed_work	rpa_expired;
 	bdaddr_t		rpa;
 
+	enum {
+		ADV_MONITOR_SCAN_NONE,
+		ADV_MONITOR_SCAN_NO_FILTER,
+		ADV_MONITOR_SCAN_ALLOWLIST
+	} adv_monitor_scan_state;
+
+	struct delayed_work	interleave_adv_monitor_scan;
+
 #if IS_ENABLED(CONFIG_BT_LEDS)
 	struct led_trigger	*power_led;
 #endif
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f30a1f5950e15..6c8850149265a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3592,6 +3592,10 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->cur_adv_instance = 0x00;
 	hdev->adv_instance_timeout = 0;
 
+	/* The default values will be chosen in the future */
+	hdev->advmon_allowlist_duration = 300;
+	hdev->advmon_no_filter_duration = 500;
+
 	hdev->sniff_max_interval = 800;
 	hdev->sniff_min_interval = 80;
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index d2b06f5c93804..89443b48d90ce 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -378,6 +378,57 @@ void __hci_req_write_fast_connectable(struct hci_request *req, bool enable)
 		hci_req_add(req, HCI_OP_WRITE_PAGE_SCAN_TYPE, 1, &type);
 }
 
+static void start_interleave_scan(struct hci_dev *hdev)
+{
+	hdev->adv_monitor_scan_state = ADV_MONITOR_SCAN_NO_FILTER;
+	queue_delayed_work(hdev->req_workqueue,
+			   &hdev->interleave_adv_monitor_scan, 0);
+}
+
+static bool is_interleave_scanning(struct hci_dev *hdev)
+{
+	return hdev->adv_monitor_scan_state != ADV_MONITOR_SCAN_NONE;
+}
+
+static void cancel_interleave_scan(struct hci_dev *hdev)
+{
+	bt_dev_dbg(hdev, "%s cancelling interleave scan", hdev->name);
+
+	cancel_delayed_work_sync(&hdev->interleave_adv_monitor_scan);
+
+	hdev->adv_monitor_scan_state = ADV_MONITOR_SCAN_NONE;
+}
+
+/* Return true if interleave_scan is running after exiting this function,
+ * otherwise, return false
+ */
+static bool update_adv_monitor_scan_state(struct hci_dev *hdev)
+{
+	if (!hci_is_adv_monitoring(hdev) ||
+	    (list_empty(&hdev->pend_le_conns) &&
+	     list_empty(&hdev->pend_le_reports))) {
+		if (is_interleave_scanning(hdev)) {
+			/* If the interleave condition no longer holds, cancel
+			 * the existed interleave scan.
+			 */
+			cancel_interleave_scan(hdev);
+		}
+		return false;
+	}
+
+	if (!is_interleave_scanning(hdev)) {
+		/* If there is at least one ADV monitors and one pending LE
+		 * connection or one device to be scanned for, we should
+		 * alternate between allowlist scan and one without any filters
+		 * to save power.
+		 */
+		start_interleave_scan(hdev);
+		bt_dev_dbg(hdev, "%s starting interleave scan", hdev->name);
+	}
+
+	return true;
+}
+
 /* This function controls the background scanning based on hdev->pend_le_conns
  * list. If there are pending LE connection we start the background scanning,
  * otherwise we stop it.
@@ -449,9 +500,11 @@ static void __hci_update_background_scan(struct hci_request *req)
 		if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
 			hci_req_add_le_scan_disable(req, false);
 
-		hci_req_add_le_passive_scan(req);
-
-		BT_DBG("%s starting background scanning", hdev->name);
+		if (!update_adv_monitor_scan_state(hdev)) {
+			hci_req_add_le_passive_scan(req);
+			bt_dev_dbg(hdev, "%s starting background scanning",
+				   hdev->name);
+		}
 	}
 }
 
@@ -844,12 +897,17 @@ static u8 update_white_list(struct hci_request *req)
 			return 0x00;
 	}
 
-	/* Once the controller offloading of advertisement monitor is in place,
-	 * the if condition should include the support of MSFT extension
-	 * support. If suspend is ongoing, whitelist should be the default to
-	 * prevent waking by random advertisements.
+	/* Use the allowlist unless the following conditions are all true:
+	 * - We are not currently suspending
+	 * - There are 1 or more ADV monitors registered
+	 * - Interleaved scanning is not currently using the allowlist
+	 *
+	 * Once the controller offloading of advertisement monitor is in place,
+	 * the above condition should include the support of MSFT extension
+	 * support.
 	 */
-	if (!idr_is_empty(&hdev->adv_monitors_idr) && !hdev->suspended)
+	if (!idr_is_empty(&hdev->adv_monitors_idr) && !hdev->suspended &&
+	    hdev->adv_monitor_scan_state != ADV_MONITOR_SCAN_ALLOWLIST)
 		return 0x00;
 
 	/* Select filter policy to use white list */
@@ -1002,6 +1060,7 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 				      &own_addr_type))
 		return;
 
+	bt_dev_dbg(hdev, "interleave state %d", hdev->adv_monitor_scan_state);
 	/* Adding or removing entries from the white list must
 	 * happen before enabling scanning. The controller does
 	 * not allow white list modification while scanning.
@@ -1871,6 +1930,64 @@ static void adv_timeout_expire(struct work_struct *work)
 	hci_dev_unlock(hdev);
 }
 
+static int add_le_interleave_adv_monitor_scan(struct hci_request *req,
+					      unsigned long opt)
+{
+	struct hci_dev *hdev = req->hdev;
+	int ret = 0;
+
+	hci_dev_lock(hdev);
+
+	if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
+		hci_req_add_le_scan_disable(req, false);
+	hci_req_add_le_passive_scan(req);
+
+	switch (hdev->adv_monitor_scan_state) {
+	case ADV_MONITOR_SCAN_ALLOWLIST:
+		bt_dev_dbg(hdev, "next state: allowlist");
+		hdev->adv_monitor_scan_state = ADV_MONITOR_SCAN_NO_FILTER;
+		break;
+	case ADV_MONITOR_SCAN_NO_FILTER:
+		bt_dev_dbg(hdev, "next state: no filter");
+		hdev->adv_monitor_scan_state = ADV_MONITOR_SCAN_ALLOWLIST;
+		break;
+	case ADV_MONITOR_SCAN_NONE:
+	default:
+		BT_ERR("unexpected error");
+		ret = -1;
+	}
+
+	hci_dev_unlock(hdev);
+
+	return ret;
+}
+
+static void interleave_adv_monitor_scan_work(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+					    interleave_adv_monitor_scan.work);
+	u8 status;
+	unsigned long timeout;
+
+	if (hdev->adv_monitor_scan_state == ADV_MONITOR_SCAN_ALLOWLIST) {
+		timeout = msecs_to_jiffies(hdev->advmon_allowlist_duration);
+	} else if (hdev->adv_monitor_scan_state == ADV_MONITOR_SCAN_NO_FILTER) {
+		timeout = msecs_to_jiffies(hdev->advmon_no_filter_duration);
+	} else {
+		bt_dev_err(hdev, "unexpected error");
+		return;
+	}
+
+	hci_req_sync(hdev, add_le_interleave_adv_monitor_scan, 0,
+		     HCI_CMD_TIMEOUT, &status);
+
+	/* Don't continue interleaving if it was canceled */
+	if (is_interleave_scanning(hdev)) {
+		queue_delayed_work(hdev->req_workqueue,
+				   &hdev->interleave_adv_monitor_scan, timeout);
+	}
+}
+
 int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 			   bool use_rpa, struct adv_info *adv_instance,
 			   u8 *own_addr_type, bdaddr_t *rand_addr)
@@ -3292,6 +3409,8 @@ void hci_request_setup(struct hci_dev *hdev)
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
 	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
 	INIT_DELAYED_WORK(&hdev->adv_instance_expire, adv_timeout_expire);
+	INIT_DELAYED_WORK(&hdev->interleave_adv_monitor_scan,
+			  interleave_adv_monitor_scan_work);
 }
 
 void hci_request_cancel_all(struct hci_dev *hdev)
@@ -3311,4 +3430,6 @@ void hci_request_cancel_all(struct hci_dev *hdev)
 		cancel_delayed_work_sync(&hdev->adv_instance_expire);
 		hdev->adv_instance_timeout = 0;
 	}
+
+	cancel_interleave_scan(hdev);
 }
diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index b30b571f8caf8..1802f7023158c 100644
--- a/net/bluetooth/mgmt_config.c
+++ b/net/bluetooth/mgmt_config.c
@@ -67,6 +67,8 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		HDEV_PARAM_U16(0x001a, le_supv_timeout),
 		HDEV_PARAM_U16_JIFFIES_TO_MSECS(0x001b,
 						def_le_autoconnect_timeout),
+		HDEV_PARAM_U16(0x001d, advmon_allowlist_duration),
+		HDEV_PARAM_U16(0x001e, advmon_no_filter_duration),
 	};
 	struct mgmt_rp_read_def_system_config *rp = (void *)params;
 
@@ -138,6 +140,8 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		case 0x0019:
 		case 0x001a:
 		case 0x001b:
+		case 0x001d:
+		case 0x001e:
 			if (len != sizeof(u16)) {
 				bt_dev_warn(hdev, "invalid length %d, exp %zu for type %d",
 					    len, sizeof(u16), type);
@@ -251,6 +255,14 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 			hdev->def_le_autoconnect_timeout =
 					msecs_to_jiffies(TLV_GET_LE16(buffer));
 			break;
+		case 0x0001d:
+			hdev->advmon_allowlist_duration =
+							TLV_GET_LE16(buffer);
+			break;
+		case 0x0001e:
+			hdev->advmon_no_filter_duration =
+							TLV_GET_LE16(buffer);
+			break;
 		default:
 			bt_dev_warn(hdev, "unsupported parameter %u", type);
 			break;
-- 
2.28.0.618.gf4bc123cb7-goog

