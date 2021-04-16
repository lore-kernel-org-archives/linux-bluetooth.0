Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE33AC433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 21:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7087613C3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 21:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344225AbhDPVWI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Apr 2021 17:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344171AbhDPVVq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Apr 2021 17:21:46 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FF9C061763
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 14:18:31 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id p16so10693880plf.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 14:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=y/n6bJCtBJtpjQIG7CTP7Rsauk58CJ+mTL84jH5rvFk=;
        b=gz+oyHxyZPc72pzTN5uFytpFED88PEOPonkec9dXLJoQLeOH5GCae3BA8TFoqfz/JI
         bXS1V20l47ih0tjOtWeOV6rMbbsXv7qjrkPR1qhlfXOTepYM3VWRcOwtT8w7t9HwWawb
         JmxhH+F6Y4qWiKyp4OUZQUJTsxUynvpMrjjBjonSxeA3RKrnIgeuTeEV3EhIkPjrXqmO
         TmmjCNxUqLM577r5t5/f0F2q8s5KeqQ3GkfiDYI6lCU53nvCIIjmaxBlt6IE7QXTnSux
         zfVeCxmrpIJWaOtZronwnfinKLeVXO90rTutSBNhII44SHl8hcQuP59ahuh2PQBPph3W
         38jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y/n6bJCtBJtpjQIG7CTP7Rsauk58CJ+mTL84jH5rvFk=;
        b=m1A3GKCoRrhHtehyrbPaiexKHPKk+k7U/RFi181qgrwmCXcdfoC4u9/7taA1UcSMmx
         bGVLGo4o2ywbBxA3tBUdE5laiyqKFd6r7RAWMzz/lyMfj18UDvGs5Ycqbi4JT9+yJ6xL
         +NGMicyzvokMlSILvam5OfXwF7MX1hswe19yircLcewyVa9hIITGqtalkV/+TE76pcJv
         IklGYK0SJlSqjTjapCwh16qIcXQuspCH4FuzwsKlykaAQBbNbY9VBbJKVQB5lsXqZ/MN
         T8Oo+4nrjZg1a2mZqrpOz4nbmnFqDrhcU+ZiESoHrHWO81+xUy4QNdLFJyIuHNgYwXo0
         0hKw==
X-Gm-Message-State: AOAM532u9qHMOOVH8yAryRWXdxJa4H4aOaCY/f/mgYJcAKaIs7IkQGq2
        TtPYhLEzO5aCRH8B2/ap3/fVjxOecGiJ0w==
X-Google-Smtp-Source: ABdhPJwT0/8dGO7So6wGglGT3HASed4UN3uWeppTHmIJPyTb4gbvnbc8iAOYBqZK4lFcs+S5ZE5Vxg==
X-Received: by 2002:a17:90a:a589:: with SMTP id b9mr7749053pjq.80.1618607910488;
        Fri, 16 Apr 2021 14:18:30 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z29sm5829843pga.52.2021.04.16.14.18.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 14:18:30 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/10] Bluetooth: HCI: Use skb_pull to parse Inquiry Result with RSSI event
Date:   Fri, 16 Apr 2021 14:18:18 -0700
Message-Id: <20210416211823.3776677-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416211823.3776677-1-luiz.dentz@gmail.com>
References: <20210416211823.3776677-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses skb_pull to check the Inquiry Result with RSSI events
received have the minimum required length.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h | 12 +++++++++--
 net/bluetooth/hci_event.c   | 40 +++++++++++++++++++++----------------
 2 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b65205b4d830..53e16ad79698 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2076,7 +2076,7 @@ struct hci_ev_pscan_rep_mode {
 } __packed;
 
 #define HCI_EV_INQUIRY_RESULT_WITH_RSSI	0x22
