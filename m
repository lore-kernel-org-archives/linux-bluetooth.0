Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF514C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Dec 2021 23:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345173AbhLJXkv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Dec 2021 18:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345168AbhLJXkv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Dec 2021 18:40:51 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FC6C061746
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Dec 2021 15:37:15 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id m15so9295174pgu.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Dec 2021 15:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wFS+eUhVu1r688H6iZb+IHI07r1kNM1rXHX2GUMneJQ=;
        b=QQEZyRN6ZisPUBnrXJilQmeUhKPMgY20o7TDqH4OXj5Jamk3diWpRfitzUgydfhWGu
         F+oZnGv2yQ4YOiznj5ioFebLjEcgHMbEQfxQnVYHvGN/yVhdftBozcZG5IKGJoJKtaSI
         LrRN6nZhx9gcdEXCuyfm/GXjHL6wpkSD0J6dizzsepyACeHnAfr6iv/+2ETovSY0HdDD
         YuH8/pfqKH2/iwx0P/I75MtoMG4ko657vmFNcWj08fFx36wRTRNvLgj5UJ5lgmzz6gEh
         orzuY9wrX4M4FU1hYg4pmvJag+Anoj9Yi3I5widVR4hkuBCq4g0vpWDSxBT41qe0lt2d
         QlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wFS+eUhVu1r688H6iZb+IHI07r1kNM1rXHX2GUMneJQ=;
        b=oAtt2Ilp1jAgdFGGpNA6guo2byDKI6AMyAEGx01j8elCTWUAtCk7+uNiQ+h5oU6WVs
         xYXMRGigBLp/86oAqO1GbnuZN4KAzNCFnubkJ83vFHd/ngc0c7IKGbZbUd8/4c9zEsfl
         6lC+V2LeCwtMYBdUIwqlG03k4QPOyVIAPmfxqFmlikg37vSQlxYCdUC7ZN2SOCAuHs0U
         BTmMnjiIFaT/Y0UGrxeVKfPyTnz2WMzdIERDa4zmzkisoOu29bF3zCqcOxZq/8D2RmbL
         Fpt+HLa/wXtgGyoeNV7UkLKF6GlRIAPEGLjeLUuVFS9e5oHT1bg1ixfQICMx8hs2xFlH
         tmDg==
X-Gm-Message-State: AOAM5316gGR9j7do/1sgyMiH1W+nrneBVBB001GRl6ArdNLGKVeSQZ8U
        8OMuRd0bktaGSpqVY+QaNzW7qw3vtng=
X-Google-Smtp-Source: ABdhPJzP7GCiImwweYlFIBLJBZ5mT9yC09fVcBK/emWYJWEYnrHnO5y/b3tp+aBkjnWAR019O0vGqw==
X-Received: by 2002:a63:8f05:: with SMTP id n5mr2778879pgd.606.1639179434770;
        Fri, 10 Dec 2021 15:37:14 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b1sm3659885pgk.37.2021.12.10.15.37.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 15:37:14 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/4] Bluetooth: hci_sync: Add check simultaneous roles support
Date:   Fri, 10 Dec 2021 15:37:10 -0800
Message-Id: <20211210233710.1190040-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211210233710.1190040-1-luiz.dentz@gmail.com>
References: <20211210233710.1190040-1-luiz.dentz@gmail.com>
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
index e931e417d3e1..4e1557281956 100644
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

