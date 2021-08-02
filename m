Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8889C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 23:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEBDD603E7
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 23:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhHBX4e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Aug 2021 19:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbhHBX4d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Aug 2021 19:56:33 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4262FC0613D5
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Aug 2021 16:56:22 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso2303295pjo.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Aug 2021 16:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VqPp9ax9hmSy0Y9GusHNh2RMgAWe6Z1OPdjcFyB7X80=;
        b=q1J6TWdjvg7OqNr26tNkxaRAbimyxhFydvPj9Nm27gta75pRGoN6WPaQazSDh0QpgE
         Aj3f3mWfGw9TLuILzE1bfbyXJxurZn7I9+iibc/N9bNMAC1eNdYyM/J4UzcP66QoBzFe
         4fZplWkuH3xBJmBf4qn78OvmeJeXzXF1gk76yncy383pJzJj4qJ661hSEgQp0OHROe50
         /Mw6cZpDUkeXXP8ZJeRMiX6iqV2T2nf6c8K99WuL2nM6JBouJDxSwn8VPpdp68+ViiLh
         XhG0xrFcZtELDrzp9RHvy0y8b6UYyDoltkX+fijxkafWzMyfevKa5dQ7dwVknseCo6b3
         ZDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VqPp9ax9hmSy0Y9GusHNh2RMgAWe6Z1OPdjcFyB7X80=;
        b=KJ4u+FKjtwAIWdwSRXZ2j3Q3xBDqmAALcqlQZVyyIGNqzFyRBvBb4LtqAWlUYq29pS
         xoS0+gzReV7ZcNxNAO8JGxNbEANlSHtL7aMf04GYJQ8xQrb8PWhgNlr6rapLotRrNrWU
         4PeaQ9xXiBXhEhXDXjNC1oA5JpIo1Ie3BbtWtUJGWSyruym3D8rMl/7+O+rgZlDcoSbG
         uAyUYlo0bNP91OVQLUsknstN5I6woAzBZKpzPO+FLPrSlDZ2EhZGOFULOA5njTb9t8zO
         MQN4CWc3+R+CbrxDkVjttgmlMB6/zjuoF2j9Zvn1fCho16/Tjm7mjUWC6iIHCDwg2fAL
         gXzw==
X-Gm-Message-State: AOAM53372UFsnclu0x1G0GoPHsO3/1CborIgc/v/4sHFQw8lzEI66SV4
        9QaqawuU6mC7I9wmEoUXDm9TUrsKEY8=
X-Google-Smtp-Source: ABdhPJyvmZvtl7rhrH/hx71WRnu8sy2yc3G3iD6WsFj398z4rQrPnSDiZQNI0tlVxwJIvcfgrtOiGA==
X-Received: by 2002:a63:374e:: with SMTP id g14mr1348002pgn.170.1627948581608;
        Mon, 02 Aug 2021 16:56:21 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y24sm12358676pfp.191.2021.08.02.16.56.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 16:56:21 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RESEND 2/2] Bluetooth: Fix not generating RPA when required
Date:   Mon,  2 Aug 2021 16:56:19 -0700
Message-Id: <20210802235619.238065-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210802235619.238065-1-luiz.dentz@gmail.com>
References: <20210802235619.238065-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Code was checking if random_addr and hdev->rpa match without first
checking if the RPA has not been set (BDADDR_ANY), furthermore it was
clearing HCI_RPA_EXPIRED before the command completes and the RPA is
actually programmed which in case of failure would leave the expired
RPA still set.

Since advertising instance have a similar problem the clearing of
HCI_RPA_EXPIRED has been moved to hci_event.c after checking the random
address is in fact the hdev->rap and then proceed to set the expire
timeout.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  4 ++
 net/bluetooth/hci_event.c        | 32 +++++++++----
 net/bluetooth/hci_request.c      | 81 ++++++++++++++------------------
 3 files changed, 61 insertions(+), 56 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b79b31359bf8..b011eeea28c3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1413,6 +1413,10 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 				!hci_dev_test_flag(dev, HCI_AUTO_OFF))
 #define bredr_sc_enabled(dev)  (lmp_sc_capable(dev) && \
 				hci_dev_test_flag(dev, HCI_SC_ENABLED))
