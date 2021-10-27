Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D08C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 22:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40149610C7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 22:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhJ0WUw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 18:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhJ0WUs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 18:20:48 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12466C061226
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 15:18:22 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id l203so4081528pfd.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 15:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qDP84iNRzL1ofpvk9Vog2CMmietfqFZPnYdx1xF1EFQ=;
        b=MTyfjbo6Zd8SOis4d6klIMbTCt0QOrsqZQ5H9VWNR/zEkIAVPLT//DXOJpTsCKQmpR
         Q8n7K8w/NdD40QQOzwgUFI8lrJB7xgtR0g+Vd4TjHL0XRH0qYkKbdBRi8PfgFfWZwxv4
         57rN1CECKZvcRAXQdmOT7jbbu7a01D5P5C9kmos+PfE0eL7NFS5W8VWpDOf5VIdek/Tk
         z4HrLSxLaLdvsY/1VltLRsoJkC4LJKN0FV7AGBjBqGkY3ojXlepJ3ZZ8bpA5o7fpqxrW
         2Dt5mTJjgZKC50gbLJQqWi8oKstAn6V566jK4VsDijA4AfRIii7xH6OrUvaUpgPR1sMl
         Dv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qDP84iNRzL1ofpvk9Vog2CMmietfqFZPnYdx1xF1EFQ=;
        b=IIwkJAkk7eaZt7WEPorVIp5tEAJRi468aKJNtlXoGfk7MbvyK85/KjXR4II+h0LNAy
         w+Pl7IaO3s05Hv2wKDmeWAEoFZ1CFp7dYaahoESHqJnltD4gU0W+V1wxC8RsJPX3+BF+
         m3wYw3xTJwQGDhTA+HxHLaPEz3j+lk/sNmfLYpWSNOd3CV/IGq69hJ53MUwishPqsJlT
         uYm0lg3M/rfz/Y/6lzRGybjeGXZDycoq3YHY2n7lr5X/P9sHc/gpXEYD/OGI9SSKyEPz
         /MX4BTyLqRCQg5JJVBHLtH2XABKrRWIGOWCPSVtCQNYz57Pct3j4wY5nY7uaqHq/+8/w
         jpxg==
X-Gm-Message-State: AOAM532K/Wnui7JyMQzhF6TMU4K9pmA1dI35CDS/FVyFWtV8mMlU6HW2
        NBn4BPAJJuvNISaoib4d3yLd0NBGMbg=
X-Google-Smtp-Source: ABdhPJz0/rzF/6oGcnceFPxEV4XrmQD5qr8qd0r30aHleSbJ2MoFIovapiJ95sY7QwkXHHNR4W/i8w==
X-Received: by 2002:a63:3e01:: with SMTP id l1mr363064pga.30.1635373101235;
        Wed, 27 Oct 2021 15:18:21 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a25sm902760pfl.115.2021.10.27.15.18.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 15:18:20 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 21/23] Bluetooth: hci_sync: Convert MGMT_OP_SSP
Date:   Wed, 27 Oct 2021 15:18:00 -0700
Message-Id: <20211027221802.1851851-22-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027221802.1851851-1-luiz.dentz@gmail.com>
References: <20211027221802.1851851-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

mgmt-tester paths:
Set SSP on - Success 2
Set Device ID - SSP off and Power on

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 include/net/bluetooth/hci_core.h |   1 -
 include/net/bluetooth/hci_sync.h |   1 +
 net/bluetooth/hci_event.c        |   4 +-
 net/bluetooth/hci_sync.c         |   7 +-
 net/bluetooth/mgmt.c             | 150 +++++++++++++++----------------
 5 files changed, 80 insertions(+), 83 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a6b075203cbe..3e53c845ab0e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1806,7 +1806,6 @@ int mgmt_user_passkey_notify(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			     u8 entered);
 void mgmt_auth_failed(struct hci_conn *conn, u8 status);
 void mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status);
