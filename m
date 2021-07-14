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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD1EC07E9A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 18:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EEAD613BE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 18:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhGNS7W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jul 2021 14:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhGNS7W (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jul 2021 14:59:22 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8CCC06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 11:56:29 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 21so2870400pfp.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 11:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JoZ6bJXvIKhwQ/JApNHYzhdFZxTYBUWM7GzO593DNzc=;
        b=gIobiSOGHh8Al8D46TKlFzcW5o+4zrN9J2vh09cd47XpPLisH7UAD1oxSVAbV/TAD+
         isKxMOc7at58FO6dXsnPMu3/ykr4pzKKNMgKtlBgrSlQB5Rj5qe9+YB0DrcLFM0+E1hl
         HI6JWAefViUDXPnkiBLHqhMxc7ddQnEyr3ISKQ8on22eIHgf1cJt/jFkCt5oSl9Y5hnL
         wyxSJHtN4sBhiRvTxg5+RXg+buKnj5DimrAjTRQESdGB3Z6xEWktqaS3cjwcMscoId2g
         9UVl/krrMLuBI4rblP5aHcm0m9y5BSDAT7r8qREPnYsTNF5L3jisyXt6uyXZThy+RaMW
         x4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JoZ6bJXvIKhwQ/JApNHYzhdFZxTYBUWM7GzO593DNzc=;
        b=tjhwLQ/ep1iT3oc0raeBwfPRI+h0Ahi+le2z46elK0iOEs1ygk/xTaHcJR420spzsI
         +GoeRJBmyvNO62YKgdRBifFnlJMdipAoSApcwDKvwQajHQgXP+MFI3FuP8eAwVzojGrW
         VL0glSQ6D4QYeh2aix8mZVUXLB9dC4dITgdCOpQefE+v0GSS9LEc9AApHtVLWt4N6FKe
         ORj6jIuWFhF07A8UqDb07MZJntjQ+0mpZiWJfujyXhTMbn5sLy7PaujWy7z5yr7kxabU
         QCQ70vvjr1j9vFyJxC/2nrsHBan53OoqPVv/kGlJmpM4eiO60ilIBg2DL6YotAac8ZR1
         TE/Q==
X-Gm-Message-State: AOAM532SctEkzwHZNcEkTZPtc5ICz/mwxxk8SAbBRfSdzzjFmty48XqX
        VTD1QD5wVkN0p56vQLY1mgR4R62R9LWgtg==
X-Google-Smtp-Source: ABdhPJw4S79ShJS0MyhIVcXoCaShSMhwwpqDhEGCvUfOYMLUcu9Nh7N7BqwBgX+vhk9N5/sWHggZHg==
X-Received: by 2002:a63:e958:: with SMTP id q24mr10992397pgj.438.1626288988204;
        Wed, 14 Jul 2021 11:56:28 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x14sm2841436pjc.4.2021.07.14.11.56.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 11:56:27 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Fix not generating RPA when required
Date:   Wed, 14 Jul 2021 11:56:27 -0700
Message-Id: <20210714185627.2887819-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
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
 include/net/bluetooth/hci_core.h |  4 ++++
 net/bluetooth/hci_event.c        | 28 ++++++++++++++++++++++++----
 net/bluetooth/hci_request.c      | 26 +++-----------------------
 3 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d916729674a0..d1b3c0d5649a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1412,6 +1412,10 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
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
index d7e85049d49d..1fd5b1e60e6d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -40,6 +40,8 @@
 #define ZERO_KEY "\x00\x00\x00\x00\x00\x00\x00\x00" \
 		 "\x00\x00\x00\x00\x00\x00\x00\x00"
 
+#define secs_to_jiffies(_secs) msecs_to_jiffies(_secs * 1000)
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
 
@@ -1201,7 +1209,7 @@ static void hci_cc_le_set_adv_set_random_addr(struct hci_dev *hdev,
 {
 	__u8 status = *((__u8 *) skb->data);
 	struct hci_cp_le_set_adv_set_rand_addr *cp;
-	struct adv_info *adv_instance;
+	struct adv_info *adv;
 
 	if (status)
 		return;
@@ -1215,10 +1223,22 @@ static void hci_cc_le_set_adv_set_random_addr(struct hci_dev *hdev,
 	if (!cp->handle) {
 		/* Store in hdev for instance 0 (Set adv and Directed advs) */
 		bacpy(&hdev->random_addr, &cp->bdaddr);
+		if (!bacmp(&hdev->rpa, &cp->bdaddr)) {
+			hci_dev_clear_flag(hdev, HCI_RPA_EXPIRED);
+			queue_delayed_work(hdev->workqueue, &hdev->rpa_expired,
+					   secs_to_jiffies(hdev->rpa_timeout));
+		}
 	} else {
-		adv_instance = hci_find_adv_instance(hdev, cp->handle);
-		if (adv_instance)
-			bacpy(&adv_instance->random_addr, &cp->bdaddr);
+		adv = hci_find_adv_instance(hdev, cp->handle);
+		if (adv) {
+			bacpy(&adv->random_addr, &cp->bdaddr);
+			if (!bacmp(&hdev->rpa, &cp->bdaddr)) {
+				adv->rpa_expired = false;
+				queue_delayed_work(hdev->workqueue,
+						   &adv->rpa_expired_cb,
+						   secs_to_jiffies(hdev->rpa_timeout));
+			}
+		}
 	}
 
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 1d14adc023e9..eea2c3f5f118 100644
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
 
@@ -2547,8 +2533,6 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 	 * the current RPA in use, then generate a new one.
 	 */
 	if (use_rpa) {
-		int to;
-
 		/* If Controller supports LL Privacy use own address type is
 		 * 0x03
 		 */
@@ -2558,8 +2542,7 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 		else
 			*own_addr_type = ADDR_LE_DEV_RANDOM;
 
-		if (!hci_dev_test_and_clear_flag(hdev, HCI_RPA_EXPIRED) &&
-		    !bacmp(&hdev->random_addr, &hdev->rpa))
+		if (rpa_valid(hdev))
 			return 0;
 
 		err = smp_generate_rpa(hdev, hdev->irk, &hdev->rpa);
@@ -2570,9 +2553,6 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 
 		set_random_addr(req, &hdev->rpa);
 
-		to = msecs_to_jiffies(hdev->rpa_timeout * 1000);
-		queue_delayed_work(hdev->workqueue, &hdev->rpa_expired, to);
-
 		return 0;
 	}
 
-- 
2.31.1

