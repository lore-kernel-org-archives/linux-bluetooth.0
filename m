Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86268EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jun 2023 19:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjFVT12 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jun 2023 15:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFVT11 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jun 2023 15:27:27 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B151987
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jun 2023 12:27:26 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-762490831f6so590119585a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jun 2023 12:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687462045; x=1690054045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rA81EDSrfjpLvNQ0lkr2EG4BI0BkijknMcGH016sWQA=;
        b=Oh6DPR2+NzL/KsJMB80muf2JZk6R/oIaTDj5gQ0lr2GqfVeIC+Jfu5SFRtyj23L0RC
         TMUBAr3O0dCSlNwU/qgDPo7/NFJ7VkjBTHaqQ92L4YJmNbBhgFSUvFECdqRL5kPLdIXf
         9hCN26tDgDdiYVYSAzWAYZNE1DOs4TyJHz6DNhc7OWQDWa/ghd72rTqie73bJOyZGiIQ
         COL4cI2DWZdZv0B5XtjPYDJCSwNx2ZApqD58fgeT35a5/6eRICRgf3G/mbzYRzzV/U0f
         0fHqT2odpoQR8sS3vYhK7iIeaBaX2oGuGhI/CxjiwLexM5BHDWLlYv8J1m38ogADzI3J
         u5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687462045; x=1690054045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rA81EDSrfjpLvNQ0lkr2EG4BI0BkijknMcGH016sWQA=;
        b=CbB9jnrlrNytvPzjxWuM4Cg2cSCY0KCdYqnEIqcsPUry0UafXi3jaTYwo1gM/H2k3A
         HLKQf6fUeH4gOACw7/RuGvAhzCilXorCapdvtKAH5rmDfLD5a2sVyqm/ZR6ApVKDtTah
         SeNcxnfLEQZgGzIUvSolxyybGliQJKmifcgJpEOW6Gfa3wg+ogHIDGmoV+AZb0HE0p5j
         BSxjnnY+RDzDBwe6X3WnrJQwsvlu7TGPOWoMXKVVlK1NFFNFfHIDuWP2lpEdBECplVYi
         G+OMDZkXtc1fG/PCsquXe8U2mKgyneaoZjCM/laveAbZb2MaLjOhYCE3ex34nAnHHriE
         s74g==
X-Gm-Message-State: AC+VfDw3tNvfJ6E86O0eFLUI47BlSHv8EDSJVAKJbt6LDw/4XEs9tQBw
        c5Kkq5de8ToUYmWOm1BqKquQfdk0Euev1A==
X-Google-Smtp-Source: ACHHUZ58f6Sr5ukAmvfb0J30TXV54lJoLa+/+RKA2ancprmW+Ig3bF5u3ykq1fx451o03d+sAdMCvw==
X-Received: by 2002:a05:620a:3a43:b0:762:57af:e0c9 with SMTP id sk3-20020a05620a3a4300b0076257afe0c9mr12841046qkn.25.1687462045205;
        Thu, 22 Jun 2023 12:27:25 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id g5-20020a05620a108500b0075f2c1afb7fsm3692151qkk.57.2023.06.22.12.27.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 12:27:24 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4] Bluetooth: hci_event: Fix parsing of CIS Established Event
Date:   Thu, 22 Jun 2023 12:27:22 -0700
Message-Id: <20230622192722.1248374-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The ISO Interval on CIS Established Event uses 1.25 ms slots:

    BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
    page 2304:

      Time = N * 1.25 ms

In addition to that this always update the QoS settings based on CIS
Established Event.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b1aefe4bb751..049aa7f6a7c5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6822,6 +6822,7 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
 {
 	struct hci_evt_le_cis_established *ev = data;
 	struct hci_conn *conn;
+	struct bt_iso_qos *qos;
 	bool pending = false;
 	u16 handle = __le16_to_cpu(ev->handle);
 
@@ -6846,21 +6847,30 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
 
 	pending = test_and_clear_bit(HCI_CONN_CREATE_CIS, &conn->flags);
 
-	if (conn->role == HCI_ROLE_SLAVE) {
-		__le32 interval;
+	qos = &conn->iso_qos;
 
-		memset(&interval, 0, sizeof(interval));
+	/* Convert ISO Interval (1.25 ms slots) to latency (ms) */
+	qos->ucast.in.latency = DIV_ROUND_CLOSEST(le16_to_cpu(ev->interval) *
+						  125, 100);
+	qos->ucast.out.latency = qos->ucast.in.latency;
 
-		memcpy(&interval, ev->c_latency, sizeof(ev->c_latency));
-		conn->iso_qos.ucast.in.interval = le32_to_cpu(interval);
-		memcpy(&interval, ev->p_latency, sizeof(ev->p_latency));
-		conn->iso_qos.ucast.out.interval = le32_to_cpu(interval);
-		conn->iso_qos.ucast.in.latency = le16_to_cpu(ev->interval);
-		conn->iso_qos.ucast.out.latency = le16_to_cpu(ev->interval);
-		conn->iso_qos.ucast.in.sdu = le16_to_cpu(ev->c_mtu);
-		conn->iso_qos.ucast.out.sdu = le16_to_cpu(ev->p_mtu);
-		conn->iso_qos.ucast.in.phy = ev->c_phy;
-		conn->iso_qos.ucast.out.phy = ev->p_phy;
+	switch (conn->role) {
+	case HCI_ROLE_SLAVE:
+		qos->ucast.in.interval = get_unaligned_le24(ev->c_latency);
+		qos->ucast.out.interval = get_unaligned_le24(ev->p_latency);
+		qos->ucast.in.sdu = le16_to_cpu(ev->c_mtu);
+		qos->ucast.out.sdu = le16_to_cpu(ev->p_mtu);
+		qos->ucast.in.phy = ev->c_phy;
+		qos->ucast.out.phy = ev->p_phy;
+		break;
+	case HCI_ROLE_MASTER:
+		qos->ucast.out.interval = get_unaligned_le24(ev->c_latency);
+		qos->ucast.in.interval = get_unaligned_le24(ev->p_latency);
+		qos->ucast.out.sdu = le16_to_cpu(ev->c_mtu);
+		qos->ucast.in.sdu = le16_to_cpu(ev->p_mtu);
+		qos->ucast.out.phy = ev->c_phy;
+		qos->ucast.in.phy = ev->p_phy;
+		break;
 	}
 
 	if (!ev->status) {
-- 
2.40.1

