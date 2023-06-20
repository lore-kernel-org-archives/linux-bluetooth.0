Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA2AEB64D7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jun 2023 22:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjFTWnw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jun 2023 18:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFTWnv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jun 2023 18:43:51 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1323C10F9
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 15:43:50 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b52bf6e669so42159705ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 15:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687301029; x=1689893029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ubJ/zy8H59MwE9XpeYgZYbh2rvsTvOqyKcVa632rcrc=;
        b=K0n7lD5xKziIanSecwmER7GuttTJR/+bcBB1oqISPG3JlZAfujjsICJMSuwz1bOxXC
         iuL3lQpMqkaGUS1FCkFzWOgZHnh3HpVVMbSLrupJM8l7gYFCWYOT8/yBSSuXd4QCgKw+
         nRNqvdcpZ6Lqukl2HnzaSMGNsBzyH+sjphtElx0QmSDtizLVEKv8vdSG3ueXQpgTQsqh
         jVkDiWsGaHzxK62c4DI+UTFOZHCsiq0KRsT3Yk05vUXUG0pSd2advLbom00Uzx2O3axv
         nrVUAo6AzngMHjw6uxGvuUeqHbiKYtDuruuBj1wy9WvwjiwQV8ia4od4G5WsV6EUNnda
         J7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687301029; x=1689893029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ubJ/zy8H59MwE9XpeYgZYbh2rvsTvOqyKcVa632rcrc=;
        b=c/l7SonFAPuwQhk+ZE3xO/yiHntQOFwuZHKAVCeVS0t7y3f71Rf05GHbFlhtqpnz0y
         g2jg2v8t8bNtSwspQD4+C8CY8Htd+leYbwZ7cOGzqG6o/kD+JbIhsoq2TPuiGLtZaS/Q
         8aM4qfrm5qVsJnUVOfR6YLu9S/w5pdMsJcDQJlfXbR8PhgUo8uYHavIGgACYA66o5C2o
         uKDBeyut7vbocgUTQ1rrNOn41ybtXVgBanPullIS2OfJ84BA2hcoE67H0kyToI0aBDps
         meYIltA6AmOveb+as0XokfCAc+3yYoIapRVwjNqVy4QjiN1wdTz1DkTffJeOaemLn5qn
         KZKA==
X-Gm-Message-State: AC+VfDyNK4Q5AZv6u/pWoKR0IQQtDCyB932H9ABc1+9rzhHKxMT8mrC/
        yyRJivswt5T91iz3VeJK2tbJqSppB532yg==
X-Google-Smtp-Source: ACHHUZ70rjU+6OMVTEMvc1ty/kv5vA81zZ/zoCpoA6mfbzPp0VpYrl1sgU0GBOOwPO2jKYahc+A+og==
X-Received: by 2002:a17:902:6b45:b0:1ac:84dd:6d1f with SMTP id g5-20020a1709026b4500b001ac84dd6d1fmr12799044plt.1.1687301028811;
        Tue, 20 Jun 2023 15:43:48 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902e9c400b001b3d7205401sm2055507plk.303.2023.06.20.15.43.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 15:43:47 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_event: Fix parsing of CIS Established Event
Date:   Tue, 20 Jun 2023 15:43:46 -0700
Message-Id: <20230620224346.729658-1-luiz.dentz@gmail.com>
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

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b1aefe4bb751..5040aa66cd57 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6847,16 +6847,14 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
 	pending = test_and_clear_bit(HCI_CONN_CREATE_CIS, &conn->flags);
 
 	if (conn->role == HCI_ROLE_SLAVE) {
-		__le32 interval;
+		struct bt_iso_qos *qos = &conn->iso_qos;
 
-		memset(&interval, 0, sizeof(interval));
-
-		memcpy(&interval, ev->c_latency, sizeof(ev->c_latency));
-		conn->iso_qos.ucast.in.interval = le32_to_cpu(interval);
-		memcpy(&interval, ev->p_latency, sizeof(ev->p_latency));
-		conn->iso_qos.ucast.out.interval = le32_to_cpu(interval);
-		conn->iso_qos.ucast.in.latency = le16_to_cpu(ev->interval);
-		conn->iso_qos.ucast.out.latency = le16_to_cpu(ev->interval);
+		qos->ucast.in.interval = get_unaligned_le24(ev->c_latency);
+		qos->ucast.out.interval = get_unaligned_le24(ev->p_latency);
+		/* Convert ISO Interval (1.25 ms slots) to latency (ms) */
+		qos->ucast.in.latency = le16_to_cpu(ev->interval) * 125 / 100;
+		/* Convert ISO Interval (1.25 ms slots) to latency (ms) */
+		qos->ucast.out.latency = le16_to_cpu(ev->interval) * 125 / 100;
 		conn->iso_qos.ucast.in.sdu = le16_to_cpu(ev->c_mtu);
 		conn->iso_qos.ucast.out.sdu = le16_to_cpu(ev->p_mtu);
 		conn->iso_qos.ucast.in.phy = ev->c_phy;
-- 
2.40.1

