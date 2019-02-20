Return-Path: <SRS0=cy5f=Q3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C03C10F01
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Feb 2019 10:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA29B2146E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Feb 2019 10:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="YSoBpIS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfBTKOx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:14:53 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35246 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfBTKOw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Feb 2019 05:14:52 -0500
Received: by mail-lj1-f196.google.com with SMTP id j13-v6so20331554ljc.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Feb 2019 02:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ux0dtrgyYzTH/OTO5BzOF/t6lK8o01zCWV+BGhQzL5s=;
        b=YSoBpIS6/Lym9u+Kk63Ku/js8FQsLGeqShRzcmitHJzO19oLjYL5pdjo3Qb1XfzapN
         aa74Xk/ZOwd0OvUGQB9tGiUPlNP/xDYF/O+DmCBTbqLRs/HVaXFmKb/VOfNuzW2R6qzw
         OtyLmHE2A/QIF+gxgqwj3WFEzRlDJGftJm6cuw8yYb/cBMCseMdcLKnOmTeKqXKIoYEr
         bRnF67mOXymP69xLMbxgecdFfopIlcQ5iqXy4Wu5EP0SxFver3Sc/Rbg+AJns/Ck+FdO
         yEF34TlsNJKK145fqa0DPuxYpYUkxQUl6T6rC4+wSi+kGApZ059EPcmbFIli2jykfZun
         hgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ux0dtrgyYzTH/OTO5BzOF/t6lK8o01zCWV+BGhQzL5s=;
        b=jkk/PDAnrPo80oVaQTt0uz+Cp8da6RbMb9qmLc4USctoljZRjWGTgWRshZwXOOgL3B
         BxYHIdHw8sLnGOlD/X2r3r2SbQh+Oot6iEhlSPdKPymUu5+CDlqlsD/IcKNAwAIaOEqQ
         pIPlV+tldt+XoAogJpeuL24FkA73GDq4+j5+n3n3Rwq3AXTLk/leu0ORRh2MY8r7P1i4
         YBF521lW7q9F3iDbD3HfuZ7HIo886aJZbTUFD4Miv3GMDaxNhgNmxw6VpkBh357NA6/E
         psLNabGLJmGOsSPqv4PpeILIwKg/oKcb1qywwGGDcqOVfaSA/Bjl9R/B/WzRdWhzUsVr
         WLkA==
X-Gm-Message-State: AHQUAubnmvPrDNqqfi1CVsOiVr6fsLy52egJfu+xq5ZzElRC4uSnuWTf
        JwVYG6xcFPp7dMGamIGE7A+OrsZI8Xk=
X-Google-Smtp-Source: AHgI3Ib3+ixubkNDk6KvXGeGZROOJLtk1OpGLYT5+IFIyKeMA/jgMLdAR1QONY4RsnxcykoDgUDJKw==
X-Received: by 2002:a2e:968d:: with SMTP id q13mr20348550lji.189.1550657690494;
        Wed, 20 Feb 2019 02:14:50 -0800 (PST)
Received: from localhost.localdomain ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id x19sm3856218lfe.42.2019.02.20.02.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 02:14:50 -0800 (PST)
From:   Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 2/5] Bluetooth: Add le_state_supported helper macro
Date:   Wed, 20 Feb 2019 11:14:25 +0100
Message-Id: <20190220101428.3086-2-andrzej.kaczmarek@codecoup.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220101428.3086-1-andrzej.kaczmarek@codecoup.pl>
References: <20190220101428.3086-1-andrzej.kaczmarek@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This allows for quickly checking if given LE states combination is
supported by controller. Combination is identified by bit number, as
defined in Core 5.0, Vol 2, Part E, 7.8.27.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
---
 include/net/bluetooth/hci_core.h |  4 ++++
 net/bluetooth/hci_request.c      | 14 +++++++-------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 094e61e07030..cdbab10fc4a6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1207,6 +1207,10 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 /* Extended advertising support */
 #define ext_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_EXT_ADV))
 
+/* LE supportes states and states combinations */
+#define le_state_supported(dev, bit) ((dev)->le_states[(bit) / 8] & \
+				      (1 << ((bit) % 8)))
+
 /* ----- HCI protocols ----- */
 #define HCI_PROTO_DEFER             0x01
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index ca73d36cc149..71c138c56321 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1015,28 +1015,28 @@ static bool is_advertising_allowed(struct hci_dev *hdev, bool connectable)
 	/* Check le_states if there is any connection in slave role. */
 	if (hdev->conn_hash.le_num_slave > 0) {
 		/* Slave connection state and non connectable mode bit 20. */
-		if (!connectable && !(hdev->le_states[2] & 0x10))
+		if (!connectable && !le_state_supported(hdev, 20))
 			return false;
 
 		/* Slave connection state and connectable mode bit 38
 		 * and scannable bit 21.
 		 */
-		if (connectable && (!(hdev->le_states[4] & 0x40) ||
-				    !(hdev->le_states[2] & 0x20)))
+		if (connectable && (!le_state_supported(hdev, 21) ||
+				    !le_state_supported(hdev, 38)))
 			return false;
 	}
 
 	/* Check le_states if there is any connection in master role. */
 	if (hci_conn_num(hdev, LE_LINK) != hdev->conn_hash.le_num_slave) {
-		/* Master connection state and non connectable mode bit 18. */
-		if (!connectable && !(hdev->le_states[2] & 0x02))
+		/* Master connection state and non connectable mode bit 17. */
+		if (!connectable && !le_state_supported(hdev, 17))
 			return false;
 
 		/* Master connection state and connectable mode bit 35 and
 		 * scannable 19.
 		 */
-		if (connectable && (!(hdev->le_states[4] & 0x08) ||
-				    !(hdev->le_states[2] & 0x08)))
+		if (connectable && (!le_state_supported(hdev, 19) ||
+				    !le_state_supported(hdev, 35)))
 			return false;
 	}
 
-- 
2.20.1