-void mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
 void mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 				    u8 status);
 void mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index d9f2e3182ed8..db96546d40c8 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -47,6 +47,7 @@ int hci_update_class_sync(struct hci_dev *hdev);
 int hci_update_eir_sync(struct hci_dev *hdev);
 int hci_update_class_sync(struct hci_dev *hdev);
 int hci_update_name_sync(struct hci_dev *hdev);
+int hci_write_ssp_mode_sync(struct hci_dev *hdev, u8 mode);
 
 int hci_update_random_address_sync(struct hci_dev *hdev, bool require_privacy,
 				   bool rpa, u8 *own_addr_type);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4181e9180109..882a2752de41 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -545,9 +545,7 @@ static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 			hdev->features[1][0] &= ~LMP_HOST_SSP;
 	}
 
-	if (hci_dev_test_flag(hdev, HCI_MGMT))
-		mgmt_ssp_enable_complete(hdev, sent->mode, status);
-	else if (!status) {
+	if (!status) {
 		if (sent->mode)
 			hci_dev_set_flag(hdev, HCI_SSP_ENABLED);
 		else
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 47beabe48257..8b63b4e5c96a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2142,7 +2142,7 @@ int hci_write_sc_support_sync(struct hci_dev *hdev, u8 val)
 	return err;
 }
 
-static int hci_write_ssp_mode_sync(struct hci_dev *hdev, u8 mode)
+int hci_write_ssp_mode_sync(struct hci_dev *hdev, u8 mode)
 {
 	int err;
 
@@ -2150,6 +2150,11 @@ static int hci_write_ssp_mode_sync(struct hci_dev *hdev, u8 mode)
 	    lmp_host_ssp_capable(hdev))
 		return 0;
 
+	if (!mode && hci_dev_test_flag(hdev, HCI_USE_DEBUG_KEYS)) {
+		__hci_cmd_sync_status(hdev, HCI_OP_WRITE_SSP_DEBUG_MODE,
+				      sizeof(mode), &mode, HCI_CMD_TIMEOUT);
+	}
+
 	err = __hci_cmd_sync_status(hdev, HCI_OP_WRITE_SSP_MODE,
 				    sizeof(mode), &mode, HCI_CMD_TIMEOUT);
 	if (err)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0a1c19087f2f..484b5b142c54 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1760,6 +1760,69 @@ static int set_link_security(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
+static void set_ssp_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct cmd_lookup match = { NULL, hdev };
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_mode *cp = cmd->param;
+	u8 enable = cp->val;
+	bool changed;
+
+	if (err) {
+		u8 mgmt_err = mgmt_status(err);
+
+		if (enable && hci_dev_test_and_clear_flag(hdev,
+							  HCI_SSP_ENABLED)) {
+			hci_dev_clear_flag(hdev, HCI_HS_ENABLED);
+			new_settings(hdev, NULL);
+		}
+
+		mgmt_pending_foreach(MGMT_OP_SET_SSP, hdev, cmd_status_rsp,
+				     &mgmt_err);
+		return;
+	}
+
+	if (enable) {
+		changed = !hci_dev_test_and_set_flag(hdev, HCI_SSP_ENABLED);
+	} else {
+		changed = hci_dev_test_and_clear_flag(hdev, HCI_SSP_ENABLED);
+
+		if (!changed)
+			changed = hci_dev_test_and_clear_flag(hdev,
+							      HCI_HS_ENABLED);
+		else
+			hci_dev_clear_flag(hdev, HCI_HS_ENABLED);
+	}
+
+	mgmt_pending_foreach(MGMT_OP_SET_SSP, hdev, settings_rsp, &match);
+
+	if (changed)
+		new_settings(hdev, match.sk);
+
+	if (match.sk)
+		sock_put(match.sk);
+
+	hci_update_eir_sync(hdev);
+}
+
+static int set_ssp_sync(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_mode *cp = cmd->param;
+	bool changed = false;
+	int err;
+
+	if (cp->val)
+		changed = !hci_dev_test_and_set_flag(hdev, HCI_SSP_ENABLED);
+
+	err = hci_write_ssp_mode_sync(hdev, cp->val);
+
+	if (!err && changed)
+		hci_dev_clear_flag(hdev, HCI_SSP_ENABLED);
+
+	return err;
+}
+
 static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 {
 	struct mgmt_mode *cp = data;
@@ -1821,19 +1884,18 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	}
 
 	cmd = mgmt_pending_add(sk, MGMT_OP_SET_SSP, hdev, data, len);
-	if (!cmd) {
+	if (!cmd)
 		err = -ENOMEM;
-		goto failed;
-	}
-
-	if (!cp->val && hci_dev_test_flag(hdev, HCI_USE_DEBUG_KEYS))
-		hci_send_cmd(hdev, HCI_OP_WRITE_SSP_DEBUG_MODE,
-			     sizeof(cp->val), &cp->val);
+	else
+		err = hci_cmd_sync_queue(hdev, set_ssp_sync, cmd,
+					 set_ssp_complete);
 
-	err = hci_send_cmd(hdev, HCI_OP_WRITE_SSP_MODE, 1, &cp->val);
 	if (err < 0) {
-		mgmt_pending_remove(cmd);
-		goto failed;
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
+				      MGMT_STATUS_FAILED);
+
+		if (cmd)
+			mgmt_pending_remove(cmd);
 	}
 
 failed:
