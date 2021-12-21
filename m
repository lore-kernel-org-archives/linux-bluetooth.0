Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B585C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Dec 2021 22:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbhLUWeA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Dec 2021 17:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhLUWeA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Dec 2021 17:34:00 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D01FC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 14:34:00 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id j13so362603plx.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 14:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=soKYwwyCOJe4z6Gm98ynrJwO8MuiwZwsIPVOpruozLU=;
        b=QBI69fCroG9UJh37eitzVOrMrBJuK6AWIgLBfs54yY56QZtoLO3PuOViYmhih14VTK
         EoG0KANA3Qxp45hOqwn8knBqKFtL2FG/BrhmEr/WLB4iMHl8pMSvr4xux/ZA+SjANihW
         B2CmZXf3E+Rm1IKlTvbR5OlNfFbfAQdp0qIE//9/IxOuMqgNjKNSim3yE8d1lhv19DVU
         iMyoqfPQv143lXirbx4it/RHQaWDntNAMisw4Z5iRJ5YVKLTcA8maDPbqkGIpXknerU/
         ZbVx0MiEw8jbUGLNp8eEiK2HJrH4Mhzz8KhBqPdo6DohnFyR5TMvdApsOYheoNf4PSW9
         rsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=soKYwwyCOJe4z6Gm98ynrJwO8MuiwZwsIPVOpruozLU=;
        b=vaqtElq+zmqZVuLifaCv+dT+7c13i9R3J2mvceE7JcbVDFudaXdSmXeTuas58RSTLT
         EJ/GNfOwxNa3bQDBs5USFyy2GA3C1sWcLbN7EUsqza5jMWTyuVYE8YeiwsdmWFeAAcJB
         0Ebio7isl3ittPhdc6XdXRSbTHK1VTLPSLKvHsFWT2unxSAOacl0/bdXueqGlqouiSxL
         4qzoNiqB4swTmTIV0pobXmTGw0T72x6RF46YQJEi4O8CLjsEqSaseX1asFBxfbC9bJ2z
         HGJFzE7Za8tGU/4lYvBjho6EObwyhjU0wPXH3Z3R2oliFHh6JI1A+I63EO3wrFcCcv4k
         0mmQ==
X-Gm-Message-State: AOAM531CQ1Oof1/Su378iap2KqZNKJP14RNLCW1/vdJOvcwndN92tiCn
        yWB0tAo3eaaaVGxt6yl/CX7D1DlfZJA=
X-Google-Smtp-Source: ABdhPJxw7y1Qlt8JlY2mWf16v1i0GFcwbTWkoEdjGkScG0eiRFO+sfu2eJAfEC+/rkoSQ7Xtj4Friw==
X-Received: by 2002:a17:903:244a:b0:149:14a4:fd36 with SMTP id l10-20020a170903244a00b0014914a4fd36mr187987pls.107.1640126039346;
        Tue, 21 Dec 2021 14:33:59 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id np1sm3872209pjb.22.2021.12.21.14.33.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 14:33:59 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/4] Bluetooth: hci_sync: Add check simultaneous roles support
Date:   Tue, 21 Dec 2021 14:33:55 -0800
Message-Id: <20211221223357.742863-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211221223357.742863-1-luiz.dentz@gmail.com>
References: <20211221223357.742863-1-luiz.dentz@gmail.com>
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
index 1e479ba25c31..cc95b6c3f839 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -782,6 +782,12 @@ extern struct mutex hci_cb_list_lock;
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
index 28d62273d67c..6abcf966d001 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5170,30 +5170,29 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
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
@@ -5251,6 +5250,7 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
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