-struct inquiry_info_with_rssi {
+struct inquiry_info_rssi {
 	bdaddr_t bdaddr;
 	__u8     pscan_rep_mode;
 	__u8     pscan_period_mode;
@@ -2084,7 +2084,7 @@ struct inquiry_info_with_rssi {
 	__le16   clock_offset;
 	__s8     rssi;
 } __packed;
-struct inquiry_info_with_rssi_and_pscan_mode {
+struct inquiry_info_rssi_pscan {
 	bdaddr_t bdaddr;
 	__u8     pscan_rep_mode;
 	__u8     pscan_period_mode;
@@ -2093,6 +2093,14 @@ struct inquiry_info_with_rssi_and_pscan_mode {
 	__le16   clock_offset;
 	__s8     rssi;
 } __packed;
+struct hci_ev_inquiry_result_rssi {
+	__u8     num;
+	struct inquiry_info_rssi info[];
+} __packed;
+struct hci_ev_inquiry_result_rssi_pscan {
+	__u8     num;
+	struct inquiry_info_rssi_pscan info[];
+} __packed;
 
 #define HCI_EV_REMOTE_EXT_FEATURES	0x23
 struct hci_ev_remote_ext_features {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8fa11e99b1cb..d0e7744e9e7e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4721,12 +4721,21 @@ static void hci_pscan_rep_mode_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 					     struct sk_buff *skb)
 {
+	union {
+		struct hci_ev_inquiry_result_rssi *res1;
+		struct hci_ev_inquiry_result_rssi_pscan *res2;
+	} *ev;
 	struct inquiry_data data;
-	int num_rsp = *((__u8 *) skb->data);
+	int i;
 
-	BT_DBG("%s num_rsp %d", hdev->name, num_rsp);
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_INQUIRY_RESULT_WITH_RSSI,
+			     sizeof(*ev));
+	if (!ev)
+		return;
+
+	BT_DBG("%s num_rsp %d", hdev->name, ev->res1->num);
 
-	if (!num_rsp)
+	if (!ev->res1->num)
 		return;
 
 	if (hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))
@@ -4734,16 +4743,13 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	if ((skb->len - 1) / num_rsp != sizeof(struct inquiry_info_with_rssi)) {
-		struct inquiry_info_with_rssi_and_pscan_mode *info;
-		info = (void *) (skb->data + 1);
+	if (skb->len == flex_array_size(ev, res2->info, ev->res2->num)) {
+		struct inquiry_info_rssi_pscan *info;
 
-		if (skb->len < num_rsp * sizeof(*info) + 1)
-			goto unlock;
-
-		for (; num_rsp; num_rsp--, info++) {
+		for (i = 0; i < ev->res2->num; i++) {
 			u32 flags;
 
+			info = &ev->res2->info[i];
 			bacpy(&data.bdaddr, &info->bdaddr);
 			data.pscan_rep_mode	= info->pscan_rep_mode;
 			data.pscan_period_mode	= info->pscan_period_mode;
@@ -4759,15 +4765,13 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 					  info->dev_class, info->rssi,
 					  flags, NULL, 0, NULL, 0);
 		}
-	} else {
-		struct inquiry_info_with_rssi *info = (void *) (skb->data + 1);
+	} else if (skb->len == flex_array_size(ev, res1->info, ev->res1->num)) {
+		struct inquiry_info_rssi *info;
 
-		if (skb->len < num_rsp * sizeof(*info) + 1)
-			goto unlock;
-
-		for (; num_rsp; num_rsp--, info++) {
+		for (i = 0; i < ev->res1->num; i++) {
 			u32 flags;
 
+			info = &ev->res1->info[i];
 			bacpy(&data.bdaddr, &info->bdaddr);
 			data.pscan_rep_mode	= info->pscan_rep_mode;
 			data.pscan_period_mode	= info->pscan_period_mode;
@@ -4783,9 +4787,11 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 					  info->dev_class, info->rssi,
 					  flags, NULL, 0, NULL, 0);
 		}
+	} else {
+		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
+			   HCI_EV_INQUIRY_RESULT_WITH_RSSI);
 	}
 
-unlock:
 	hci_dev_unlock(hdev);
 }
 
-- 
2.30.2