+#define rpa_valid(dev)         (bacmp(&dev->rpa, BDADDR_ANY) && \
+				!hci_dev_test_flag(dev, HCI_RPA_EXPIRED))
+#define adv_rpa_valid(adv)     (bacmp(&adv->random_addr, BDADDR_ANY) && \
+				!adv->rpa_expired)
 
 #define scan_1m(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_1M) || \
 		      ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_1M))
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 35c5cc9f91b0..38decf474f31 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -40,6 +40,8 @@
 #define ZERO_KEY "\x00\x00\x00\x00\x00\x00\x00\x00" \
 		 "\x00\x00\x00\x00\x00\x00\x00\x00"
 
+#define secs_to_jiffies(_secs) msecs_to_jiffies((_secs) * 1000)
+
 /* Handle HCI Event packets */
 
 static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb,
@@ -1171,6 +1173,12 @@ static void hci_cc_le_set_random_addr(struct hci_dev *hdev, struct sk_buff *skb)
 
 	bacpy(&hdev->random_addr, sent);
 
+	if (!bacmp(&hdev->rpa, sent)) {
+		hci_dev_clear_flag(hdev, HCI_RPA_EXPIRED);
+		queue_delayed_work(hdev->workqueue, &hdev->rpa_expired,
+				   secs_to_jiffies(hdev->rpa_timeout));
+	}
+
 	hci_dev_unlock(hdev);
 }
 
@@ -1201,24 +1209,30 @@ static void hci_cc_le_set_adv_set_random_addr(struct hci_dev *hdev,
 {
 	__u8 status = *((__u8 *) skb->data);
 	struct hci_cp_le_set_adv_set_rand_addr *cp;
-	struct adv_info *adv_instance;
+	struct adv_info *adv;
 
 	if (status)
 		return;
 
 	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_ADV_SET_RAND_ADDR);
-	if (!cp)
+	/* Update only in case the adv instance since handle 0x00 shall be using
+	 * HCI_OP_LE_SET_RANDOM_ADDR since that allows both extended and
+	 * non-extended adverting.
+	 */
+	if (!cp || !cp->handle)
 		return;
 
 	hci_dev_lock(hdev);
 
-	if (!cp->handle) {
-		/* Store in hdev for instance 0 (Set adv and Directed advs) */
-		bacpy(&hdev->random_addr, &cp->bdaddr);
-	} else {
-		adv_instance = hci_find_adv_instance(hdev, cp->handle);
-		if (adv_instance)
-			bacpy(&adv_instance->random_addr, &cp->bdaddr);
+	adv = hci_find_adv_instance(hdev, cp->handle);
+	if (adv) {
+		bacpy(&adv->random_addr, &cp->bdaddr);
+		if (!bacmp(&hdev->rpa, &cp->bdaddr)) {
+			adv->rpa_expired = false;
+			queue_delayed_work(hdev->workqueue,
+					   &adv->rpa_expired_cb,
+					   secs_to_jiffies(hdev->rpa_timeout));
+		}
 	}
 
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 1d14adc023e9..f15626607b2d 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -2072,8 +2072,6 @@ int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 	 * current RPA has expired then generate a new one.
 	 */
 	if (use_rpa) {
-		int to;
-
 		/* If Controller supports LL Privacy use own address type is
 		 * 0x03
 		 */
@@ -2084,14 +2082,10 @@ int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 			*own_addr_type = ADDR_LE_DEV_RANDOM;
 
 		if (adv_instance) {
-			if (!adv_instance->rpa_expired &&
-			    !bacmp(&adv_instance->random_addr, &hdev->rpa))
+			if (adv_rpa_valid(adv_instance))
 				return 0;
-
-			adv_instance->rpa_expired = false;
 		} else {
-			if (!hci_dev_test_and_clear_flag(hdev, HCI_RPA_EXPIRED) &&
-			    !bacmp(&hdev->random_addr, &hdev->rpa))
+			if (rpa_valid(hdev))
 				return 0;
 		}
 
@@ -2103,14 +2097,6 @@ int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 
 		bacpy(rand_addr, &hdev->rpa);
 
-		to = msecs_to_jiffies(hdev->rpa_timeout * 1000);
-		if (adv_instance)
-			queue_delayed_work(hdev->workqueue,
-					   &adv_instance->rpa_expired_cb, to);
-		else
-			queue_delayed_work(hdev->workqueue,
-					   &hdev->rpa_expired, to);
-
 		return 0;
 	}
 
@@ -2153,6 +2139,30 @@ void __hci_req_clear_ext_adv_sets(struct hci_request *req)
 	hci_req_add(req, HCI_OP_LE_CLEAR_ADV_SETS, 0, NULL);
 }
 
+static void set_random_addr(struct hci_request *req, bdaddr_t *rpa)
+{
+	struct hci_dev *hdev = req->hdev;
+
+	/* If we're advertising or initiating an LE connection we can't
+	 * go ahead and change the random address at this time. This is
+	 * because the eventual initiator address used for the
+	 * subsequently created connection will be undefined (some
+	 * controllers use the new address and others the one we had
+	 * when the operation started).
+	 *
+	 * In this kind of scenario skip the update and let the random
+	 * address be updated at the next cycle.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_LE_ADV) ||
+	    hci_lookup_le_connect(hdev)) {
+		bt_dev_dbg(hdev, "Deferring random address update");
+		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
+		return;
+	}
+
+	hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6, rpa);
+}
+
 int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
 {
 	struct hci_cp_le_set_ext_adv_params cp;
@@ -2255,6 +2265,13 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
 		} else {
 			if (!bacmp(&random_addr, &hdev->random_addr))
 				return 0;
+			/* Instance 0x00 doesn't have an adv_info, instead it
+			 * uses hdev->random_addr to track its address so
+			 * whenever it needs to be updated this also set the
+			 * random address since hdev->random_addr is shared with
+			 * scan state machine.
+			 */
+			set_random_addr(req, &random_addr);
 		}
 
 		memset(&cp, 0, sizeof(cp));
@@ -2512,30 +2529,6 @@ void hci_req_clear_adv_instance(struct hci_dev *hdev, struct sock *sk,
 						false);
 }
 
