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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37ABC433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 17:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91E2761246
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 17:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbhDSRNb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Apr 2021 13:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhDSRNb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Apr 2021 13:13:31 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626A2C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 10:13:01 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j21-20020a17090ae615b02901505b998b45so5450716pjy.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 10:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=482VdqP+PKhUJPPjhlbdXbVpoS1015TUNm69SqM6/2g=;
        b=k3myPHi+4qGSyL/isU4KOL/JtU6YsiVeeeqsAqpEbd0QLCLoP0/vfogzvoO0JjDKyr
         BnFKJ0JT4Ky8jRkNJ2xY4H7kgtVIg497PSLrwXaWvBoozaZQ2EYvp3JVcFTdgCUXGBcq
         B/sfuIUmSbB+Ku6IQY7mMWgGpQbMsl6DdBsdHRYMJ32+UfyIKN/pvUWZH2ZFh0Pcp2Lg
         2yJrb9YyZFat1R04/beq+MbaF76MM/j6c0w4Hu7vBsfX+BIc3U3CireduH8XeEP77GKg
         dy6qvYCmvnCJEu7BDVFPLY1s/eN8cK6SGwsxnI1vfEigRLUbz2Wn/6H0aaI3YY3pruOP
         YD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=482VdqP+PKhUJPPjhlbdXbVpoS1015TUNm69SqM6/2g=;
        b=pLdM67BtyMnTXQDUzGpyIk50VUMZ9LgZOCGN2JliSG6KmxOemYAeCaOVJBrO8ue2Ry
         LHhCgEhl2NzgLEP5SC+vWP3kzXN0u4LSZ2c0XSnOcI924YPfly8Hb/9RHbB9BM+XYz7l
         KMMyyn+/BBYw319RUHmW8p3VcXRlASWnZNm0CpMZcxjGO3dk+hXAVm3V6qlUi3ft8gia
         eYPW5AVWT/Oe5eVzjhQtleRbwffxQyPNOgVXDRBbCsZS0M4dMSSwpYONwRZvHJg0qfL6
         IDYlUjzOvU12C/LNJqxpp9/4OFYFnkldZ6yzKHYPoduuH+H8oncUUZAt+sjQ0p2+Gm44
         Qz8g==
X-Gm-Message-State: AOAM530WicJZQjVf6sz7AUzr19mLglGdypMmWGWWGlTtmxlwVg6XVlom
        Gk71jWFYp/gQt5NMKHDQGAgD/C5grV+8TQ==
X-Google-Smtp-Source: ABdhPJzSzEKNC0rFgGvKYtIvN+KWovvswCtFpgQYyYv6uCPQJcGlSZcqbcrWxki2qbkBl3rbnDJ5Fw==
X-Received: by 2002:a17:90a:3b4c:: with SMTP id t12mr126870pjf.142.1618852380703;
        Mon, 19 Apr 2021 10:13:00 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d71sm7669029pfd.83.2021.04.19.10.13.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 10:13:00 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 03/10] Bluetooth: HCI: Use skb_pull to parse Number of Complete Packets event
Date:   Mon, 19 Apr 2021 10:12:50 -0700
Message-Id: <20210419171257.3865181-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419171257.3865181-1-luiz.dentz@gmail.com>
References: <20210419171257.3865181-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses skb_pull to check the Number of Complete Packets events
received have the minimum required length.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h |  2 +-
 net/bluetooth/hci_event.c   | 20 +++++++++++---------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index f1f505355e81..9251ae3a2ce0 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2021,7 +2021,7 @@ struct hci_comp_pkts_info {
 } __packed;
 
 struct hci_ev_num_comp_pkts {
-	__u8     num_hndl;
+	__u8     num;
 	struct hci_comp_pkts_info handles[];
 } __packed;
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cc2d68389edc..c353dfafb04c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4264,23 +4264,25 @@ static void hci_role_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_num_comp_pkts *ev = (void *) skb->data;
+	struct hci_ev_num_comp_pkts *ev;
 	int i;
 
-	if (hdev->flow_ctl_mode != HCI_FLOW_CTL_MODE_PACKET_BASED) {
-		bt_dev_err(hdev, "wrong event for mode %d", hdev->flow_ctl_mode);
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_NUM_COMP_PKTS, sizeof(*ev));
+	if (!ev)
 		return;
-	}
 
-	if (skb->len < sizeof(*ev) ||
-	    skb->len < struct_size(ev, handles, ev->num_hndl)) {
-		BT_DBG("%s bad parameters", hdev->name);
+	if (!hci_ev_skb_pull(hdev, skb, HCI_EV_NUM_COMP_PKTS,
+			     flex_array_size(ev, handles, ev->num)))
+		return;
+
+	if (hdev->flow_ctl_mode != HCI_FLOW_CTL_MODE_PACKET_BASED) {
+		bt_dev_err(hdev, "wrong event for mode %d", hdev->flow_ctl_mode);
 		return;
 	}
 
-	BT_DBG("%s num_hndl %d", hdev->name, ev->num_hndl);
+	BT_DBG("%s num %d", hdev->name, ev->num);
 
-	for (i = 0; i < ev->num_hndl; i++) {
+	for (i = 0; i < ev->num; i++) {
 		struct hci_comp_pkts_info *info = &ev->handles[i];
 		struct hci_conn *conn;
 		__u16  handle, count;
-- 
2.30.2

