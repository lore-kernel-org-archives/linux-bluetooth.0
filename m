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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A501C43460
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 17:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4A67611F0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 17:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239719AbhDSRNi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Apr 2021 13:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239734AbhDSRNh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Apr 2021 13:13:37 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ABDC06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 10:13:06 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id i190so23619516pfc.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 10:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7l06iCPCqe7tfAeRX2AN5/2NNYWR9OufThvX7tag8gY=;
        b=g9r/GDRl9jaVtN8ddz1ZYyPR545IqqylFNubjuNhQ+eWI8i/RJKZEZRHAL2fSRx5wn
         V7iv3cH4U5OQ2rQ5eqN7sX7rbsQ0holSWvmcwkCcYrvWrlzdOxv8J7yb5M7mfd841eKw
         CvyUYp59esBDSwarYMZxgR/vjyx1tDvOzRjtyeADZNruaZef+6biVouio/nsHdRTMghi
         Iqs95gl5KZvIQYO/3O2qxmuvKGVmbYnHlBD+ek9f0bHk95j5BZEoMKIG08kXP/ltfa49
         8nxV2vCnGXtQ2TyhKaRkdOgMa2SeDxG1ifug6GGwkeKBTE5p1wbAUu36ur5QsrGrU5V8
         nsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7l06iCPCqe7tfAeRX2AN5/2NNYWR9OufThvX7tag8gY=;
        b=RcfN3xqlieSEIO8sNgp1OxW7Nkn6bE4+ksoAXskFRg3VrFKQTErmIpi6c2OxiCV0H1
         988F8SJQt6gpQ/F4Ety/m8CA4fYteqsnO1aXyn8dOb0zR0KP8GVWNRRCf2t+b1wOyLr4
         S6XOejvScQeYqCOYrJEhRXaulUTM7DIcQImHOf0EVGB6tr45jYF5ltI32uTdv19I51WJ
         gTLc8FkUPkWMviPKc/CBn4iuHl18r/5j2OUSLMT8GBDGshQ/4E2apoxkwqNeZ76es2GB
         +1olqvU6cjmIWeHnbHUgRLLLVOLubld7taeAqxW1F/tJNKzDFf4qHXV8wRPsK+Mdq+yJ
         7KSA==
X-Gm-Message-State: AOAM5308q1kn8FMFE0raP1OstCyWgO+BhGrgdW/rYiFdczX45FsKDITZ
        VmJgi8vy1XT1qSjjcUZ1Vq4JNaUxDhIwtw==
X-Google-Smtp-Source: ABdhPJwwSi2qjQVzqhxJReDxIOM7KDS2SlQ4SK8Io6tnLjgo4Y8DnxHpnVMxDkE4InDrfmxCopHJjw==
X-Received: by 2002:a65:5282:: with SMTP id y2mr13102906pgp.293.1618852385674;
        Mon, 19 Apr 2021 10:13:05 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d71sm7669029pfd.83.2021.04.19.10.13.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 10:13:05 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 10/10] Bluetooth: HCI: Use skb_pull to parse LE Direct Advertising Report event
Date:   Mon, 19 Apr 2021 10:12:57 -0700
Message-Id: <20210419171257.3865181-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419171257.3865181-1-luiz.dentz@gmail.com>
References: <20210419171257.3865181-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses skb_pull to check the LE Direct Advertising Report events
received have the minimum required length.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h |  7 ++++++-
 net/bluetooth/hci_event.c   | 26 +++++++++++++++++++-------
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 9600cc6ad952..13b7c7747bd1 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2382,7 +2382,7 @@ struct hci_ev_le_data_len_change {
 
 #define HCI_EV_LE_DIRECT_ADV_REPORT	0x0B
 struct hci_ev_le_direct_adv_info {
-	__u8	 evt_type;
+	__u8	 type;
 	__u8	 bdaddr_type;
 	bdaddr_t bdaddr;
 	__u8	 direct_addr_type;
@@ -2390,6 +2390,11 @@ struct hci_ev_le_direct_adv_info {
 	__s8	 rssi;
 } __packed;
 
+struct hci_ev_le_direct_adv_report {
+	__u8	 num;
+	struct hci_ev_le_direct_adv_info info[];
+} __packed;
+
 #define HCI_EV_LE_PHY_UPDATE_COMPLETE	0x0c
 struct hci_ev_le_phy_update_complete {
 	__u8  status;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6aa05d7364bc..18788687567e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6591,19 +6591,31 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
 static void hci_le_direct_adv_report_evt(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
-	u8 num_reports = skb->data[0];
-	struct hci_ev_le_direct_adv_info *ev = (void *)&skb->data[1];
+	struct hci_ev_le_direct_adv_report *ev;
+	int i;
+
+	ev = hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_DIRECT_ADV_REPORT,
+				sizeof(*ev));
+	if (!ev)
+		return;
 
-	if (!num_reports || skb->len < num_reports * sizeof(*ev) + 1)
+	if (!hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_DIRECT_ADV_REPORT,
+				flex_array_size(ev, info, ev->num)))
+		return;
+
+	if (!ev->num)
 		return;
 
 	hci_dev_lock(hdev);
 
-	for (; num_reports; num_reports--, ev++)
-		process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
-				   ev->bdaddr_type, &ev->direct_addr,
-				   ev->direct_addr_type, ev->rssi, NULL, 0,
+	for (i = 0; i < ev->num; i++) {
+		struct hci_ev_le_direct_adv_info *info = &ev->info[i];
+
+		process_adv_report(hdev, info->type, &info->bdaddr,
+				   info->bdaddr_type, &info->direct_addr,
+				   info->direct_addr_type, info->rssi, NULL, 0,
 				   false);
+	}
 
 	hci_dev_unlock(hdev);
 }
-- 
2.30.2

