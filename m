Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A961AC43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 05:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 609D92137B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 05:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="VSqNFvjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgIQFaB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 01:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgIQF35 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 01:29:57 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EF9C06178B
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 22:29:56 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id c197so687706pfb.23
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 22:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=YQ1655qN+qhX6YCMDSPy+e2SuugQXtZ9Fa++9er50gQ=;
        b=VSqNFvjA/X3aLl2qE0HJI68GKOFNKiAMMyz4/syIfFQ5NrOAfOh86MZhBh2o78ZBYg
         agGANrpqmC9BOGUDUf4McWX7j5LM4pSSDKJxEAd++MVeCmO9bvSs1PPyMM+rRGLZ9W1w
         IlTQxJuGf2rBK7PJ/CrcntP1Wg4p5bA25Dy1T0WBsXavJAUeV1ITIiI+7eHvt4amVPpR
         G0e2dqir/lLtZAL7EqGLFFggwAgcu93+RFoSFp5TRH/BvrYy0HE9laVfx2uD+E5rlq4h
         hDkKaW3Y+m5g7fOIjvNrYYE6fY+/hyTBwER0S14z8tlMC5+zwMmyOEliC/dire9A7rbt
         FQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YQ1655qN+qhX6YCMDSPy+e2SuugQXtZ9Fa++9er50gQ=;
        b=OGDLt5ef8GA3Lnh0UTpZJ24PNbkQvMGrvw8Wy0G89vCBDp9peHZpVUAVLBbunE0V8/
         KE/sIGOPJrPusewzJETsIfCIl3hr4tkJnIzB6AKm3iEF6r+GyizxvkjQ4J5LMPxxNZT5
         3C9sVvRud29arrSRpQGa6wP+Mu67kutUEfvLEnKjAE12pBEcuvhwhKoo0bp60J69t1a6
         oN6qXojcwis7ATRDfQZ6Bv0vU75HWpC/R3w6ECJ4YfmNHKZUgIanJRrhXFskS/7FL2R5
         rAHSLdOaL3KeMPXv6FM/7rEXPpvn1YDr4/4pyCaZygbismaG/kzbxXdGcoEgLst8MGmK
         M+pQ==
X-Gm-Message-State: AOAM5321qZ9zgMg3JUvcsz68/7CV4FHxt+LGkkK+JaYSk0rduLJTqhp5
        d9WmvY6NsxVH1V3y212VkltoKZe6DrIFhyikSUmDHXY5gMZzz+1wD1mk8D1B/vmjZGasTRYjLQw
        cew/+S6B+ABWatzL8Q15pxVo9WEN+ZLnT5iuDvkU3YEHS6NHqx/C7qC4TtJBDy71xFJhEiExvNg
        A9ZtNMKyFnHY0=
X-Google-Smtp-Source: ABdhPJwMtqDMRo/qzuQTUjmjcUBuXEHB34dSJ2yFT85VAU4hVI+C9CpisXk2IT48G4YNLAq++aB4VptZnE9BnOBGnA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a17:902:c401:b029:d1:e603:1bf3 with
 SMTP id k1-20020a170902c401b02900d1e6031bf3mr9554753plk.47.1600320595984;
 Wed, 16 Sep 2020 22:29:55 -0700 (PDT)
Date:   Thu, 17 Sep 2020 13:29:40 +0800
In-Reply-To: <20200917132836.BlueZ.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
Message-Id: <20200917132836.BlueZ.3.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
Mime-Version: 1.0
References: <20200917132836.BlueZ.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [BlueZ PATCH 3/6] Bluetooth: Interleave with allowlist scan
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     mcchou@chromium.org, marcel@holtmann.org, mmandlik@chromium.org,
        howardchung@google.com, luiz.dentz@gmail.com, alainm@chromium.org,
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

 include/net/bluetooth/hci_core.h |  10 +++
 net/bluetooth/hci_core.c         |   4 +
 net/bluetooth/hci_request.c      | 137 +++++++++++++++++++++++++++++--
 net/bluetooth/mgmt_config.c      |  13 +++
 4 files changed, 156 insertions(+), 8 deletions(-)

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
index b30b571f8caf8..6dc3e43dcaa9f 100644
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
 
@@ -138,6 +140,9 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		case 0x0019:
 		case 0x001a:
 		case 0x001b:
+		case 0x001c:
+		case 0x001d:
+		case 0x001e:
 			if (len != sizeof(u16)) {
 				bt_dev_warn(hdev, "invalid length %d, exp %zu for type %d",
 					    len, sizeof(u16), type);
@@ -251,6 +256,14 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
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

