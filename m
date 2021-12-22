Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3060C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Dec 2021 20:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238062AbhLVUWH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Dec 2021 15:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345404AbhLVUWG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Dec 2021 15:22:06 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBFBC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 12:22:06 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id a23so3030455pgm.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 12:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5hL4t7ct8rOigA65Jrfgx2CehhzvE7Mpz+A8TtqJgcU=;
        b=PUNAlMNE/RxjYWDrRLfdfgYzKGasHgwrOK5XYEURV5pglSKR0pTsaz39MdBewA4WUA
         Ag80ZVFfijuEyqPb8BN3ntKF+J03oN480oVoPGwrubyYX/rjyljKdG5GvR09kb1P9ok+
         DFfhL6O2IBl1LKh4sUluCZ5zM2ivRoyeZw5ogBD1mZIEaWpddVvvX0+KMRWnAC/wCZjA
         HMHTkK2/GUg2Z+gA4QcOjgjX8YomCc+9ZJExEuA+dgV+bRUliKKKkhrph46q1uAq0omf
         yuS4xyoUXTUtH2/u6+nx4+HoSAuzW5eDLuastG703jG2g3tR1YNxk8+q3nw7CD8DKplF
         Ms9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5hL4t7ct8rOigA65Jrfgx2CehhzvE7Mpz+A8TtqJgcU=;
        b=l/k70frxCqO628EoZQ0ueU6dFSs7Ph1+e19eeqcVTtZU36tcXSxkTuguIVK0VjmRNA
         A6oVwjaDX63IL4Y1mTQdvAnwSqiRyRpJopeQ9hc9DL2ze0+bm7r56MIQu8QyuBQnKZg+
         c3YvqS7atjGS8PTCGD+leaMDwj+nxnQ8NDeN3y3rb+vqK5RbkIDlA/YPY0wgP4T7/XI+
         pCZtiDdyfc2QQ79SLdO3chDpVusxKccrff2WBILW2vbEIhSvBBMaTWJOy88/Xrf+sX5Y
         evS8XjT1qm/doDesF43rNBVOTeBhAjsfJZX5W1/bQziiiUuVMTM//QEFp4Z5JlKIjhYf
         b6yA==
X-Gm-Message-State: AOAM533a7q0aTtAxH2J9eGfN1jqQXK7O00kQt2FSf9ZJVfVNZiahjF/P
        isDImcekMEVvdBXRyPPKWghxLUCBhcc=
X-Google-Smtp-Source: ABdhPJyAF8k8cKjY/zmXDAzp6cQOHAjQtZC1Qf01eHpnXkOtc8igppwBC6mS7GyjI8k+/RfJkzu9iQ==
X-Received: by 2002:a63:780a:: with SMTP id t10mr2007048pgc.177.1640204525912;
        Wed, 22 Dec 2021 12:22:05 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x25sm1285266pfu.113.2021.12.22.12.22.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 12:22:05 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 4/6] Bluetooth: hci_sync: Add check simultaneous roles support
Date:   Wed, 22 Dec 2021 12:21:59 -0800
Message-Id: <20211222202201.977779-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211222202201.977779-1-luiz.dentz@gmail.com>
References: <20211222202201.977779-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to check if the controller can act as both central and
peripheral simultaneously and in case it does skip suspending
advertising or in case of directed advertising don't fail if scanning.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  6 ++++++
 net/bluetooth/hci_sync.c         | 24 ++++++++++++------------
 net/bluetooth/mgmt.c             |  5 +----
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1ab94960764e..586f69d084a2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -783,6 +783,12 @@ extern struct mutex hci_cb_list_lock;
 		hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);	\
 	} while (0)
 
+#define hci_dev_le_state_simultaneous(hdev) \
+	(test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks) && \
+	 (hdev->le_states[4] & 0x08) &&	/* Central */ \
+	 (hdev->le_states[4] & 0x40) &&	/* Peripheral */ \
+	 (hdev->le_states[3] & 0x10))	/* Simultaneous */
+
 /* ----- HCI interface to upper protocols ----- */
 int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int l2cap_disconn_ind(struct hci_conn *hcon);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 8c50a12ba5f5..61d8a076a3f3 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5195,30 +5195,29 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
 	u8 own_addr_type;
 	int err;
 
-	/* Disable advertising if we're active. For central role
-	 * connections most controllers will refuse to connect if
-	 * advertising is enabled, and for peripheral role connections we
-	 * anyway have to disable it in order to start directed
-	 * advertising. Any registered advertisements will be
-	 * re-enabled after the connection attempt is finished.
-	 */
-	hci_pause_advertising_sync(hdev);
-
 	/* If requested to connect as peripheral use directed advertising */
 	if (conn->role == HCI_ROLE_SLAVE) {
-		/* If we're active scanning most controllers are unable
-		 * to initiate advertising. Simply reject the attempt.
+		/* If we're active scanning and the controller doesn't support
+		 * simultaneous roles simply reject the attempt.
 		 */
 		if (hci_dev_test_flag(hdev, HCI_LE_SCAN) &&
-		    hdev->le_scan_type == LE_SCAN_ACTIVE) {
+		    hdev->le_scan_type == LE_SCAN_ACTIVE &&
+		    !hci_dev_le_state_simultaneous(hdev)) {
 			hci_conn_del(conn);
 			return -EBUSY;
 		}
 
+		/* Pause advertising while doing directed advertising. */
+		hci_pause_advertising_sync(hdev);
+
 		err = hci_le_directed_advertising_sync(hdev, conn);
 		goto done;
 	}
 
+	/* Disable advertising if simultaneous roles is not supported. */
+	if (!hci_dev_le_state_simultaneous(hdev))
+		hci_pause_advertising_sync(hdev);
+
 	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
 	if (params) {
 		conn->le_conn_min_interval = params->conn_min_interval;
@@ -5276,6 +5275,7 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
 				       HCI_CMD_TIMEOUT, NULL);
 
 done:
+	/* Re-enable advertising after the connection attempt is finished. */
 	hci_resume_advertising_sync(hdev);
 	return err;
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 962bb747d2cd..3326d9459dd3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3916,10 +3916,7 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 #endif
 
 	if (hdev) {
-		if (test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks) &&
-		    (hdev->le_states[4] & 0x08) &&	/* Central */
-		    (hdev->le_states[4] & 0x40) &&	/* Peripheral */
-		    (hdev->le_states[3] & 0x10))	/* Simultaneous */
+		if (hci_dev_le_state_simultaneous(hdev))
 			flags = BIT(0);
 		else
 			flags = 0;
-- 
2.33.1

