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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476DCC433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 21:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E4A2613C3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 21:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344316AbhDPVWM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Apr 2021 17:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344240AbhDPVVz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Apr 2021 17:21:55 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE8DC06138D
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 14:18:33 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id m11so19163195pfc.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 14:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vKcoMs55jQGHC7XDvwx12Q7ew+GjY/U/ihtnONeuSdQ=;
        b=Bbo0l04yFzRPYi0skkXxmQxcVtZ9Rf8daHulU//g4M6R8Hg4jfDqgp2H0y1HYgsQxM
         nsB6uPCO9kV/y10NmqNWC0nPcMUqIZ4IKFvuXcNgQ0/0x9T11GmJVKgq7YKNRWDI3Bqt
         UpCIB9d0fPGVSpS6fM4e5kSpCRqX8S8jyQyq/50Gn2vp/K+mAfwP3s2+/uOj9zcLJUnI
         q0kMTJK6HIz6ckZudzIC8BqJNFYr4p1G516KfeEyOFc85M5OW31+0D6mmYxuTPjEqW5v
         cKpHreiH3SlwyHlcjDYK69xSNfe+llX8ThIYNlp7erfxFaZ/bvOxiZ+KCpYRVe4Yt0TG
         eGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vKcoMs55jQGHC7XDvwx12Q7ew+GjY/U/ihtnONeuSdQ=;
        b=QGmxdZi3ezvdY0lPovannIdqwKf2uV1ajkARQHdHlEaJhYdFechQ4kF0BWEoiwXjYc
         +JTzs714eqq1+Oa0vZaXOwEY940KDMGKQRCUFH6Ie9SJ/kyFwaUTIQZUeAxc19swJ6OF
         4by516md+geGVFAfU/z6WejgFaOVXGvX5WMeQFLSAEnPjpFV+EX35g96Z1Y6pmHemwOr
         t6ri+kRYMRZPadQ/T4Xt4HTUD1DVkR4RIdm9iAuHh/lvKVXJ4HBIQssHtr77IOxlmkTn
         WOLjRoZe/trJZHy5N45cHd/OONNhLijciYARPk65kc3FVoCN/rRE8XQcD0p3VmcApwTv
         RQgQ==
X-Gm-Message-State: AOAM533/Cv/HBc3do4vhlCBE737VGuj0S/3yMQrAiGT/+Az0SiE+fxBU
        Gst9BRrZ0ZJocSiwxIJ52sev5qwIeNTtlQ==
X-Google-Smtp-Source: ABdhPJzxNBzv3JP4gKc780gDSuvxg6eahwOcFzw/9WP57HshvHExXn6gBIyNbi4MG9vxVlKYKPAa8A==
X-Received: by 2002:a63:483:: with SMTP id 125mr896159pge.406.1618607912598;
        Fri, 16 Apr 2021 14:18:32 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z29sm5829843pga.52.2021.04.16.14.18.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 14:18:32 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/10] Bluetooth: HCI: Use skb_pull to parse LE Advertising Report event
Date:   Fri, 16 Apr 2021 14:18:21 -0700
Message-Id: <20210416211823.3776677-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416211823.3776677-1-luiz.dentz@gmail.com>
References: <20210416211823.3776677-1-luiz.dentz@gmail.com>
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
index 3b928d874f39..becc6319c8c5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6275,25 +6275,40 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 
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