-static void set_random_addr(struct hci_request *req, bdaddr_t *rpa)
-{
-	struct hci_dev *hdev = req->hdev;
-
-	/* If we're advertising or initiating an LE connection we can't
-	 * go ahead and change the random address at this time. This is
-	 * because the eventual initiator address used for the
-	 * subsequently created connection will be undefined (some
-	 * controllers use the new address and others the one we had
-	 * when the operation started).
-	 *
-	 * In this kind of scenario skip the update and let the random
-	 * address be updated at the next cycle.
-	 */
-	if (hci_dev_test_flag(hdev, HCI_LE_ADV) ||
-	    hci_lookup_le_connect(hdev)) {
-		bt_dev_dbg(hdev, "Deferring random address update");
-		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
-		return;
-	}
-
-	hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6, rpa);
-}
-
 int hci_update_random_address(struct hci_request *req, bool require_privacy,
 			      bool use_rpa, u8 *own_addr_type)
 {
@@ -2547,8 +2540,6 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 	 * the current RPA in use, then generate a new one.
 	 */
 	if (use_rpa) {
-		int to;
-
 		/* If Controller supports LL Privacy use own address type is
 		 * 0x03
 		 */
@@ -2558,8 +2549,7 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 		else
 			*own_addr_type = ADDR_LE_DEV_RANDOM;
 
-		if (!hci_dev_test_and_clear_flag(hdev, HCI_RPA_EXPIRED) &&
-		    !bacmp(&hdev->random_addr, &hdev->rpa))
+		if (rpa_valid(hdev))
 			return 0;
 
 		err = smp_generate_rpa(hdev, hdev->irk, &hdev->rpa);
@@ -2570,9 +2560,6 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 
 		set_random_addr(req, &hdev->rpa);
 
-		to = msecs_to_jiffies(hdev->rpa_timeout * 1000);
-		queue_delayed_work(hdev->workqueue, &hdev->rpa_expired, to);
-
 		return 0;
 	}
 
-- 
2.31.1

