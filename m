Return-Path: <SRS0=cy5f=Q3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5392EC43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Feb 2019 10:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC332147C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Feb 2019 10:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="Qvj5/WxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfBTKO5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:14:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38079 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfBTKO4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Feb 2019 05:14:56 -0500
Received: by mail-lj1-f195.google.com with SMTP id j19so19502085ljg.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Feb 2019 02:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ie6KhDPtiwMBa7/R/Fj0hX2uNGEozPAcNdx+S0IP8hQ=;
        b=Qvj5/WxYPQwFl4Wy7r+41JRzZQP3rKByk/rHkAv8d/+jvpTr0NCYgh6ZK5GDH6zylK
         KrDiUTCWG40lIBzcRliXGqBlF65CJKzaiEKDj4WJlXidNJg7lgU06NMR1oALGhPrmr74
         jf1NzjdMdFKwK5npD1pM9/Fa5be/rU6bgKJBL4dTfjOVoBXkSb0knK5jq73RxcUWtWtE
         xXLNQp0G1SxS7dULbkoacoQoeQ4ZH+uiRFWQ4H+FLQ2oxZp6bdZIqe3roKC2C7oM3ety
         7JcMtJA+p56F5HAAMosV+8w1EQhvGeA8APX7lhabWThmfPnH/LV0HEmSN4RjxBSKT2yJ
         9H5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ie6KhDPtiwMBa7/R/Fj0hX2uNGEozPAcNdx+S0IP8hQ=;
        b=tS+eQfx4YOqVG+LdV1BF2I2WuvHZz2S34+0TvAmMdJURRDCEVCdXc2LPmRYOwjJlLF
         wpVi++W0h+MkxychJO9q72PYOhzBCBX+8E4fTrh+Iiqtasg7FEIVhxZuFFsewEEJE2iF
         o4pt49yqziJrm7cq1AcR63nN0H/O0MqjCpjGYclJpgTdSv1/NNop/1RFmxdo/spKvFUQ
         PS1HAu/YWaJ6RWcntwh4dVEPyfdA0cqm4By2C5ybmC7evVjjKNNc/V1w2j0KkyjkQmkZ
         EpIZCMDPGfboEzN1HbATWk8fXiiExliLALL6YjbjZgvOSpy6t3Ff9ObVDzPDzlevOfB6
         /z7Q==
X-Gm-Message-State: AHQUAuaLvqRbmEhe6IpgaKt9Ronx+RYMCTS1qXCN5X9GV3WOB84VsPfa
        SQTtwsCC9Dmk1uYGyDG8OZGNJc3Gsoc=
X-Google-Smtp-Source: AHgI3IZvQMaIhRexAeSgbF4tXa4XfYOuPoLI8LURM6SSZQJMbZR2gCBC2RPhIwu7j9EQ+eithnaEjA==
X-Received: by 2002:a2e:3c10:: with SMTP id j16mr853118lja.113.1550657693568;
        Wed, 20 Feb 2019 02:14:53 -0800 (PST)
Received: from localhost.localdomain ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id x19sm3856218lfe.42.2019.02.20.02.14.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 02:14:52 -0800 (PST)
From:   Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 5/5] Bluetooth: Fix set advertising while scanning
Date:   Wed, 20 Feb 2019 11:14:28 +0100
Message-Id: <20190220101428.3086-5-andrzej.kaczmarek@codecoup.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220101428.3086-1-andrzej.kaczmarek@codecoup.pl>
References: <20190220101428.3086-1-andrzej.kaczmarek@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We can check states supported by controller to determine whether it is
allowed to advertise while scanning or not.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
---
 net/bluetooth/hci_request.c | 24 +++++++++++++++++++++---
 net/bluetooth/mgmt.c        |  4 +---
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 71c138c56321..5498afec03fb 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1008,9 +1008,27 @@ static bool adv_use_rpa(struct hci_dev *hdev, uint32_t flags)
 
 static bool is_advertising_allowed(struct hci_dev *hdev, bool connectable)
 {
-	/* If there is no connection we are OK to advertise. */
-	if (hci_conn_num(hdev, LE_LINK) == 0)
-		return true;
+	/* Check le_states if there is active scanning ongoing */
+	if (hci_dev_test_flag(hdev, HCI_LE_SCAN) &&
+	    hdev->le_scan_type == LE_SCAN_ACTIVE) {
+		if (!connectable && !le_state_supported(hdev, 12))
+			return false;
+
+		if (connectable && (!le_state_supported(hdev, 13) ||
+				    !le_state_supported(hdev, 14)))
+			return false;
+	}
+
+	/* Check le_states if there is passive scanning ongoing */
+	if (hci_dev_test_flag(hdev, HCI_LE_SCAN) &&
+	    hdev->le_scan_type == LE_SCAN_PASSIVE) {
+		if (!connectable && !le_state_supported(hdev, 8))
+			return false;
+
+		if (connectable && (!le_state_supported(hdev, 9) ||
+				    !le_state_supported(hdev, 10)))
+			return false;
+	}
 
 	/* Check le_states if there is any connection in slave role. */
 	if (hdev->conn_hash.le_num_slave > 0) {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d44681c99341..3072c104888e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4333,9 +4333,7 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 	 */
 	if (!hdev_is_powered(hdev) ||
 	    (val == hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
-	     (cp->val == 0x02) == hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE)) ||
-	    (hci_dev_test_flag(hdev, HCI_LE_SCAN) &&
-	     hdev->le_scan_type == LE_SCAN_ACTIVE)) {
+	     (cp->val == 0x02) == hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE))) {
 		bool changed;
 
 		if (cp->val) {
-- 
2.20.1

