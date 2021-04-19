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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463F1C433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 17:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17BA9611F0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 17:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbhDSRNg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Apr 2021 13:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239712AbhDSRNe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Apr 2021 13:13:34 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9876C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 10:13:04 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id e2so13780333plh.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 10:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bezyZJ/OjO9VYDt3R7xKaKwfrY2dmHyj5/J8CMS0GJE=;
        b=qov59N6r7tZ3L4ItJfwgRxENnmSG47GG0LCDJUhHkA4JnFVq2YBkW7yXnGKomp/Vjd
         ZXsVrBONUB88KpTJjiwiQ5SgHsNqAJxvLaP62Rf5TeoLbq39PTg4rgt3bsgU5ZNvFqvG
         +5P4uCEERBcLAqgRd9k4s0to2da2XNSsEJmzKlXyGB/bSpe9m2BSAftGOte+i7FrVvAN
         J+wT42Fil2MibsBAqRjXhuEAVR6PCP5cHN959VHuhk8N3M/jURP0ymEEUAWj9HqYKar1
         fqPgp1oI1Kl7Ov7jXvyimgPRmh1o/twNp8aczNmQuPjVqbb72nCsc3hhXJM/eN+/caEa
         52nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bezyZJ/OjO9VYDt3R7xKaKwfrY2dmHyj5/J8CMS0GJE=;
        b=BdfcgDUjzw7COkjLm7VB+275x+lG5TJhpdQ2O5GezRCSHpyEdVu9AwNQLhN7TUOkB2
         9rDBRcydazyEmDlXpYYvK1gYcabA089h13yaGGo8SbXeI/1tDeXSLoM0hmkr9PPF80vV
         fItEu8XtRaGHpMBOJFXl3AXQIdPDV+lQnqP9PMpH1b6wcWm1iRmZAfYA/kBibp2Rujme
         zGQAt84qnNhifSyI2xvuD+bzwzVB8CzS6beZBwYHkcWl5Ns6gcYK+aAXCOp/JYcHuzpy
         r5Z0GdXD3lLlGW+8benDusaX3M6D4oshs8YZ2JO2Khd9oyt50js/uGq/XLfMvehERl/n
         FDwA==
X-Gm-Message-State: AOAM531Gs+lk6Jg8ZTjDzAsmhhiiDxLmrrTu9EwutX8hJTwF+wqooGXO
        vd9o8LuB/skezdjSlej5zPuI9SV6LTZF3A==
X-Google-Smtp-Source: ABdhPJwXnex6mtOr9pBI3DUsXCLMo142I18rxdobCeGSpi5ZthPs3e4VOi8hYn7kONsKmsuRdxhRmw==
X-Received: by 2002:a17:90b:2482:: with SMTP id nt2mr104105pjb.13.1618852384255;
        Mon, 19 Apr 2021 10:13:04 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d71sm7669029pfd.83.2021.04.19.10.13.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 10:13:03 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 08/10] Bluetooth: HCI: Use skb_pull to parse LE Advertising Report event
Date:   Mon, 19 Apr 2021 10:12:55 -0700
Message-Id: <20210419171257.3865181-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419171257.3865181-1-luiz.dentz@gmail.com>
References: <20210419171257.3865181-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses skb_pull to check the LE Advertising Report events received
have the minimum required length.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h |  7 ++++++-
 net/bluetooth/hci_event.c   | 37 ++++++++++++++++++++++++++-----------
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index f416ad71fd2d..3ec8e07f1724 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2327,13 +2327,18 @@ struct hci_ev_le_conn_complete {
 
 #define HCI_EV_LE_ADVERTISING_REPORT	0x02
 struct hci_ev_le_advertising_info {
-	__u8	 evt_type;
+	__u8	 type;
 	__u8	 bdaddr_type;
 	bdaddr_t bdaddr;
 	__u8	 length;
 	__u8	 data[];
 } __packed;
 
+struct hci_ev_le_advertising_report {
+	__u8    num;
+	struct hci_ev_le_advertising_info info[];
+} __packed;
+
 #define HCI_EV_LE_CONN_UPDATE_COMPLETE	0x03
 struct hci_ev_le_conn_update_complete {
 	__u8     status;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index dc39861f4da6..69a5296382ae 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6274,25 +6274,40 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 
 static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	u8 num_reports = skb->data[0];
-	void *ptr = &skb->data[1];
+	struct hci_ev_le_advertising_report *ev;
+
+	ev = hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_ADVERTISING_REPORT,
+				sizeof(*ev));
+	if (!ev)
+		return;
+
+	if (!ev->num)
+		return;
 
 	hci_dev_lock(hdev);
 
-	while (num_reports--) {
-		struct hci_ev_le_advertising_info *ev = ptr;
+	while (ev->num--) {
+		struct hci_ev_le_advertising_info *info;
 		s8 rssi;
 
-		if (ev->length <= HCI_MAX_AD_LENGTH) {
-			rssi = ev->data[ev->length];
-			process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
-					   ev->bdaddr_type, NULL, 0, rssi,
-					   ev->data, ev->length, false);
+		info = hci_le_ev_skb_pull(hdev, skb,
+					  HCI_EV_LE_ADVERTISING_REPORT,
+					  sizeof(*info));
+		if (!info)
+			break;
+
+		if (!hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_ADVERTISING_REPORT,
+					info->length + 1))
+			break;
+
+		if (info->length <= HCI_MAX_AD_LENGTH) {
+			rssi = info->data[info->length];
+			process_adv_report(hdev, info->type, &info->bdaddr,
+					   info->bdaddr_type, NULL, 0, rssi,
+					   info->data, info->length, false);
 		} else {
 			bt_dev_err(hdev, "Dropping invalid advertising data");
 		}
-
-		ptr += sizeof(*ev) + ev->length + 1;
 	}
 
 	hci_dev_unlock(hdev);
-- 
2.30.2