@@ -9309,74 +9371,6 @@ void mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status)
 		sock_put(match.sk);
 }
 
-static void clear_eir(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_write_eir cp;
-
-	if (!lmp_ext_inq_capable(hdev))
-		return;
-
-	memset(hdev->eir, 0, sizeof(hdev->eir));
-
-	memset(&cp, 0, sizeof(cp));
-
-	hci_req_add(req, HCI_OP_WRITE_EIR, sizeof(cp), &cp);
-}
-
-void mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
-{
-	struct cmd_lookup match = { NULL, hdev };
-	struct hci_request req;
-	bool changed = false;
-
-	if (status) {
-		u8 mgmt_err = mgmt_status(status);
-
-		if (enable && hci_dev_test_and_clear_flag(hdev,
-							  HCI_SSP_ENABLED)) {
-			hci_dev_clear_flag(hdev, HCI_HS_ENABLED);
-			new_settings(hdev, NULL);
-		}
-
-		mgmt_pending_foreach(MGMT_OP_SET_SSP, hdev, cmd_status_rsp,
-				     &mgmt_err);
-		return;
-	}
-
-	if (enable) {
-		changed = !hci_dev_test_and_set_flag(hdev, HCI_SSP_ENABLED);
-	} else {
-		changed = hci_dev_test_and_clear_flag(hdev, HCI_SSP_ENABLED);
-		if (!changed)
-			changed = hci_dev_test_and_clear_flag(hdev,
-							      HCI_HS_ENABLED);
-		else
-			hci_dev_clear_flag(hdev, HCI_HS_ENABLED);
-	}
-
-	mgmt_pending_foreach(MGMT_OP_SET_SSP, hdev, settings_rsp, &match);
-
-	if (changed)
-		new_settings(hdev, match.sk);
-
-	if (match.sk)
-		sock_put(match.sk);
-
-	hci_req_init(&req, hdev);
-
-	if (hci_dev_test_flag(hdev, HCI_SSP_ENABLED)) {
-		if (hci_dev_test_flag(hdev, HCI_USE_DEBUG_KEYS))
-			hci_req_add(&req, HCI_OP_WRITE_SSP_DEBUG_MODE,
-				    sizeof(enable), &enable);
-		__hci_req_update_eir(&req);
-	} else {
-		clear_eir(&req);
-	}
-
-	hci_req_run(&req, NULL);
-}
-
 static void sk_lookup(struct mgmt_pending_cmd *cmd, void *data)
 {
 	struct cmd_lookup *match = data;
-- 
2.31.1

