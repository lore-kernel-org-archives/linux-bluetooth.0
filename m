Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8A0EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jun 2023 20:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjFUUwh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jun 2023 16:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjFUUwf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jun 2023 16:52:35 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4040810F2
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 13:52:34 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-666fb8b1bc8so4737170b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 13:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687380753; x=1689972753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rA81EDSrfjpLvNQ0lkr2EG4BI0BkijknMcGH016sWQA=;
        b=CDEfvwtdEDqA0+ZkJeLuDw5aVNsIS6wXun056untUuakb2r5qwo9lDSzO+LmAEpF4a
         i/YhEcfKLK8cJLzpZDaFKwxcQJYT+PEzyYexUzUl/3KJX5ZFIf4HO8j4NLP3blm7cVEC
         SQyvIztSBudv+wKTbbNM2KRIlV57k8E8rq7Woznf3vyUwLbJq0N4pF0ZgYuWVygK8KK/
         0svtITuQ2K4YdgzuBGnumXG6IJxfE/N5PMxr9vQLSR8E+rqyb3nae2THecFCP0inmWMp
         OduWhjWOgZcsq9gZS20AEx6BKByoSo4/wtXm1dhU5xu034PO7Z1aptS0fPRKWuJRWUXD
         AXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687380753; x=1689972753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rA81EDSrfjpLvNQ0lkr2EG4BI0BkijknMcGH016sWQA=;
        b=i53SFRRdPOxsD//5OEm1rIezrOBvs9z9QZeSCSyokHZqNOHpNLuhrfw7JWZK2LZhSn
         D1JYwwSpAtSg8V8LyCug22RqK0RdTDQ/YJfKk5GsiE+8zIZu01k5c1F6razz0Ku6TgQJ
         j6O3lZghSiSCNO79+Z1dzgbbfmGmjEAETo1nHenJM8VCJH3S04Rxl5Y4OZqKBVpQV5+e
         4zIsqivEEKi/RLUs70jLGaeiov8C9undsVi3rjugYoII+bAfnpwrmpiVybaDp52uZ1ar
         F5wl2v1i5VHeqUmg7Kbcx430LlGHqmtsua4dvAPrUxjEcwaq5FNVMFKlMI0GHeWy/9QG
         ivvQ==
X-Gm-Message-State: AC+VfDzihwN/Sm8FfTbyKoVOGtIIXyE/DqZc2+WvPVu/sNz2GKhe1Xu2
        asg4zGdwp3Cz2OSVhjTW6z2b/cP19d4MhQ==
X-Google-Smtp-Source: ACHHUZ5kDtwnclDPFhnD78jkViE7jcyMOmg2QGu6jej1SioYS1k0pgumHCqr2zxyd7C9A2wQGXCxNA==
X-Received: by 2002:a05:6a00:2286:b0:668:81c5:2f8a with SMTP id f6-20020a056a00228600b0066881c52f8amr11395133pfe.17.1687380752855;
        Wed, 21 Jun 2023 13:52:32 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id e5-20020aa78245000000b0066a4a847524sm976517pfn.74.2023.06.21.13.52.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:52:31 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: hci_event: Fix parsing of CIS Established Event
Date:   Wed, 21 Jun 2023 13:52:30 -0700
Message-Id: <20230621205230.1006939-1-luiz.dentz@gmail.com>
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

