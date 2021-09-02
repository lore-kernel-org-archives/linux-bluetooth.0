Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED86C43214
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 04:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47A27610CC
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 04:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhIBEIw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 00:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhIBEIs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 00:08:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2F5C061575
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Sep 2021 21:07:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b9-20020a5b07890000b0290558245b7eabso906139ybq.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Sep 2021 21:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=plUQMO1xeZxJVG7BTOJZ3kGRDDqXbRz/hn7xvQbYzuA=;
        b=gieu12tHmOSFI0w64N/A9dOaeAomXlvhF99DkcdPFScViJWFoJPNF+fBIymqZq/MLW
         PYkyHo1HCGy3c0qnulylrhJdu+zPpPsexGRKn1g+EGmsxu7LoG2WNIzg3g7XTzDnusUp
         71c1yzXceM39bKegyF8kb9DHM7obxOT03uv8CvkgmX43+uKafo40vQYPJIlFpAJy+2NK
         e+jSqf5x1pTPnyH2hrzC5yB6FaTyw4rSNOWTL7CmejkcA80wkk7kae+SJZN9Ju7JRjBn
         /g+3j5kRZO25JZfAErpZY4g+1TNV2BblNh8puhEqXzY9dQSAwvikyu7+DYmmaFWwp4l9
         /NkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=plUQMO1xeZxJVG7BTOJZ3kGRDDqXbRz/hn7xvQbYzuA=;
        b=b4OPDGiHiWHhuLwSvg6bdgOho2NN0ktI2s2buRGsGi7ZThL2/mbPxnpx+eo97Sv9g8
         vxOwD87GE97Ltn/vumNzz/uxtUzrLsKrKlER/Oh7I+K35f1MIKFjgljVfRFjUUCcOCh4
         Tu/jWY0K8rPOCI/1Jyu5zeRquNZPmC3xAHQmI7TXCY+U0SfMxur5ZunHm85nGIorICKD
         hvoLCzZBeFCMpo/eJ07guL0I9Wd+qzSbdbwOPr9pXOHF26np3YByalu+H+p3gUDOGcbQ
         GEGLvdmFOcT7RupOklKLr5NOh7KZP7UfNJ28NjGHp35Fp35lyPIe4ygqup0r2RLlVx1z
         Y76g==
X-Gm-Message-State: AOAM533Lf6YKXzh/mRRBOhsJJPd/LKxbbaZGVxoupscnTyXTXwDI1z6s
        Ta0ecdEivFksACSwRJc5y1FvKcIltHJJppcNCax0JgSS+0tRUWV8KNyc2dwiJ//sHnxENld5t0O
        lHt2sou0mZOeGPfPSUzSpeLmHT1+eJNHoeTxE38oI5p2D00ypymxBNCG1ny92SCd06j77BxBlEJ
        Tf
X-Google-Smtp-Source: ABdhPJzYbD+5PbCk0CRphtwMfPa0LH/RLXHZwc7UKNK6t4HCwHti5ha619/GPT86xeVE3pzNGGX7FdqpG9ki
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:5249:e81c:3ce6:f50c])
 (user=apusaka job=sendgmr) by 2002:a25:9d89:: with SMTP id
 v9mr1757131ybp.8.1630555669465; Wed, 01 Sep 2021 21:07:49 -0700 (PDT)
Date:   Thu,  2 Sep 2021 12:07:01 +0800
In-Reply-To: <20210902040711.665952-1-apusaka@google.com>
Message-Id: <20210902120509.Bluez.v2.3.Iaa507a7e5c90b0ded462cac1363fce9ea916214e@changeid>
Mime-Version: 1.0
References: <20210902040711.665952-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [Bluez PATCH v2 03/13] monitor: Inclusive language changes
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

BT core spec 5.3 promotes the usage of inclusive languages.
This CL replaces some terms with the more appropriate counterparts,
such as "central", "peripheral", "link key", and "accept list"
---

Changes in v2:
* Merging several patches from the same directory into one

 emulator/btdev.c    |  58 +++----
 emulator/le.c       |  32 ++--
 emulator/smp.c      |   8 +-
 monitor/broadcom.c  |   8 +-
 monitor/bt.h        | 150 ++++++++--------
 monitor/control.c   |  10 +-
 monitor/l2cap.c     |  10 +-
 monitor/ll.c        |  60 ++++---
 monitor/lmp.c       |   2 +-
 monitor/packet.c    | 411 ++++++++++++++++++++++----------------------
 tools/3dsp.c        |  33 ++--
 tools/hci-tester.c  |   4 +-
 tools/mgmt-tester.c |   4 +-
 13 files changed, 400 insertions(+), 390 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 52c2b576d2..343c065760 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -3568,11 +3568,11 @@ static int cmd_le_create_conn_complete(struct btdev *dev, const void *data,
 
 static int cmd_read_wl_size(struct btdev *dev, const void *data, uint8_t len)
 {
-	struct bt_hci_rsp_le_read_white_list_size rsp;
+	struct bt_hci_rsp_le_read_accept_list_size rsp;
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
 	rsp.size = WL_SIZE;
-	cmd_complete(dev, BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE, &rsp,
+	cmd_complete(dev, BT_HCI_CMD_LE_READ_ACCEPT_LIST_SIZE, &rsp,
 						sizeof(rsp));
 
 	return 0;
@@ -3620,7 +3620,7 @@ static int cmd_wl_clear(struct btdev *dev, const void *data, uint8_t len)
 	wl_clear(dev);
 
 	status = BT_HCI_ERR_SUCCESS;
-	cmd_complete(dev, BT_HCI_CMD_LE_CLEAR_WHITE_LIST, &status,
+	cmd_complete(dev, BT_HCI_CMD_LE_CLEAR_ACCEPT_LIST, &status,
 						sizeof(status));
 
 	return 0;
@@ -3637,7 +3637,7 @@ static void wl_add(struct btdev_wl *wl, uint8_t type, bdaddr_t *addr)
 
 static int cmd_add_wl(struct btdev *dev, const void *data, uint8_t len)
 {
-	const struct bt_hci_cmd_le_add_to_white_list *cmd = data;
+	const struct bt_hci_cmd_le_add_to_accept_list *cmd = data;
 	uint8_t status;
 	bool exists = false;
 	int i, pos = -1;
@@ -3673,14 +3673,14 @@ static int cmd_add_wl(struct btdev *dev, const void *data, uint8_t len)
 
 	if (pos < 0) {
 		cmd_status(dev, BT_HCI_ERR_MEM_CAPACITY_EXCEEDED,
-					BT_HCI_CMD_LE_ADD_TO_WHITE_LIST);
+					BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST);
 		return 0;
 	}
 
 	wl_add(&dev->le_wl[pos], cmd->addr_type, (bdaddr_t *)&cmd->addr);
 
 	status = BT_HCI_ERR_SUCCESS;
-	cmd_complete(dev, BT_HCI_CMD_LE_ADD_TO_WHITE_LIST,
+	cmd_complete(dev, BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST,
 						&status, sizeof(status));
 
 	return 0;
@@ -3688,7 +3688,7 @@ static int cmd_add_wl(struct btdev *dev, const void *data, uint8_t len)
 
 static int cmd_remove_wl(struct btdev *dev, const void *data, uint8_t len)
 {
-	const struct bt_hci_cmd_le_remove_from_white_list *cmd = data;
+	const struct bt_hci_cmd_le_remove_from_accept_list *cmd = data;
 	uint8_t status;
 	int i;
 	char addr[18];
@@ -3728,7 +3728,7 @@ static int cmd_remove_wl(struct btdev *dev, const void *data, uint8_t len)
 		return -EINVAL;
 
 	status = BT_HCI_ERR_SUCCESS;
-	cmd_complete(dev, BT_HCI_CMD_LE_REMOVE_FROM_WHITE_LIST,
+	cmd_complete(dev, BT_HCI_CMD_LE_REMOVE_FROM_ACCEPT_LIST,
 						&status, sizeof(status));
 
 	return 0;
@@ -4313,10 +4313,10 @@ static int cmd_gen_dhkey(struct btdev *dev, const void *data, uint8_t len)
 					cmd_set_scan_enable_complete), \
 	CMD(BT_HCI_CMD_LE_CREATE_CONN, cmd_le_create_conn, \
 					cmd_le_create_conn_complete), \
-	CMD(BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE, cmd_read_wl_size, NULL), \
-	CMD(BT_HCI_CMD_LE_CLEAR_WHITE_LIST, cmd_wl_clear, NULL), \
-	CMD(BT_HCI_CMD_LE_ADD_TO_WHITE_LIST, cmd_add_wl, NULL), \
-	CMD(BT_HCI_CMD_LE_REMOVE_FROM_WHITE_LIST, cmd_remove_wl, NULL), \
+	CMD(BT_HCI_CMD_LE_READ_ACCEPT_LIST_SIZE, cmd_read_wl_size, NULL), \
+	CMD(BT_HCI_CMD_LE_CLEAR_ACCEPT_LIST, cmd_wl_clear, NULL), \
+	CMD(BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST, cmd_add_wl, NULL), \
+	CMD(BT_HCI_CMD_LE_REMOVE_FROM_ACCEPT_LIST, cmd_remove_wl, NULL), \
 	CMD(BT_HCI_CMD_LE_CONN_UPDATE, cmd_conn_update, \
 					cmd_conn_update_complete), \
 	CMD(BT_HCI_CMD_LE_READ_REMOTE_FEATURES, cmd_le_read_remote_features, \
@@ -5408,24 +5408,24 @@ static void le_cis_estabilished(struct btdev *dev, struct btdev_conn *conn,
 		struct btdev *remote = conn->link->dev;
 
 		/* TODO: Figure out if these values makes sense */
-		memcpy(evt.cig_sync_delay, remote->le_cig.params.m_interval,
-				sizeof(remote->le_cig.params.m_interval));
-		memcpy(evt.cis_sync_delay, remote->le_cig.params.s_interval,
-				sizeof(remote->le_cig.params.s_interval));
-		memcpy(evt.m_latency, &remote->le_cig.params.m_latency,
-				sizeof(remote->le_cig.params.m_latency));
-		memcpy(evt.s_latency, &remote->le_cig.params.s_latency,
-				sizeof(remote->le_cig.params.s_latency));
-		evt.m_phy = remote->le_cig.cis[0].m_phy;
-		evt.s_phy = remote->le_cig.cis[0].s_phy;
+		memcpy(evt.cig_sync_delay, remote->le_cig.params.c_interval,
+				sizeof(remote->le_cig.params.c_interval));
+		memcpy(evt.cis_sync_delay, remote->le_cig.params.p_interval,
+				sizeof(remote->le_cig.params.p_interval));
+		memcpy(evt.c_latency, &remote->le_cig.params.c_latency,
+				sizeof(remote->le_cig.params.c_latency));
+		memcpy(evt.p_latency, &remote->le_cig.params.p_latency,
+				sizeof(remote->le_cig.params.p_latency));
+		evt.c_phy = remote->le_cig.cis[0].c_phy;
+		evt.p_phy = remote->le_cig.cis[0].p_phy;
 		evt.nse = 0x01;
-		evt.m_bn = 0x01;
-		evt.s_bn = 0x01;
-		evt.m_ft = 0x01;
-		evt.s_ft = 0x01;
-		evt.m_mtu = remote->le_cig.cis[0].m_sdu;
-		evt.s_mtu = remote->le_cig.cis[0].s_sdu;
-		evt.interval = remote->le_cig.params.m_latency;
+		evt.c_bn = 0x01;
+		evt.p_bn = 0x01;
+		evt.c_ft = 0x01;
+		evt.p_ft = 0x01;
+		evt.c_mtu = remote->le_cig.cis[0].c_sdu;
+		evt.p_mtu = remote->le_cig.cis[0].p_sdu;
+		evt.interval = remote->le_cig.params.c_latency;
 	}
 
 	le_meta_event(dev, BT_HCI_EVT_LE_CIS_ESTABLISHED, &evt, sizeof(evt));
diff --git a/emulator/le.c b/emulator/le.c
index 4ffe3b16db..23f2579426 100644
--- a/emulator/le.c
+++ b/emulator/le.c
@@ -1211,12 +1211,12 @@ static void cmd_le_create_conn_cancel(struct bt_le *hci,
 static void cmd_le_read_white_list_size(struct bt_le *hci,
 						const void *data, uint8_t size)
 {
-	struct bt_hci_rsp_le_read_white_list_size rsp;
+	struct bt_hci_rsp_le_read_accept_list_size rsp;
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
 	rsp.size = hci->le_white_list_size;
 
-	cmd_complete(hci, BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE,
+	cmd_complete(hci, BT_HCI_CMD_LE_READ_ACCEPT_LIST_SIZE,
 							&rsp, sizeof(rsp));
 }
 
@@ -1228,14 +1228,14 @@ static void cmd_le_clear_white_list(struct bt_le *hci,
 	clear_white_list(hci);
 
 	status = BT_HCI_ERR_SUCCESS;
-	cmd_complete(hci, BT_HCI_CMD_LE_CLEAR_WHITE_LIST,
+	cmd_complete(hci, BT_HCI_CMD_LE_CLEAR_ACCEPT_LIST,
 						&status, sizeof(status));
 }
 
 static void cmd_le_add_to_white_list(struct bt_le *hci,
 						const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_le_add_to_white_list *cmd = data;
+	const struct bt_hci_cmd_le_add_to_accept_list *cmd = data;
 	uint8_t status;
 	bool exists = false;
 	int i, pos = -1;
@@ -1243,7 +1243,7 @@ static void cmd_le_add_to_white_list(struct bt_le *hci,
 	/* Valid range for address type is 0x00 to 0x01 */
 	if (cmd->addr_type > 0x01) {
 		cmd_status(hci, BT_HCI_ERR_INVALID_PARAMETERS,
-					BT_HCI_CMD_LE_ADD_TO_WHITE_LIST);
+					BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST);
 		return;
 	}
 
@@ -1259,13 +1259,13 @@ static void cmd_le_add_to_white_list(struct bt_le *hci,
 
 	if (exists) {
 		cmd_status(hci, BT_HCI_ERR_UNSPECIFIED_ERROR,
-					BT_HCI_CMD_LE_ADD_TO_WHITE_LIST);
+					BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST);
 		return;
 	}
 
 	if (pos < 0) {
 		cmd_status(hci, BT_HCI_ERR_MEM_CAPACITY_EXCEEDED,
-					BT_HCI_CMD_LE_ADD_TO_WHITE_LIST);
+					BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST);
 		return;
 	}
 
@@ -1273,21 +1273,21 @@ static void cmd_le_add_to_white_list(struct bt_le *hci,
 	memcpy(&hci->le_white_list[pos][1], cmd->addr, 6);
 
 	status = BT_HCI_ERR_SUCCESS;
-	cmd_complete(hci, BT_HCI_CMD_LE_ADD_TO_WHITE_LIST,
+	cmd_complete(hci, BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST,
 						&status, sizeof(status));
 }
 
 static void cmd_le_remove_from_white_list(struct bt_le *hci,
 						const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_le_remove_from_white_list *cmd = data;
+	const struct bt_hci_cmd_le_remove_from_accept_list *cmd = data;
 	uint8_t status;
 	int i, pos = -1;
 
 	/* Valid range for address type is 0x00 to 0x01 */
 	if (cmd->addr_type > 0x01) {
 		cmd_status(hci, BT_HCI_ERR_INVALID_PARAMETERS,
-					BT_HCI_CMD_LE_REMOVE_FROM_WHITE_LIST);
+					BT_HCI_CMD_LE_REMOVE_FROM_ACCEPT_LIST);
 		return;
 	}
 
@@ -1302,7 +1302,7 @@ static void cmd_le_remove_from_white_list(struct bt_le *hci,
 
 	if (pos < 0) {
 		cmd_status(hci, BT_HCI_ERR_INVALID_PARAMETERS,
-					BT_HCI_CMD_LE_REMOVE_FROM_WHITE_LIST);
+					BT_HCI_CMD_LE_REMOVE_FROM_ACCEPT_LIST);
 		return;
 	}
 
@@ -1310,7 +1310,7 @@ static void cmd_le_remove_from_white_list(struct bt_le *hci,
 	memset(&hci->le_white_list[pos][1], 0, 6);
 
 	status = BT_HCI_ERR_SUCCESS;
-	cmd_complete(hci, BT_HCI_CMD_LE_REMOVE_FROM_WHITE_LIST,
+	cmd_complete(hci, BT_HCI_CMD_LE_REMOVE_FROM_ACCEPT_LIST,
 						&status, sizeof(status));
 }
 
@@ -1830,13 +1830,13 @@ static const struct {
 				cmd_le_create_conn, 25, true },
 	{ BT_HCI_CMD_LE_CREATE_CONN_CANCEL,
 				cmd_le_create_conn_cancel, 0, true },
-	{ BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE,
+	{ BT_HCI_CMD_LE_READ_ACCEPT_LIST_SIZE,
 				cmd_le_read_white_list_size, 0, true },
-	{ BT_HCI_CMD_LE_CLEAR_WHITE_LIST,
+	{ BT_HCI_CMD_LE_CLEAR_ACCEPT_LIST,
 				cmd_le_clear_white_list, 0, true },
-	{ BT_HCI_CMD_LE_ADD_TO_WHITE_LIST,
+	{ BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST,
 				cmd_le_add_to_white_list,  7, true },
-	{ BT_HCI_CMD_LE_REMOVE_FROM_WHITE_LIST,
+	{ BT_HCI_CMD_LE_REMOVE_FROM_ACCEPT_LIST,
 				cmd_le_remove_from_white_list, 7, true },
 
 	{ BT_HCI_CMD_LE_ENCRYPT, cmd_le_encrypt, 32, true },
diff --git a/emulator/smp.c b/emulator/smp.c
index 21a34dde61..2a36437a00 100644
--- a/emulator/smp.c
+++ b/emulator/smp.c
@@ -383,7 +383,7 @@ static void distribute_keys(struct smp_conn *conn)
 	if (conn->local_key_dist & DIST_ENC_KEY) {
 		memset(buf, 0, sizeof(buf));
 		smp_send(conn, BT_L2CAP_SMP_ENCRYPT_INFO, buf, sizeof(buf));
-		smp_send(conn, BT_L2CAP_SMP_MASTER_IDENT, buf, 10);
+		smp_send(conn, BT_L2CAP_SMP_CENTRAL_IDENT, buf, 10);
 	}
 
 	if (conn->local_key_dist & DIST_ID_KEY) {
@@ -571,7 +571,7 @@ static void encrypt_info(struct smp_conn *conn, const void *data, uint16_t len)
 {
 }
 
-static void master_ident(struct smp_conn *conn, const void *data, uint16_t len)
+static void central_ident(struct smp_conn *conn, const void *data, uint16_t len)
 {
 	conn->remote_key_dist &= ~DIST_ENC_KEY;
 
@@ -727,8 +727,8 @@ void smp_data(void *conn_data, const void *data, uint16_t len)
 	case BT_L2CAP_SMP_ENCRYPT_INFO:
 		encrypt_info(conn, data, len);
 		break;
-	case BT_L2CAP_SMP_MASTER_IDENT:
-		master_ident(conn, data, len);
+	case BT_L2CAP_SMP_CENTRAL_IDENT:
+		central_ident(conn, data, len);
 		break;
 	case BT_L2CAP_SMP_IDENT_ADDR_INFO:
 		ident_addr_info(conn, data, len);
diff --git a/monitor/broadcom.c b/monitor/broadcom.c
index 5ee4ba04a4..21a86461ba 100644
--- a/monitor/broadcom.c
+++ b/monitor/broadcom.c
@@ -120,10 +120,10 @@ static void print_sync_mode(uint8_t mode)
 
 	switch (mode) {
 	case 0x00:
-		str = "Slave";
+		str = "Peripheral";
 		break;
 	case 0x01:
-		str = "Master";
+		str = "Central";
 		break;
 	default:
 		str = "Reserved";
@@ -139,10 +139,10 @@ static void print_clock_mode(uint8_t mode)
 
 	switch (mode) {
 	case 0x00:
-		str = "Slave";
+		str = "Peripheral";
 		break;
 	case 0x01:
-		str = "Master";
+		str = "Central";
 		break;
 	default:
 		str = "Reserved";
diff --git a/monitor/bt.h b/monitor/bt.h
index 0bc5718a0e..c7afc7fd8f 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -88,8 +88,8 @@ struct bt_ll_reject_ind {
 	uint8_t  error;
 } __attribute__ ((packed));
 
-#define BT_LL_SLAVE_FEATURE_REQ	0x0e
-struct bt_ll_slave_feature_req {
+#define BT_LL_PERIPHERAL_FEATURE_REQ	0x0e
+struct bt_ll_peripheral_feature_req {
 	uint8_t  features[8];
 } __attribute__ ((packed));
 
@@ -127,8 +127,8 @@ struct bt_ll_phy {
 
 #define BT_LL_PHY_UPDATE_IND	0x18
 struct bt_ll_phy_update_ind {
-	uint8_t  m_phy;
-	uint8_t  s_phy;
+	uint8_t  c_phy;
+	uint8_t  p_phy;
 	uint16_t instant;
 } __attribute__ ((packed));
 
@@ -168,19 +168,19 @@ struct bt_ll_clock_acc {
 struct bt_ll_cis_req {
 	uint8_t  cig;
 	uint8_t  cis;
-	uint8_t  m_phy;
-	uint8_t  s_phy;
-	uint16_t m_sdu;
-	uint16_t s_sdu;
-	uint8_t  m_interval[3];
-	uint8_t  s_interval[3];
-	uint8_t  m_pdu;
-	uint8_t  s_pdu;
+	uint8_t  c_phy;
+	uint8_t  p_phy;
+	uint16_t c_sdu;
+	uint16_t p_sdu;
+	uint8_t  c_interval[3];
+	uint8_t  p_interval[3];
+	uint8_t  c_pdu;
+	uint8_t  p_pdu;
 	uint8_t  nse;
 	uint8_t  sub_interval[3];
 	uint8_t  bn;
-	uint8_t  m_ft;
-	uint8_t  s_ft;
+	uint8_t  c_ft;
+	uint8_t  p_ft;
 	uint16_t iso_interval;
 	uint8_t  offset_min[3];
 	uint8_t  offset_max[3];
@@ -628,8 +628,8 @@ struct bt_hci_cmd_change_conn_link_key {
 	uint16_t handle;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_MASTER_LINK_KEY		0x0417
-struct bt_hci_cmd_master_link_key {
+#define BT_HCI_CMD_LINK_KEY_SELECTION		0x0417
+struct bt_hci_cmd_link_key_selection {
 	uint8_t  key_flag;
 } __attribute__ ((packed));
 
@@ -898,8 +898,8 @@ struct bt_hci_cmd_truncated_page_cancel {
 	uint8_t  bdaddr[6];
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_SET_SLAVE_BROADCAST		0x0441
-struct bt_hci_cmd_set_slave_broadcast {
+#define BT_HCI_CMD_SET_PERIPHERAL_BROADCAST	0x0441
+struct bt_hci_cmd_set_peripheral_broadcast {
 	uint8_t  enable;
 	uint8_t  lt_addr;
 	uint8_t  lpo_allowed;
@@ -908,14 +908,14 @@ struct bt_hci_cmd_set_slave_broadcast {
 	uint16_t max_interval;
 	uint16_t timeout;
 } __attribute__ ((packed));
-struct bt_hci_rsp_set_slave_broadcast {
+struct bt_hci_rsp_set_peripheral_broadcast {
 	uint8_t  status;
 	uint8_t  lt_addr;
 	uint16_t interval;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_SET_SLAVE_BROADCAST_RECEIVE	0x0442
-struct bt_hci_cmd_set_slave_broadcast_receive {
+#define BT_HCI_CMD_SET_PERIPHERAL_BROADCAST_RECEIVE	0x0442
+struct bt_hci_cmd_set_peripheral_broadcast_receive {
 	uint8_t  enable;
 	uint8_t  bdaddr[6];
 	uint8_t  lt_addr;
@@ -928,7 +928,7 @@ struct bt_hci_cmd_set_slave_broadcast_receive {
 	uint16_t pkt_type;
 	uint8_t  map[10];
 } __attribute__ ((packed));
-struct bt_hci_rsp_set_slave_broadcast_receive {
+struct bt_hci_rsp_set_peripheral_broadcast_receive {
 	uint8_t  status;
 	uint8_t  bdaddr[6];
 	uint8_t  lt_addr;
@@ -1599,13 +1599,13 @@ struct bt_hci_rsp_delete_reserved_lt_addr {
 	uint8_t  lt_addr;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_SET_SLAVE_BROADCAST_DATA	0x0c76
-struct bt_hci_cmd_set_slave_broadcast_data {
+#define BT_HCI_CMD_SET_PERIPHERAL_BROADCAST_DATA	0x0c76
+struct bt_hci_cmd_set_peripheral_broadcast_data {
 	uint8_t  lt_addr;
 	uint8_t  fragment;
 	uint8_t  length;
 } __attribute__ ((packed));
-struct bt_hci_rsp_set_slave_broadcast_data {
+struct bt_hci_rsp_set_peripheral_broadcast_data {
 	uint8_t  status;
 	uint8_t  lt_addr;
 } __attribute__ ((packed));
@@ -2072,22 +2072,22 @@ struct bt_hci_cmd_le_create_conn {
 
 #define BT_HCI_CMD_LE_CREATE_CONN_CANCEL	0x200e
 
-#define BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE	0x200f
-struct bt_hci_rsp_le_read_white_list_size {
+#define BT_HCI_CMD_LE_READ_ACCEPT_LIST_SIZE	0x200f
+struct bt_hci_rsp_le_read_accept_list_size {
 	uint8_t  status;
 	uint8_t  size;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_CLEAR_WHITE_LIST		0x2010
+#define BT_HCI_CMD_LE_CLEAR_ACCEPT_LIST		0x2010
 
-#define BT_HCI_CMD_LE_ADD_TO_WHITE_LIST		0x2011
-struct bt_hci_cmd_le_add_to_white_list {
+#define BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST	0x2011
+struct bt_hci_cmd_le_add_to_accept_list {
 	uint8_t  addr_type;
 	uint8_t  addr[6];
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_REMOVE_FROM_WHITE_LIST	0x2012
-struct bt_hci_cmd_le_remove_from_white_list {
+#define BT_HCI_CMD_LE_REMOVE_FROM_ACCEPT_LIST	0x2012
+struct bt_hci_cmd_le_remove_from_accept_list {
 	uint8_t  addr_type;
 	uint8_t  addr[6];
 } __attribute__ ((packed));
@@ -2646,23 +2646,23 @@ struct bt_hci_rsp_le_read_iso_tx_sync {
 #define BT_HCI_BIT_LE_SET_CIG_PARAMS		BT_HCI_CMD_BIT(41, 7)
 struct bt_hci_cis_params {
 	uint8_t  cis_id;
-	uint16_t m_sdu;
-	uint16_t s_sdu;
-	uint8_t  m_phy;
-	uint8_t  s_phy;
-	uint8_t  m_rtn;
-	uint8_t  s_rtn;
+	uint16_t c_sdu;
+	uint16_t p_sdu;
+	uint8_t  c_phy;
+	uint8_t  p_phy;
+	uint8_t  c_rtn;
+	uint8_t  p_rtn;
 } __attribute__ ((packed));
 
 struct bt_hci_cmd_le_set_cig_params {
 	uint8_t  cig_id;
-	uint8_t  m_interval[3];
-	uint8_t  s_interval[3];
+	uint8_t  c_interval[3];
+	uint8_t  p_interval[3];
 	uint8_t  sca;
 	uint8_t  packing;
 	uint8_t  framing;
-	uint16_t m_latency;
-	uint16_t s_latency;
+	uint16_t c_latency;
+	uint16_t p_latency;
 	uint8_t  num_cis;
 	struct bt_hci_cis_params cis[0];
 } __attribute__ ((packed));
@@ -2679,22 +2679,22 @@ struct bt_hci_rsp_le_set_cig_params {
 struct bt_hci_cis_params_test {
 	uint8_t  cis_id;
 	uint8_t  nse;
-	uint16_t m_sdu;
-	uint16_t s_sdu;
-	uint16_t m_pdu;
-	uint16_t s_pdu;
-	uint8_t  m_phy;
-	uint8_t  s_phy;
-	uint8_t  m_bn;
-	uint8_t  s_bn;
+	uint16_t c_sdu;
+	uint16_t p_sdu;
+	uint16_t c_pdu;
+	uint16_t p_pdu;
+	uint8_t  c_phy;
+	uint8_t  p_phy;
+	uint8_t  c_bn;
+	uint8_t  p_bn;
 } __attribute__ ((packed));
 
 struct bt_hci_cmd_le_set_cig_params_test {
 	uint8_t  cig_id;
-	uint8_t  m_interval[3];
-	uint8_t  s_interval[3];
-	uint8_t  m_ft;
-	uint8_t  s_ft;
+	uint8_t  c_interval[3];
+	uint8_t  p_interval[3];
+	uint8_t  c_ft;
+	uint8_t  p_ft;
 	uint16_t iso_interval;
 	uint8_t  sca;
 	uint8_t  packing;
@@ -2931,8 +2931,8 @@ struct bt_hci_evt_change_conn_link_key_complete {
 	uint16_t handle;
 } __attribute__ ((packed));
 
-#define BT_HCI_EVT_MASTER_LINK_KEY_COMPLETE	0x0a
-struct bt_hci_evt_master_link_key_complete {
+#define BT_HCI_EVT_LINK_KEY_TYPE_CHANGED	0x0a
+struct bt_hci_evt_link_key_type_changed {
 	uint8_t  status;
 	uint16_t handle;
 	uint8_t  key_flag;
@@ -3325,8 +3325,8 @@ struct bt_hci_evt_sync_train_received {
 	uint8_t  service_data;
 } __attribute__ ((packed));
 
-#define BT_HCI_EVT_SLAVE_BROADCAST_RECEIVE	0x51
-struct bt_hci_evt_slave_broadcast_receive {
+#define BT_HCI_EVT_PERIPHERAL_BROADCAST_RECEIVE	0x51
+struct bt_hci_evt_peripheral_broadcast_receive {
 	uint8_t  bdaddr[6];
 	uint8_t  lt_addr;
 	uint32_t clock;
@@ -3336,8 +3336,8 @@ struct bt_hci_evt_slave_broadcast_receive {
 	uint8_t  length;
 } __attribute__ ((packed));
 
-#define BT_HCI_EVT_SLAVE_BROADCAST_TIMEOUT	0x52
-struct bt_hci_evt_slave_broadcast_timeout {
+#define BT_HCI_EVT_PERIPHERAL_BROADCAST_TIMEOUT	0x52
+struct bt_hci_evt_peripheral_broadcast_timeout {
 	uint8_t  bdaddr[6];
 	uint8_t  lt_addr;
 } __attribute__ ((packed));
@@ -3348,10 +3348,10 @@ struct bt_hci_evt_truncated_page_complete {
 	uint8_t  bdaddr[6];
 } __attribute__ ((packed));
 
-#define BT_HCI_EVT_SLAVE_PAGE_RESPONSE_TIMEOUT	0x54
+#define BT_HCI_EVT_PERIPHERAL_PAGE_RESPONSE_TIMEOUT	0x54
 
-#define BT_HCI_EVT_SLAVE_BROADCAST_CHANNEL_MAP_CHANGE	0x55
-struct bt_hci_evt_slave_broadcast_channel_map_change {
+#define BT_HCI_EVT_PERIPHERAL_BROADCAST_CHANNEL_MAP_CHANGE	0x55
+struct bt_hci_evt_peripheral_broadcast_channel_map_change {
 	uint8_t  map[10];
 } __attribute__ ((packed));
 
@@ -3571,17 +3571,17 @@ struct bt_hci_evt_le_cis_established {
 	uint16_t conn_handle;
 	uint8_t  cig_sync_delay[3];
 	uint8_t  cis_sync_delay[3];
-	uint8_t  m_latency[3];
-	uint8_t  s_latency[3];
-	uint8_t  m_phy;
-	uint8_t  s_phy;
+	uint8_t  c_latency[3];
+	uint8_t  p_latency[3];
+	uint8_t  c_phy;
+	uint8_t  p_phy;
 	uint8_t  nse;
-	uint8_t  m_bn;
-	uint8_t  s_bn;
-	uint8_t  m_ft;
-	uint8_t  s_ft;
-	uint16_t m_mtu;
-	uint16_t s_mtu;
+	uint8_t  c_bn;
+	uint8_t  p_bn;
+	uint8_t  c_ft;
+	uint8_t  p_ft;
+	uint16_t c_mtu;
+	uint16_t p_mtu;
 	uint16_t interval;
 } __attribute__ ((packed));
 
@@ -4026,8 +4026,8 @@ struct bt_l2cap_smp_encrypt_info {
 	uint8_t  ltk[16];
 } __attribute__ ((packed));
 
-#define BT_L2CAP_SMP_MASTER_IDENT	0x07
-struct bt_l2cap_smp_master_ident {
+#define BT_L2CAP_SMP_CENTRAL_IDENT	0x07
+struct bt_l2cap_smp_central_ident {
 	uint16_t ediv;
 	uint64_t rand;
 } __attribute__ ((packed));
diff --git a/monitor/control.c b/monitor/control.c
index dad23a0e62..009cf15209 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -305,19 +305,19 @@ static void mgmt_new_long_term_key(uint16_t len, const void *buf)
 		return;
 	}
 
-	/* LE SC keys are both for master and slave */
+	/* LE SC keys are both for central and peripheral */
 	switch (ev->key.type) {
 	case 0x00:
 		if (ev->key.central)
-			type = "Master (Unauthenticated)";
+			type = "Central (Unauthenticated)";
 		else
-			type = "Slave (Unauthenticated)";
+			type = "Peripheral (Unauthenticated)";
 		break;
 	case 0x01:
 		if (ev->key.central)
-			type = "Master (Authenticated)";
+			type = "Central (Authenticated)";
 		else
-			type = "Slave (Authenticated)";
+			type = "Peripheral (Authenticated)";
 		break;
 	case 0x02:
 		type = "SC (Unauthenticated)";
diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 083e535613..4e449854ae 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -1280,7 +1280,7 @@ static void sig_conn_param_req(const struct l2cap_frame *frame)
 
 	print_field("Min interval: %d", le16_to_cpu(pdu->min_interval));
 	print_field("Max interval: %d", le16_to_cpu(pdu->max_interval));
-	print_field("Slave latency: %d", le16_to_cpu(pdu->latency));
+	print_field("Peripheral latency: %d", le16_to_cpu(pdu->latency));
 	print_field("Timeout multiplier: %d", le16_to_cpu(pdu->timeout));
 }
 
@@ -2960,9 +2960,9 @@ static void smp_encrypt_info(const struct l2cap_frame *frame)
 	print_hex_field("Long term key", pdu->ltk, 16);
 }
 
-static void smp_master_ident(const struct l2cap_frame *frame)
+static void smp_central_ident(const struct l2cap_frame *frame)
 {
-	const struct bt_l2cap_smp_master_ident *pdu = frame->data;
+	const struct bt_l2cap_smp_central_ident *pdu = frame->data;
 
 	print_field("EDIV: 0x%4.4x", le16_to_cpu(pdu->ediv));
 	print_field("Rand: 0x%16.16" PRIx64, le64_to_cpu(pdu->rand));
@@ -3065,8 +3065,8 @@ static const struct smp_opcode_data smp_opcode_table[] = {
 			smp_pairing_failed, 1, true },
 	{ 0x06, "Encryption Information",
 			smp_encrypt_info, 16, true },
-	{ 0x07, "Master Identification",
-			smp_master_ident, 10, true },
+	{ 0x07, "Central Identification",
+			smp_central_ident, 10, true },
 	{ 0x08, "Identity Information",
 			smp_ident_info, 16, true },
 	{ 0x09, "Identity Address Information",
diff --git a/monitor/ll.c b/monitor/ll.c
index cf93647e03..f588d5e992 100644
--- a/monitor/ll.c
+++ b/monitor/ll.c
@@ -186,7 +186,7 @@ static void advertising_packet(const void *data, uint8_t size)
 		print_field("Transmit window size: %u", win_size);
 		print_field("Transmit window offset: %u", win_offset);
 		print_field("Connection interval: %u", interval);
-		print_field("Connection slave latency: %u", latency);
+		print_field("Connection peripheral latency: %u", latency);
 		print_field("Connection supervision timeout: %u", timeout);
 
 		packet_print_channel_map_ll(ptr + 30);
@@ -371,8 +371,10 @@ static void conn_update_req(const void *data, uint8_t size)
 	print_field("Transmit window size: %u", pdu->win_size);
 	print_field("Transmit window offset: %u", le16_to_cpu(pdu->win_offset));
 	print_field("Connection interval: %u", le16_to_cpu(pdu->interval));
-	print_field("Connection slave latency: %u", le16_to_cpu(pdu->latency));
-	print_field("Connection supervision timeout: %u", le16_to_cpu(pdu->timeout));
+	print_field("Connection peripheral latency: %u",
+						le16_to_cpu(pdu->latency));
+	print_field("Connection supervision timeout: %u",
+						le16_to_cpu(pdu->timeout));
 	print_field("Connection instant: %u", le16_to_cpu(pdu->instant));
 }
 
@@ -397,16 +399,16 @@ static void enc_req(const void *data, uint8_t size)
 
 	print_field("Rand: 0x%16.16" PRIx64, le64_to_cpu(pdu->rand));
 	print_field("EDIV: 0x%4.4x", le16_to_cpu(pdu->ediv));
-	print_field("SKD (master): 0x%16.16" PRIx64, le64_to_cpu(pdu->skd));
-	print_field("IV (master): 0x%8.8x", le32_to_cpu(pdu->iv));
+	print_field("SKD (central): 0x%16.16" PRIx64, le64_to_cpu(pdu->skd));
+	print_field("IV (central): 0x%8.8x", le32_to_cpu(pdu->iv));
 }
 
 static void enc_rsp(const void *data, uint8_t size)
 {
 	const struct bt_ll_enc_rsp *pdu = data;
 
-	print_field("SKD (slave): 0x%16.16" PRIx64, le64_to_cpu(pdu->skd));
-	print_field("IV (slave): 0x%8.8x", le32_to_cpu(pdu->iv));
+	print_field("SKD (peripheral): 0x%16.16" PRIx64, le64_to_cpu(pdu->skd));
+	print_field("IV (peripheral): 0x%8.8x", le32_to_cpu(pdu->iv));
 }
 
 static const char *opcode_to_string(uint8_t opcode);
@@ -449,9 +451,9 @@ static void reject_ind(const void *data, uint8_t size)
 	packet_print_error("Error code", pdu->error);
 }
 
-static void slave_feature_req(const void *data, uint8_t size)
+static void peripheral_feature_req(const void *data, uint8_t size)
 {
-	const struct bt_ll_slave_feature_req *pdu = data;
+	const struct bt_ll_peripheral_feature_req *pdu = data;
 
 	packet_print_features_ll(pdu->features);
 }
@@ -505,16 +507,16 @@ static void phy_update_ind(const void *data, uint8_t size)
 	const struct bt_ll_phy_update_ind *pdu = data;
 	uint8_t mask;
 
-	print_field("M_TO_S_PHY: 0x%2.2x", pdu->m_phy);
+	print_field("C_TO_P_PHY: 0x%2.2x", pdu->c_phy);
 
-	mask = print_bitfield(2, pdu->m_phy, le_phys);
+	mask = print_bitfield(2, pdu->c_phy, le_phys);
 	if (mask)
 		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
 							" (0x%2.2x)", mask);
 
-	print_field("S_TO_M_PHY: 0x%2.2x", pdu->s_phy);
+	print_field("P_TO_C_PHY: 0x%2.2x", pdu->p_phy);
 
-	mask = print_bitfield(2, pdu->s_phy, le_phys);
+	mask = print_bitfield(2, pdu->p_phy, le_phys);
 	if (mask)
 		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
 							" (0x%2.2x)", mask);
@@ -596,38 +598,40 @@ static void cis_req(const void *data, uint8_t size)
 
 	print_field("CIG ID: 0x%2.2x", cmd->cig);
 	print_field("CIS ID: 0x%2.2x", cmd->cis);
-	print_field("Master to Slave PHY: 0x%2.2x", cmd->m_phy);
+	print_field("Central to Peripheral PHY: 0x%2.2x", cmd->c_phy);
 
-	mask = print_bitfield(2, cmd->m_phy, le_phys);
+	mask = print_bitfield(2, cmd->c_phy, le_phys);
 	if (mask)
 		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
 							" (0x%2.2x)", mask);
 
-	print_field("Slave To Master PHY: 0x%2.2x", cmd->s_phy);
+	print_field("Peripheral To Central PHY: 0x%2.2x", cmd->p_phy);
 
-	mask = print_bitfield(2, cmd->s_phy, le_phys);
+	mask = print_bitfield(2, cmd->p_phy, le_phys);
 	if (mask)
 		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
 							" (0x%2.2x)", mask);
 
-	print_field("Master to Slave Maximum SDU: %u", cmd->m_sdu);
-	print_field("Slave to Master Maximum SDU: %u", cmd->s_sdu);
+	print_field("Central to Peripheral Maximum SDU: %u", cmd->c_sdu);
+	print_field("Peripheral to Central Maximum SDU: %u", cmd->p_sdu);
 
-	memcpy(&interval, cmd->m_interval, sizeof(cmd->m_interval));
-	print_field("Master to Slave Interval: 0x%6.6x", le32_to_cpu(interval));
-	memcpy(&interval, cmd->s_interval, sizeof(cmd->s_interval));
-	print_field("Slave to Master Interval: 0x%6.6x", le32_to_cpu(interval));
+	memcpy(&interval, cmd->c_interval, sizeof(cmd->c_interval));
+	print_field("Central to Peripheral Interval: 0x%6.6x",
+							le32_to_cpu(interval));
+	memcpy(&interval, cmd->p_interval, sizeof(cmd->p_interval));
+	print_field("Peripheral to Central Interval: 0x%6.6x",
+							le32_to_cpu(interval));
 
-	print_field("Master to Slave Maximum PDU: %u", cmd->m_pdu);
-	print_field("Slave to Master Maximum PDU: %u", cmd->s_pdu);
+	print_field("Central to Peripheral Maximum PDU: %u", cmd->c_pdu);
+	print_field("Peripheral to Central Maximum PDU: %u", cmd->p_pdu);
 
 	print_field("Burst Number: %u us", cmd->bn);
 
 	memcpy(&interval, cmd->sub_interval, sizeof(cmd->sub_interval));
 	print_field("Sub-Interval: 0x%6.6x", le32_to_cpu(interval));
 
-	print_field("Master to Slave Flush Timeout: %u", cmd->m_ft);
-	print_field("Slave to Master Flush Timeout: %u", cmd->s_ft);
+	print_field("Central to Peripheral Flush Timeout: %u", cmd->c_ft);
+	print_field("Peripheral to Central Flush Timeout: %u", cmd->p_ft);
 
 	print_field("ISO Interval: 0x%4.4x", le16_to_cpu(cmd->iso_interval));
 
@@ -702,7 +706,7 @@ static const struct llcp_data llcp_table[] = {
 	{ 0x0b, "LL_PAUSE_ENC_RSP",         null_pdu,           0, true },
 	{ 0x0c, "LL_VERSION_IND",           version_ind,        5, true },
 	{ 0x0d, "LL_REJECT_IND",            reject_ind,         1, true },
-	{ 0x0e, "LL_SLAVE_FEATURE_REQ",     slave_feature_req,  8, true },
+	{ 0x0e, "LL_PERIPHERAL_FEATURE_REQ", peripheral_feature_req, 8, true },
 	{ 0x0f, "LL_CONNECTION_PARAM_REQ",  NULL,              23, true },
 	{ 0x10, "LL_CONNECTION_PARAM_RSP",  NULL,              23, true },
 	{ 0x11, "LL_REJECT_IND_EXT",        reject_ind_ext,     2, true },
diff --git a/monitor/lmp.c b/monitor/lmp.c
index 037adf2e25..d415699e46 100644
--- a/monitor/lmp.c
+++ b/monitor/lmp.c
@@ -839,7 +839,7 @@ void lmp_packet(const void *data, uint8_t size, bool padded)
 	tid = ((const uint8_t *) data)[0] & 0x01;
 	opcode = (((const uint8_t *) data)[0] & 0xfe) >> 1;
 
-	tid_str = tid == 0x00 ? "Master" : "Slave";
+	tid_str = tid == 0x00 ? "Central" : "Peripheral";
 
 	switch (opcode) {
 	case 127:
diff --git a/monitor/packet.c b/monitor/packet.c
index c4273484ec..2e0e487ba4 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -2171,16 +2171,16 @@ static void print_adv_filter_policy(const char *label, uint8_t value)
 			"Allow Connect Request from Any";
 		break;
 	case 0x01:
-		str = "Allow Scan Request from White List Only, "
+		str = "Allow Scan Request from Accept List Only, "
 			"Allow Connect Request from Any";
 		break;
 	case 0x02:
 		str = "Allow Scan Request from Any, "
-			"Allow Connect Request from White List Only";
+			"Allow Connect Request from Accept List Only";
 		break;
 	case 0x03:
-		str = "Allow Scan Request from White List Only, "
-			"Allow Connect Request from White List Only";
+		str = "Allow Scan Request from Accept List Only, "
+			"Allow Connect Request from Accept List Only";
 		break;
 	default:
 		str = "Reserved";
@@ -2234,10 +2234,10 @@ static void print_role(uint8_t role)
 
 	switch (role) {
 	case 0x00:
-		str = "Master";
+		str = "Central";
 		break;
 	case 0x01:
-		str = "Slave";
+		str = "Peripheral";
 		break;
 	default:
 		str = "Reserved";
@@ -2556,16 +2556,16 @@ static const struct bitfield_data features_page0[] = {
 	{ 31, "Extended SCO link (EV3 packets)"		},
 	{ 32, "EV4 packets"				},
 	{ 33, "EV5 packets"				},
-	{ 35, "AFH capable slave"			},
-	{ 36, "AFH classification slave"		},
+	{ 35, "AFH capable peripheral"			},
+	{ 36, "AFH classification peripheral"		},
 	{ 37, "BR/EDR Not Supported"			},
 	{ 38, "LE Supported (Controller)"		},
 	{ 39, "3-slot Enhanced Data Rate ACL packets"	},
 	{ 40, "5-slot Enhanced Data Rate ACL packets"	},
 	{ 41, "Sniff subrating"				},
 	{ 42, "Pause encryption"			},
-	{ 43, "AFH capable master"			},
-	{ 44, "AFH classification master"		},
+	{ 43, "AFH capable central"			},
+	{ 44, "AFH classification central"		},
 	{ 45, "Enhanced Data Rate eSCO 2 Mbps mode"	},
 	{ 46, "Enhanced Data Rate eSCO 3 Mbps mode"	},
 	{ 47, "3-slot Enhanced Data Rate eSCO packets"	},
@@ -2591,17 +2591,17 @@ static const struct bitfield_data features_page1[] = {
 };
 
 static const struct bitfield_data features_page2[] = {
-	{  0, "Connectionless Slave Broadcast - Master"	},
-	{  1, "Connectionless Slave Broadcast - Slave"	},
-	{  2, "Synchronization Train"			},
-	{  3, "Synchronization Scan"			},
-	{  4, "Inquiry Response Notification Event"	},
-	{  5, "Generalized interlaced scan"		},
-	{  6, "Coarse Clock Adjustment"			},
-	{  8, "Secure Connections (Controller Support)"	},
-	{  9, "Ping"					},
-	{ 10, "Slot Availability Mask"			},
-	{ 11, "Train nudging"				},
+	{  0, "Connectionless Peripheral Broadcast - Central"	},
+	{  1, "Connectionless Peripheral Broadcast - Peripheral"},
+	{  2, "Synchronization Train"				},
+	{  3, "Synchronization Scan"				},
+	{  4, "Inquiry Response Notification Event"		},
+	{  5, "Generalized interlaced scan"			},
+	{  6, "Coarse Clock Adjustment"				},
+	{  8, "Secure Connections (Controller Support)"		},
+	{  9, "Ping"						},
+	{ 10, "Slot Availability Mask"				},
+	{ 11, "Train nudging"					},
 	{ }
 };
 
@@ -2609,7 +2609,7 @@ static const struct bitfield_data features_le[] = {
 	{  0, "LE Encryption"					},
 	{  1, "Connection Parameter Request Procedure"		},
 	{  2, "Extended Reject Indication"			},
-	{  3, "Slave-initiated Features Exchange"		},
+	{  3, "Peripheral-initiated Features Exchange"		},
 	{  4, "LE Ping"						},
 	{  5, "LE Data Packet Length Extension"			},
 	{  6, "LL Privacy"					},
@@ -2634,8 +2634,8 @@ static const struct bitfield_data features_le[] = {
 	{ 25, "Periodic Advertising Sync Transfer - Recipient"	},
 	{ 26, "Sleep Clock Accuracy Updates"			},
 	{ 27, "Remote Public Key Validation"			},
-	{ 28, "Connected Isochronous Stream - Master"		},
-	{ 29, "Connected Isochronous Stream - Slave"		},
+	{ 28, "Connected Isochronous Stream - Central"		},
+	{ 29, "Connected Isochronous Stream - Peripheral"	},
 	{ 30, "Isochronous Broadcaster"				},
 	{ 31, "Synchronized Receiver"				},
 	{ 32, "Isochronous Channels (Host Support)"		},
@@ -2729,11 +2729,11 @@ void packet_print_features_msft(const uint8_t *features)
 #define LE_STATE_ACTIVE_SCAN		0x0020
 #define LE_STATE_PASSIVE_SCAN		0x0040
 #define LE_STATE_INITIATING		0x0080
-#define LE_STATE_CONN_MASTER		0x0100
-#define LE_STATE_CONN_SLAVE		0x0200
-#define LE_STATE_MASTER_MASTER		0x0400
-#define LE_STATE_SLAVE_SLAVE		0x0800
-#define LE_STATE_MASTER_SLAVE		0x1000
+#define LE_STATE_CONN_CENTRAL		0x0100
+#define LE_STATE_CONN_PERIPHERAL	0x0200
+#define LE_STATE_CENTRAL_CENTRAL	0x0400
+#define LE_STATE_PERIPHERAL_PERIPHERAL	0x0800
+#define LE_STATE_CENTRAL_PERIPHERAL	0x1000
 
 static const struct bitfield_data le_states_desc_table[] = {
 	{  0, "Scannable Advertising State"			},
@@ -2744,11 +2744,11 @@ static const struct bitfield_data le_states_desc_table[] = {
 	{  5, "Active Scanning State"				},
 	{  6, "Passive Scanning State"				},
 	{  7, "Initiating State"				},
-	{  8, "Connection State (Master Role)"			},
-	{  9, "Connection State (Slave Role)"			},
-	{ 10, "Master Role & Master Role"			},
-	{ 11, "Slave Role & Slave Role"				},
-	{ 12, "Master Role & Slave Role"			},
+	{  8, "Connection State (Central Role)"			},
+	{  9, "Connection State (Peripheral Role)"		},
+	{ 10, "Central Role & Central Role"			},
+	{ 11, "Peripheral Role & Peripheral Role"		},
+	{ 12, "Central Role & Peripheral Role"			},
 	{ }
 };
 
@@ -2756,59 +2756,59 @@ static const struct {
 	uint8_t bit;
 	uint16_t states;
 } le_states_comb_table[] = {
-	{  0, LE_STATE_NONCONN_ADV				},
-	{  1, LE_STATE_SCAN_ADV					},
-	{  2, LE_STATE_CONN_ADV					},
-	{  3, LE_STATE_HIGH_DIRECT_ADV				},
-	{  4, LE_STATE_PASSIVE_SCAN				},
-	{  5, LE_STATE_ACTIVE_SCAN				},
-	{  6, LE_STATE_INITIATING | LE_STATE_CONN_MASTER	},
-	{  7, LE_STATE_CONN_SLAVE				},
-	{  8, LE_STATE_PASSIVE_SCAN | LE_STATE_NONCONN_ADV	},
-	{  9, LE_STATE_PASSIVE_SCAN | LE_STATE_SCAN_ADV		},
-	{ 10, LE_STATE_PASSIVE_SCAN | LE_STATE_CONN_ADV		},
-	{ 11, LE_STATE_PASSIVE_SCAN | LE_STATE_HIGH_DIRECT_ADV	},
-	{ 12, LE_STATE_ACTIVE_SCAN | LE_STATE_NONCONN_ADV	},
-	{ 13, LE_STATE_ACTIVE_SCAN | LE_STATE_SCAN_ADV		},
-	{ 14, LE_STATE_ACTIVE_SCAN | LE_STATE_CONN_ADV		},
-	{ 15, LE_STATE_ACTIVE_SCAN | LE_STATE_HIGH_DIRECT_ADV	},
-	{ 16, LE_STATE_INITIATING | LE_STATE_NONCONN_ADV	},
-	{ 17, LE_STATE_INITIATING | LE_STATE_SCAN_ADV		},
-	{ 18, LE_STATE_CONN_MASTER | LE_STATE_NONCONN_ADV	},
-	{ 19, LE_STATE_CONN_MASTER | LE_STATE_SCAN_ADV		},
-	{ 20, LE_STATE_CONN_SLAVE | LE_STATE_NONCONN_ADV	},
-	{ 21, LE_STATE_CONN_SLAVE | LE_STATE_SCAN_ADV		},
-	{ 22, LE_STATE_INITIATING | LE_STATE_PASSIVE_SCAN	},
-	{ 23, LE_STATE_INITIATING | LE_STATE_ACTIVE_SCAN	},
-	{ 24, LE_STATE_CONN_MASTER | LE_STATE_PASSIVE_SCAN	},
-	{ 25, LE_STATE_CONN_MASTER | LE_STATE_ACTIVE_SCAN	},
-	{ 26, LE_STATE_CONN_SLAVE | LE_STATE_PASSIVE_SCAN	},
-	{ 27, LE_STATE_CONN_SLAVE | LE_STATE_ACTIVE_SCAN	},
-	{ 28, LE_STATE_INITIATING | LE_STATE_CONN_MASTER |
-					LE_STATE_MASTER_MASTER	},
-	{ 29, LE_STATE_LOW_DIRECT_ADV				},
-	{ 30, LE_STATE_LOW_DIRECT_ADV | LE_STATE_PASSIVE_SCAN	},
-	{ 31, LE_STATE_LOW_DIRECT_ADV | LE_STATE_ACTIVE_SCAN	},
+	{  0, LE_STATE_NONCONN_ADV					},
+	{  1, LE_STATE_SCAN_ADV						},
+	{  2, LE_STATE_CONN_ADV						},
+	{  3, LE_STATE_HIGH_DIRECT_ADV					},
+	{  4, LE_STATE_PASSIVE_SCAN					},
+	{  5, LE_STATE_ACTIVE_SCAN					},
+	{  6, LE_STATE_INITIATING | LE_STATE_CONN_CENTRAL		},
+	{  7, LE_STATE_CONN_PERIPHERAL					},
+	{  8, LE_STATE_PASSIVE_SCAN | LE_STATE_NONCONN_ADV		},
+	{  9, LE_STATE_PASSIVE_SCAN | LE_STATE_SCAN_ADV			},
+	{ 10, LE_STATE_PASSIVE_SCAN | LE_STATE_CONN_ADV			},
+	{ 11, LE_STATE_PASSIVE_SCAN | LE_STATE_HIGH_DIRECT_ADV		},
+	{ 12, LE_STATE_ACTIVE_SCAN | LE_STATE_NONCONN_ADV		},
+	{ 13, LE_STATE_ACTIVE_SCAN | LE_STATE_SCAN_ADV			},
+	{ 14, LE_STATE_ACTIVE_SCAN | LE_STATE_CONN_ADV			},
+	{ 15, LE_STATE_ACTIVE_SCAN | LE_STATE_HIGH_DIRECT_ADV		},
+	{ 16, LE_STATE_INITIATING | LE_STATE_NONCONN_ADV		},
+	{ 17, LE_STATE_INITIATING | LE_STATE_SCAN_ADV			},
+	{ 18, LE_STATE_CONN_CENTRAL | LE_STATE_NONCONN_ADV		},
+	{ 19, LE_STATE_CONN_CENTRAL | LE_STATE_SCAN_ADV			},
+	{ 20, LE_STATE_CONN_PERIPHERAL | LE_STATE_NONCONN_ADV		},
+	{ 21, LE_STATE_CONN_PERIPHERAL | LE_STATE_SCAN_ADV		},
+	{ 22, LE_STATE_INITIATING | LE_STATE_PASSIVE_SCAN		},
+	{ 23, LE_STATE_INITIATING | LE_STATE_ACTIVE_SCAN		},
+	{ 24, LE_STATE_CONN_CENTRAL | LE_STATE_PASSIVE_SCAN		},
+	{ 25, LE_STATE_CONN_CENTRAL | LE_STATE_ACTIVE_SCAN		},
+	{ 26, LE_STATE_CONN_PERIPHERAL | LE_STATE_PASSIVE_SCAN		},
+	{ 27, LE_STATE_CONN_PERIPHERAL | LE_STATE_ACTIVE_SCAN		},
+	{ 28, LE_STATE_INITIATING | LE_STATE_CONN_CENTRAL |
+					LE_STATE_CENTRAL_CENTRAL	},
+	{ 29, LE_STATE_LOW_DIRECT_ADV					},
+	{ 30, LE_STATE_LOW_DIRECT_ADV | LE_STATE_PASSIVE_SCAN		},
+	{ 31, LE_STATE_LOW_DIRECT_ADV | LE_STATE_ACTIVE_SCAN		},
 	{ 32, LE_STATE_INITIATING | LE_STATE_CONN_ADV |
-					LE_STATE_MASTER_SLAVE	},
+					LE_STATE_CENTRAL_PERIPHERAL	},
 	{ 33, LE_STATE_INITIATING | LE_STATE_HIGH_DIRECT_ADV |
-					LE_STATE_MASTER_SLAVE	},
+					LE_STATE_CENTRAL_PERIPHERAL	},
 	{ 34, LE_STATE_INITIATING | LE_STATE_LOW_DIRECT_ADV |
-					LE_STATE_MASTER_SLAVE	},
-	{ 35, LE_STATE_CONN_MASTER | LE_STATE_CONN_ADV |
-					LE_STATE_MASTER_SLAVE	},
-	{ 36, LE_STATE_CONN_MASTER | LE_STATE_HIGH_DIRECT_ADV |
-					LE_STATE_MASTER_SLAVE	},
-	{ 37, LE_STATE_CONN_MASTER | LE_STATE_LOW_DIRECT_ADV |
-					LE_STATE_MASTER_SLAVE	},
-	{ 38, LE_STATE_CONN_SLAVE | LE_STATE_CONN_ADV |
-					LE_STATE_MASTER_SLAVE	},
-	{ 39, LE_STATE_CONN_SLAVE | LE_STATE_HIGH_DIRECT_ADV |
-					LE_STATE_SLAVE_SLAVE	},
-	{ 40, LE_STATE_CONN_SLAVE | LE_STATE_LOW_DIRECT_ADV |
-					LE_STATE_SLAVE_SLAVE	},
-	{ 41, LE_STATE_INITIATING | LE_STATE_CONN_SLAVE |
-					LE_STATE_MASTER_SLAVE	},
+					LE_STATE_CENTRAL_PERIPHERAL	},
+	{ 35, LE_STATE_CONN_CENTRAL | LE_STATE_CONN_ADV |
+					LE_STATE_CENTRAL_PERIPHERAL	},
+	{ 36, LE_STATE_CONN_CENTRAL | LE_STATE_HIGH_DIRECT_ADV |
+					LE_STATE_CENTRAL_PERIPHERAL	},
+	{ 37, LE_STATE_CONN_CENTRAL | LE_STATE_LOW_DIRECT_ADV |
+					LE_STATE_CENTRAL_PERIPHERAL	},
+	{ 38, LE_STATE_CONN_PERIPHERAL | LE_STATE_CONN_ADV |
+					LE_STATE_CENTRAL_PERIPHERAL	},
+	{ 39, LE_STATE_CONN_PERIPHERAL | LE_STATE_HIGH_DIRECT_ADV |
+					LE_STATE_PERIPHERAL_PERIPHERAL	},
+	{ 40, LE_STATE_CONN_PERIPHERAL | LE_STATE_LOW_DIRECT_ADV |
+					LE_STATE_PERIPHERAL_PERIPHERAL	},
+	{ 41, LE_STATE_INITIATING | LE_STATE_CONN_PERIPHERAL |
+					LE_STATE_CENTRAL_PERIPHERAL	},
 	{ }
 };
 
@@ -2908,7 +2908,7 @@ static const struct bitfield_data events_table[] = {
 	{  6, "Remote Name Request Complete"				},
 	{  7, "Encryption Change"					},
 	{  8, "Change Connection Link Key Complete"			},
-	{  9, "Master Link Key Complete"				},
+	{  9, "Link Key Type Changed"					},
 	{ 10, "Read Remote Supported Features Complete"			},
 	{ 11, "Read Remote Version Information Complete"		},
 	{ 12, "QoS Setup Complete"					},
@@ -2989,11 +2989,11 @@ static const struct bitfield_data events_page2_table[] = {
 	{ 14, "Triggered Clock Capture"					},
 	{ 15, "Synchronization Train Complete"				},
 	{ 16, "Synchronization Train Received"				},
-	{ 17, "Connectionless Slave Broadcast Receive"			},
-	{ 18, "Connectionless Slave Broadcast Timeout"			},
+	{ 17, "Connectionless Peripheral Broadcast Receive"		},
+	{ 18, "Connectionless Peripheral Broadcast Timeout"		},
 	{ 19, "Truncated Page Complete"					},
-	{ 20, "Slave Page Response Timeout"				},
-	{ 21, "Connectionless Slave Broadcast Channel Map Change"	},
+	{ 20, "Peripheral Page Response Timeout"			},
+	{ 21, "Connectionless Peripheral Broadcast Channel Map Change"	},
 	{ 22, "Inquiry Response Notification"				},
 	{ 23, "Authenticated Payload Timeout Expired"			},
 	{ 24, "SAM Status Change"					},
@@ -3065,7 +3065,7 @@ static void print_fec(uint8_t fec)
 #define BT_EIR_DEVICE_ID		0x10
 #define BT_EIR_SMP_TK			0x10
 #define BT_EIR_SMP_OOB_FLAGS		0x11
-#define BT_EIR_SLAVE_CONN_INTERVAL	0x12
+#define BT_EIR_PERIPHERAL_CONN_INTERVAL	0x12
 #define BT_EIR_SERVICE_UUID16		0x14
 #define BT_EIR_SERVICE_UUID128		0x15
 #define BT_EIR_SERVICE_DATA		0x16
@@ -3675,10 +3675,10 @@ static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
 			print_field("SMP OOB Flags: 0x%2.2x", *data);
 			break;
 
-		case BT_EIR_SLAVE_CONN_INTERVAL:
+		case BT_EIR_PERIPHERAL_CONN_INTERVAL:
 			if (data_len < 4)
 				break;
-			print_field("Slave Conn. Interval: 0x%4.4x - 0x%4.4x",
+			print_field("Peripheral Conn. Interval: 0x%4.4x - 0x%4.4x",
 							get_le16(&data[0]),
 							get_le16(&data[2]));
 			break;
@@ -4147,10 +4147,10 @@ static void create_conn_cmd(const void *data, uint8_t size)
 
 	switch (cmd->role_switch) {
 	case 0x00:
-		str = "Stay master";
+		str = "Stay central";
 		break;
 	case 0x01:
-		str = "Allow slave";
+		str = "Allow peripheral";
 		break;
 	default:
 		str = "Reserved";
@@ -4260,9 +4260,9 @@ static void change_conn_link_key_cmd(const void *data, uint8_t size)
 	print_handle(cmd->handle);
 }
 
-static void master_link_key_cmd(const void *data, uint8_t size)
+static void link_key_selection_cmd(const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_master_link_key *cmd = data;
+	const struct bt_hci_cmd_link_key_selection *cmd = data;
 
 	print_key_flag(cmd->key_flag);
 }
@@ -4554,9 +4554,9 @@ static void truncated_page_cancel_cmd(const void *data, uint8_t size)
 	print_bdaddr(cmd->bdaddr);
 }
 
-static void set_slave_broadcast_cmd(const void *data, uint8_t size)
+static void set_peripheral_broadcast_cmd(const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_set_slave_broadcast *cmd = data;
+	const struct bt_hci_cmd_set_peripheral_broadcast *cmd = data;
 
 	print_field("Enable: 0x%2.2x", cmd->enable);
 	print_lt_addr(cmd->lt_addr);
@@ -4567,18 +4567,18 @@ static void set_slave_broadcast_cmd(const void *data, uint8_t size)
 	print_slot_625("Supervision timeout", cmd->timeout);
 }
 
-static void set_slave_broadcast_rsp(const void *data, uint8_t size)
+static void set_peripheral_broadcast_rsp(const void *data, uint8_t size)
 {
-	const struct bt_hci_rsp_set_slave_broadcast *rsp = data;
+	const struct bt_hci_rsp_set_peripheral_broadcast *rsp = data;
 
 	print_status(rsp->status);
 	print_lt_addr(rsp->lt_addr);
 	print_interval(rsp->interval);
 }
 
-static void set_slave_broadcast_receive_cmd(const void *data, uint8_t size)
+static void set_peripheral_broadcast_receive_cmd(const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_set_slave_broadcast_receive *cmd = data;
+	const struct bt_hci_cmd_set_peripheral_broadcast_receive *cmd = data;
 
 	print_field("Enable: 0x%2.2x", cmd->enable);
 	print_bdaddr(cmd->bdaddr);
@@ -4594,9 +4594,9 @@ static void set_slave_broadcast_receive_cmd(const void *data, uint8_t size)
 	print_channel_map(cmd->map);
 }
 
-static void set_slave_broadcast_receive_rsp(const void *data, uint8_t size)
+static void set_peripheral_broadcast_receive_rsp(const void *data, uint8_t size)
 {
-	const struct bt_hci_rsp_set_slave_broadcast_receive *rsp = data;
+	const struct bt_hci_rsp_set_peripheral_broadcast_receive *rsp = data;
 
 	print_status(rsp->status);
 	print_bdaddr(rsp->bdaddr);
@@ -5665,9 +5665,9 @@ static void delete_reserved_lt_addr_rsp(const void *data, uint8_t size)
 	print_lt_addr(rsp->lt_addr);
 }
 
-static void set_slave_broadcast_data_cmd(const void *data, uint8_t size)
+static void set_peripheral_broadcast_data_cmd(const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_set_slave_broadcast_data *cmd = data;
+	const struct bt_hci_cmd_set_peripheral_broadcast_data *cmd = data;
 
 	print_lt_addr(cmd->lt_addr);
 	print_broadcast_fragment(cmd->fragment);
@@ -5680,9 +5680,9 @@ static void set_slave_broadcast_data_cmd(const void *data, uint8_t size)
 	packet_hexdump(data + 3, size - 3);
 }
 
-static void set_slave_broadcast_data_rsp(const void *data, uint8_t size)
+static void set_peripheral_broadcast_data_rsp(const void *data, uint8_t size)
 {
-	const struct bt_hci_rsp_set_slave_broadcast_data *rsp = data;
+	const struct bt_hci_rsp_set_peripheral_broadcast_data *rsp = data;
 
 	print_status(rsp->status);
 	print_lt_addr(rsp->lt_addr);
@@ -6541,13 +6541,13 @@ static void print_scan_filter_policy(uint8_t policy)
 		str = "Accept all advertisement";
 		break;
 	case 0x01:
-		str = "Ignore not in white list";
+		str = "Ignore not in accept list";
 		break;
 	case 0x02:
 		str = "Accept all advertisement, inc. directed unresolved RPA";
 		break;
 	case 0x03:
-		str = "Ignore not in white list, exc. directed unresolved RPA";
+		str = "Ignore not in accept list, exc. directed unresolved RPA";
 		break;
 	default:
 		str = "Reserved";
@@ -6586,10 +6586,10 @@ static void le_create_conn_cmd(const void *data, uint8_t size)
 
 	switch (cmd->filter_policy) {
 	case 0x00:
-		str = "White list is not used";
+		str = "Accept list is not used";
 		break;
 	case 0x01:
-		str = "White list is used";
+		str = "Accept list is used";
 		break;
 	default:
 		str = "Reserved";
@@ -6612,25 +6612,25 @@ static void le_create_conn_cmd(const void *data, uint8_t size)
 	print_slot_625("Max connection length", cmd->max_length);
 }
 
-static void le_read_white_list_size_rsp(const void *data, uint8_t size)
+static void le_read_accept_list_size_rsp(const void *data, uint8_t size)
 {
-	const struct bt_hci_rsp_le_read_white_list_size *rsp = data;
+	const struct bt_hci_rsp_le_read_accept_list_size *rsp = data;
 
 	print_status(rsp->status);
 	print_field("Size: %u", rsp->size);
 }
 
-static void le_add_to_white_list_cmd(const void *data, uint8_t size)
+static void le_add_to_accept_list_cmd(const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_le_add_to_white_list *cmd = data;
+	const struct bt_hci_cmd_le_add_to_accept_list *cmd = data;
 
 	print_addr_type("Address type", cmd->addr_type);
 	print_addr("Address", cmd->addr, cmd->addr_type);
 }
 
-static void le_remove_from_white_list_cmd(const void *data, uint8_t size)
+static void le_remove_from_accept_list_cmd(const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_le_remove_from_white_list *cmd = data;
+	const struct bt_hci_cmd_le_remove_from_accept_list *cmd = data;
 
 	print_addr_type("Address type", cmd->addr_type);
 	print_addr("Address", cmd->addr, cmd->addr_type);
@@ -7569,10 +7569,10 @@ static void le_ext_create_conn_cmd(const void *data, uint8_t size)
 
 	switch (cmd->filter_policy) {
 	case 0x00:
-		str = "White list is not used";
+		str = "Accept list is not used";
 		break;
 	case 0x01:
-		str = "White list is used";
+		str = "Accept list is used";
 		break;
 	default:
 		str = "Reserved";
@@ -8030,16 +8030,16 @@ static void print_cis_params(const void *data, int i)
 	const struct bt_hci_cis_params *cis = data;
 
 	print_field("CIS ID: 0x%2.2x", cis->cis_id);
-	print_field("Master to Slave Maximum SDU Size: %u",
-						le16_to_cpu(cis->m_sdu));
-	print_field("Slave to Master Maximum SDU Size: %u",
-						le16_to_cpu(cis->s_sdu));
-	print_le_phy("Master to Slave PHY", cis->m_phy);
-	print_le_phy("Slave to Master PHY", cis->s_phy);
-	print_field("Master to Slave Retransmission attempts: 0x%2.2x",
-							cis->m_rtn);
-	print_field("Slave to Master Retransmission attempts: 0x%2.2x",
-							cis->s_rtn);
+	print_field("Central to Peripheral Maximum SDU Size: %u",
+						le16_to_cpu(cis->c_sdu));
+	print_field("Peripheral to Central Maximum SDU Size: %u",
+						le16_to_cpu(cis->p_sdu));
+	print_le_phy("Central to Peripheral PHY", cis->c_phy);
+	print_le_phy("Peripheral to Central PHY", cis->p_phy);
+	print_field("Central to Peripheral Retransmission attempts: 0x%2.2x",
+							cis->c_rtn);
+	print_field("Peripheral to Central Retransmission attempts: 0x%2.2x",
+							cis->p_rtn);
 }
 
 static void le_set_cig_params_cmd(const void *data, uint8_t size)
@@ -8047,15 +8047,17 @@ static void le_set_cig_params_cmd(const void *data, uint8_t size)
 	const struct bt_hci_cmd_le_set_cig_params *cmd = data;
 
 	print_field("CIG ID: 0x%2.2x", cmd->cig_id);
-	print_usec_interval("Master to Slave SDU Interval", cmd->m_interval);
-	print_usec_interval("Slave to Master SDU Interval", cmd->s_interval);
+	print_usec_interval("Central to Peripheral SDU Interval",
+							cmd->c_interval);
+	print_usec_interval("Peripheral to Central SDU Interval",
+							cmd->p_interval);
 	print_sca(cmd->sca);
 	print_packing(cmd->packing);
 	print_framing(cmd->framing);
-	print_field("Master to Slave Maximum Latency: %d ms (0x%4.4x)",
-		le16_to_cpu(cmd->m_latency), le16_to_cpu(cmd->m_latency));
-	print_field("Slave to Master Maximum Latency: %d ms (0x%4.4x)",
-		le16_to_cpu(cmd->s_latency), le16_to_cpu(cmd->s_latency));
+	print_field("Central to Peripheral Maximum Latency: %d ms (0x%4.4x)",
+		le16_to_cpu(cmd->c_latency), le16_to_cpu(cmd->c_latency));
+	print_field("Peripheral to Central Maximum Latency: %d ms (0x%4.4x)",
+		le16_to_cpu(cmd->p_latency), le16_to_cpu(cmd->p_latency));
 	print_field("Number of CIS: %u", cmd->num_cis);
 
 	size -= sizeof(*cmd);
@@ -8070,18 +8072,18 @@ static void print_cis_params_test(const void *data, int i)
 
 	print_field("CIS ID: 0x%2.2x", cis->cis_id);
 	print_field("NSE: 0x%2.2x", cis->nse);
-	print_field("Master to Slave Maximum SDU: 0x%4.4x",
-						le16_to_cpu(cis->m_sdu));
-	print_field("Slave to Master Maximum SDU: 0x%4.4x",
-						le16_to_cpu(cis->s_sdu));
-	print_field("Master to Slave Maximum PDU: 0x%4.4x",
-						le16_to_cpu(cis->m_pdu));
-	print_field("Slave to Master Maximum PDU: 0x%4.4x",
-						le16_to_cpu(cis->s_pdu));
-	print_le_phy("Master to Slave PHY", cis->m_phy);
-	print_le_phy("Slave to Master PHY", cis->s_phy);
-	print_field("Master to Slave Burst Number: 0x%2.2x", cis->m_bn);
-	print_field("Slave to Master Burst Number: 0x%2.2x", cis->s_bn);
+	print_field("Central to Peripheral Maximum SDU: 0x%4.4x", 
+						le16_to_cpu(cis->c_sdu));
+	print_field("Peripheral to Central Maximum SDU: 0x%4.4x",
+						le16_to_cpu(cis->p_sdu));
+	print_field("Central to Peripheral Maximum PDU: 0x%4.4x",
+						le16_to_cpu(cis->c_pdu));
+	print_field("Peripheral to Central Maximum PDU: 0x%4.4x",
+						le16_to_cpu(cis->p_pdu));
+	print_le_phy("Central to Peripheral PHY", cis->c_phy);
+	print_le_phy("Peripheral to Central PHY", cis->p_phy);
+	print_field("Central to Peripheral Burst Number: 0x%2.2x", cis->c_bn);
+	print_field("Peripheral to Central Burst Number: 0x%2.2x", cis->p_bn);
 }
 
 static void le_set_cig_params_test_cmd(const void *data, uint8_t size)
@@ -8089,10 +8091,12 @@ static void le_set_cig_params_test_cmd(const void *data, uint8_t size)
 	const struct bt_hci_cmd_le_set_cig_params_test *cmd = data;
 
 	print_field("CIG ID: 0x%2.2x", cmd->cig_id);
-	print_usec_interval("Master to Slave SDU Interval", cmd->m_interval);
-	print_usec_interval("Slave to Master SDU Interval", cmd->s_interval);
-	print_field("Master to Slave Flush Timeout: 0x%2.2x", cmd->m_ft);
-	print_field("Slave to Master Flush Timeout: 0x%2.2x", cmd->s_ft);
+	print_usec_interval("Central to Peripheral SDU Interval",
+							cmd->c_interval);
+	print_usec_interval("Peripheral to Central SDU Interval",
+							cmd->p_interval);
+	print_field("Central to Peripheral Flush Timeout: 0x%2.2x", cmd->c_ft);
+	print_field("Peripheral to Central Flush Timeout: 0x%2.2x", cmd->p_ft);
 	print_field("ISO Interval: %.2f ms (0x%4.4x)",
 				le16_to_cpu(cmd->iso_interval) * 1.25,
 				le16_to_cpu(cmd->iso_interval));
@@ -8425,8 +8429,8 @@ static const struct opcode_data opcode_table[] = {
 				set_conn_encrypt_cmd, 3, true },
 	{ 0x0415,  17, "Change Connection Link Key",
 				change_conn_link_key_cmd, 2, true },
-	{ 0x0417,  18, "Master Link Key",
-				master_link_key_cmd, 1, true },
+	{ 0x0417,  18, "Temporary Link Key",
+				link_key_selection_cmd, 1, true },
 	{ 0x0419,  19, "Remote Name Request",
 				remote_name_request_cmd, 10, true },
 	{ 0x041a,  20, "Remote Name Request Cancel",
@@ -8499,12 +8503,12 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x0440, 247, "Truncated Page Cancel",
 				truncated_page_cancel_cmd, 6, true,
 				status_bdaddr_rsp, 7, true },
-	{ 0x0441, 248, "Set Connectionless Slave Broadcast",
-				set_slave_broadcast_cmd, 11, true,
-				set_slave_broadcast_rsp, 4, true },
-	{ 0x0442, 249, "Set Connectionless Slave Broadcast Receive",
-				set_slave_broadcast_receive_cmd, 34, true,
-				set_slave_broadcast_receive_rsp, 8, true },
+	{ 0x0441, 248, "Set Connectionless Peripheral Broadcast",
+				set_peripheral_broadcast_cmd, 11, true,
+				set_peripheral_broadcast_rsp, 4, true },
+	{ 0x0442, 249, "Set Connectionless Peripheral Broadcast Receive",
+				set_peripheral_broadcast_receive_cmd, 34, true,
+				set_peripheral_broadcast_receive_rsp, 8, true },
 	{ 0x0443, 250, "Start Synchronization Train",
 				null_cmd, 0, true },
 	{ 0x0444, 251, "Receive Synchronization Train",
@@ -8805,9 +8809,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x0c75, 253, "Delete Reserved LT_ADDR",
 				delete_reserved_lt_addr_cmd, 1, true,
 				delete_reserved_lt_addr_rsp, 2, true },
-	{ 0x0c76, 254, "Set Connectionless Slave Broadcast Data",
-				set_slave_broadcast_data_cmd, 3, false,
-				set_slave_broadcast_data_rsp, 2, true },
+	{ 0x0c76, 254, "Set Connectionless Peripheral Broadcast Data",
+				set_peripheral_broadcast_data_cmd, 3, false,
+				set_peripheral_broadcast_data_rsp, 2, true },
 	{ 0x0c77, 255, "Read Synchronization Train Parameters",
 				null_cmd, 0, true,
 				read_sync_train_params_rsp, 8, true },
@@ -8995,17 +8999,17 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x200e, 213, "LE Create Connection Cancel",
 				null_cmd, 0, true,
 				status_rsp, 1, true },
-	{ 0x200f, 214, "LE Read White List Size",
+	{ 0x200f, 214, "LE Read Accept List Size",
 				null_cmd, 0, true,
-				le_read_white_list_size_rsp, 2, true },
-	{ 0x2010, 215, "LE Clear White List",
+				le_read_accept_list_size_rsp, 2, true },
+	{ 0x2010, 215, "LE Clear Accept List",
 				null_cmd, 0, true,
 				status_rsp, 1, true },
-	{ 0x2011, 216, "LE Add Device To White List",
-				le_add_to_white_list_cmd, 7, true,
+	{ 0x2011, 216, "LE Add Device To Accept List",
+				le_add_to_accept_list_cmd, 7, true,
 				status_rsp, 1, true },
-	{ 0x2012, 217, "LE Remove Device From White List",
-				le_remove_from_white_list_cmd, 7, true,
+	{ 0x2012, 217, "LE Remove Device From Accept List",
+				le_remove_from_accept_list_cmd, 7, true,
 				status_rsp, 1, true },
 	{ 0x2013, 218, "LE Connection Update",
 				le_conn_update_cmd, 14, true },
@@ -9502,9 +9506,9 @@ static void change_conn_link_key_complete_evt(const void *data, uint8_t size)
 	print_handle(evt->handle);
 }
 
-static void master_link_key_complete_evt(const void *data, uint8_t size)
+static void link_key_type_changed_evt(const void *data, uint8_t size)
 {
-	const struct bt_hci_evt_master_link_key_complete *evt = data;
+	const struct bt_hci_evt_link_key_type_changed *evt = data;
 
 	print_status(evt->status);
 	print_handle(evt->handle);
@@ -10209,9 +10213,9 @@ static void sync_train_received_evt(const void *data, uint8_t size)
 	print_field("Service Data: 0x%2.2x", evt->service_data);
 }
 
-static void slave_broadcast_receive_evt(const void *data, uint8_t size)
+static void peripheral_broadcast_receive_evt(const void *data, uint8_t size)
 {
-	const struct bt_hci_evt_slave_broadcast_receive *evt = data;
+	const struct bt_hci_evt_peripheral_broadcast_receive *evt = data;
 
 	print_bdaddr(evt->bdaddr);
 	print_lt_addr(evt->lt_addr);
@@ -10231,9 +10235,9 @@ static void slave_broadcast_receive_evt(const void *data, uint8_t size)
 		packet_hexdump(data + 18, size - 18);
 }
 
-static void slave_broadcast_timeout_evt(const void *data, uint8_t size)
+static void peripheral_broadcast_timeout_evt(const void *data, uint8_t size)
 {
-	const struct bt_hci_evt_slave_broadcast_timeout *evt = data;
+	const struct bt_hci_evt_peripheral_broadcast_timeout *evt = data;
 
 	print_bdaddr(evt->bdaddr);
 	print_lt_addr(evt->lt_addr);
@@ -10247,13 +10251,14 @@ static void truncated_page_complete_evt(const void *data, uint8_t size)
 	print_bdaddr(evt->bdaddr);
 }
 
-static void slave_page_response_timeout_evt(const void *data, uint8_t size)
+static void peripheral_page_response_timeout_evt(const void *data, uint8_t size)
 {
 }
 
-static void slave_broadcast_channel_map_change_evt(const void *data, uint8_t size)
+static void peripheral_broadcast_channel_map_change_evt(const void *data,
+								uint8_t size)
 {
-	const struct bt_hci_evt_slave_broadcast_channel_map_change *evt = data;
+	const struct bt_hci_evt_peripheral_broadcast_channel_map_change *evt = data;
 
 	print_channel_map(evt->map);
 }
@@ -10287,7 +10292,7 @@ static void le_conn_complete_evt(const void *data, uint8_t size)
 	print_field("Supervision timeout: %d msec (0x%4.4x)",
 					le16_to_cpu(evt->supv_timeout) * 10,
 					le16_to_cpu(evt->supv_timeout));
-	print_field("Master clock accuracy: 0x%2.2x", evt->clock_accuracy);
+	print_field("Central clock accuracy: 0x%2.2x", evt->clock_accuracy);
 
 	if (evt->status == 0x00)
 		assign_handle(le16_to_cpu(evt->handle), 0x01);
@@ -10408,7 +10413,7 @@ static void le_enhanced_conn_complete_evt(const void *data, uint8_t size)
 	print_field("Supervision timeout: %d msec (0x%4.4x)",
 					le16_to_cpu(evt->supv_timeout) * 10,
 					le16_to_cpu(evt->supv_timeout));
-	print_field("Master clock accuracy: 0x%2.2x", evt->clock_accuracy);
+	print_field("Central clock accuracy: 0x%2.2x", evt->clock_accuracy);
 
 	if (evt->status == 0x00)
 		assign_handle(le16_to_cpu(evt->handle), 0x01);
@@ -10784,17 +10789,17 @@ static void le_cis_established_evt(const void *data, uint8_t size)
 	print_field("Connection Handle: %d", le16_to_cpu(evt->conn_handle));
 	print_usec_interval("CIG Synchronization Delay", evt->cig_sync_delay);
 	print_usec_interval("CIS Synchronization Delay", evt->cis_sync_delay);
-	print_usec_interval("Master to Slave Latency", evt->m_latency);
-	print_usec_interval("Slave to Master Latency", evt->s_latency);
-	print_le_phy("Master to Slave PHY", evt->m_phy);
-	print_le_phy("Slave to Master PHY", evt->s_phy);
+	print_usec_interval("Central to Peripheral Latency", evt->c_latency);
+	print_usec_interval("Peripheral to Central Latency", evt->p_latency);
+	print_le_phy("Central to Peripheral PHY", evt->c_phy);
+	print_le_phy("Peripheral to Central PHY", evt->p_phy);
 	print_field("Number of Subevents: %u", evt->nse);
-	print_field("Master to Slave Burst Number: %u", evt->m_bn);
-	print_field("Slave to Master Burst Number: %u", evt->s_bn);
-	print_field("Master to Slave Flush Timeout: %u", evt->m_ft);
-	print_field("Slave to Master Flush Timeout: %u", evt->s_ft);
-	print_field("Master to Slave MTU: %u", le16_to_cpu(evt->m_mtu));
-	print_field("Slave to Master MTU: %u", le16_to_cpu(evt->s_mtu));
+	print_field("Central to Peripheral Burst Number: %u", evt->c_bn);
+	print_field("Peripheral to Central Burst Number: %u", evt->p_bn);
+	print_field("Central to Peripheral Flush Timeout: %u", evt->c_ft);
+	print_field("Peripheral to Central Flush Timeout: %u", evt->p_ft);
+	print_field("Central to Peripheral MTU: %u", le16_to_cpu(evt->c_mtu));
+	print_field("Peripheral to Central MTU: %u", le16_to_cpu(evt->p_mtu));
 	print_field("ISO Interval: %u", le16_to_cpu(evt->interval));
 }
 
@@ -11082,8 +11087,8 @@ static const struct event_data event_table[] = {
 				encrypt_change_evt, 4, true },
 	{ 0x09, "Change Connection Link Key Complete",
 				change_conn_link_key_complete_evt, 3, true },
-	{ 0x0a, "Master Link Key Complete",
-				master_link_key_complete_evt, 4, true },
+	{ 0x0a, "Link Key Type Changed",
+				link_key_type_changed_evt, 4, true },
 	{ 0x0b, "Read Remote Supported Features",
 				remote_features_complete_evt, 11, true },
 	{ 0x0c, "Read Remote Version Complete",
@@ -11199,16 +11204,16 @@ static const struct event_data event_table[] = {
 				sync_train_complete_evt, 1, true },
 	{ 0x50, "Synchronization Train Received",
 				sync_train_received_evt, 29, true },
-	{ 0x51, "Connectionless Slave Broadcast Receive",
-				slave_broadcast_receive_evt, 18, false },
-	{ 0x52, "Connectionless Slave Broadcast Timeout",
-				slave_broadcast_timeout_evt, 7, true },
+	{ 0x51, "Connectionless Peripheral Broadcast Receive",
+				peripheral_broadcast_receive_evt, 18, false },
+	{ 0x52, "Connectionless Peripheral Broadcast Timeout",
+				peripheral_broadcast_timeout_evt, 7, true },
 	{ 0x53, "Truncated Page Complete",
 				truncated_page_complete_evt, 7, true },
-	{ 0x54, "Slave Page Response Timeout",
-				slave_page_response_timeout_evt, 0, true },
-	{ 0x55, "Connectionless Slave Broadcast Channel Map Change",
-				slave_broadcast_channel_map_change_evt, 10, true },
+	{ 0x54, "Peripheral Page Response Timeout",
+				peripheral_page_response_timeout_evt, 0, true },
+	{ 0x55, "Connectionless Peripheral Broadcast Channel Map Change",
+			peripheral_broadcast_channel_map_change_evt, 10, true },
 	{ 0x56, "Inquiry Response Notification",
 				inquiry_response_notify_evt, 4, true },
 	{ 0x57, "Authenticated Payload Timeout Expired",
@@ -12171,7 +12176,7 @@ static void mgmt_print_long_term_key(const void *data)
 {
 	uint8_t address_type = get_u8(data + 6);
 	uint8_t key_type = get_u8(data + 7);
-	uint8_t master = get_u8(data + 8);
+	uint8_t central = get_u8(data + 8);
 	uint8_t enc_size = get_u8(data + 9);
 	const char *str;
 
@@ -12199,7 +12204,7 @@ static void mgmt_print_long_term_key(const void *data)
 	}
 
 	print_field("Key type: %s (0x%2.2x)", str, key_type);
-	print_field("Master: 0x%2.2x", master);
+	print_field("Central: 0x%2.2x", central);
 	print_field("Encryption size: %u", enc_size);
 	print_hex_field("Diversifier", data + 10, 2);
 	print_hex_field("Randomizer", data + 12, 8);
diff --git a/tools/3dsp.c b/tools/3dsp.c
index 99c1ac82bc..5227c30b63 100644
--- a/tools/3dsp.c
+++ b/tools/3dsp.c
@@ -122,7 +122,7 @@ static void sync_train_received(const void *data, uint8_t size,
 							void *user_data)
 {
 	const struct bt_hci_evt_sync_train_received *evt = data;
-	struct bt_hci_cmd_set_slave_broadcast_receive cmd;
+	struct bt_hci_cmd_set_peripheral_broadcast_receive cmd;
 
 	if (evt->status) {
 		printf("Failed to synchronize with 3D display\n");
@@ -147,7 +147,7 @@ static void sync_train_received(const void *data, uint8_t size,
 	cmd.pkt_type = cpu_to_le16(PKT_TYPE);
 	memcpy(cmd.map, evt->map, 10);
 
-	bt_hci_send(hci_dev, BT_HCI_CMD_SET_SLAVE_BROADCAST_RECEIVE,
+	bt_hci_send(hci_dev, BT_HCI_CMD_SET_PERIPHERAL_BROADCAST_RECEIVE,
 				&cmd, sizeof(cmd),
 				set_slave_broadcast_receive, NULL, NULL);
 }
@@ -156,7 +156,7 @@ static void brcm_sync_train_received(const void *data, uint8_t size,
 							void *user_data)
 {
 	const struct brcm_evt_sync_train_received *evt = data;
-	struct bt_hci_cmd_set_slave_broadcast_receive cmd;
+	struct bt_hci_cmd_set_peripheral_broadcast_receive cmd;
 
 	if (evt->status) {
 		printf("Failed to synchronize with 3D display\n");
@@ -181,7 +181,7 @@ static void brcm_sync_train_received(const void *data, uint8_t size,
 	cmd.pkt_type = cpu_to_le16(PKT_TYPE);
 	memcpy(cmd.map, evt->map, 10);
 
-	bt_hci_send(hci_dev, BT_HCI_CMD_SET_SLAVE_BROADCAST_RECEIVE,
+	bt_hci_send(hci_dev, BT_HCI_CMD_SET_PERIPHERAL_BROADCAST_RECEIVE,
 				&cmd, sizeof(cmd),
 				set_slave_broadcast_receive, NULL, NULL);
 }
@@ -212,7 +212,7 @@ static void truncated_page_complete(const void *data, uint8_t size,
 static void slave_broadcast_timeout(const void *data, uint8_t size,
 							void *user_data)
 {
-	const struct bt_hci_evt_slave_broadcast_timeout *evt = data;
+	const struct bt_hci_evt_peripheral_broadcast_timeout *evt = data;
 	struct bt_hci_cmd_receive_sync_train cmd;
 
 	printf("Re-synchronizing with 3D display\n");
@@ -229,7 +229,7 @@ static void slave_broadcast_timeout(const void *data, uint8_t size,
 static void slave_broadcast_receive(const void *data, uint8_t size,
 							void *user_data)
 {
-	const struct bt_hci_evt_slave_broadcast_receive *evt = data;
+	const struct bt_hci_evt_peripheral_broadcast_receive *evt = data;
 	struct bt_hci_cmd_read_clock cmd;
 
 	if (evt->status != 0x00)
@@ -326,9 +326,9 @@ static void start_glasses(void)
 
 	bt_hci_register(hci_dev, BT_HCI_EVT_TRUNCATED_PAGE_COMPLETE,
 					truncated_page_complete, NULL, NULL);
-	bt_hci_register(hci_dev, BT_HCI_EVT_SLAVE_BROADCAST_TIMEOUT,
+	bt_hci_register(hci_dev, BT_HCI_EVT_PERIPHERAL_BROADCAST_TIMEOUT,
 					slave_broadcast_timeout, NULL, NULL);
-	bt_hci_register(hci_dev, BT_HCI_EVT_SLAVE_BROADCAST_RECEIVE,
+	bt_hci_register(hci_dev, BT_HCI_EVT_PERIPHERAL_BROADCAST_RECEIVE,
 					slave_broadcast_receive, NULL, NULL);
 
 	start_inquiry();
@@ -443,13 +443,13 @@ static void read_clock(const void *data, uint8_t size, void *user_data)
 	msg.frame_sync_period_fraction = 0;
 	memcpy(bcastdata + 3, &msg, sizeof(msg));
 
-	bt_hci_send(hci_dev, BT_HCI_CMD_SET_SLAVE_BROADCAST_DATA,
+	bt_hci_send(hci_dev, BT_HCI_CMD_SET_PERIPHERAL_BROADCAST_DATA,
 			bcastdata, sizeof(bcastdata), NULL, NULL, NULL);
 }
 
 static void set_slave_broadcast(const void *data, uint8_t size, void *user_data)
 {
-	const struct bt_hci_rsp_set_slave_broadcast *rsp = data;
+	const struct bt_hci_rsp_set_peripheral_broadcast *rsp = data;
 	struct bt_hci_cmd_read_clock cmd;
 
 	if (rsp->status) {
@@ -467,7 +467,7 @@ static void set_slave_broadcast(const void *data, uint8_t size, void *user_data)
 
 static void start_display(void)
 {
-	struct bt_hci_cmd_set_slave_broadcast cmd;
+	struct bt_hci_cmd_set_peripheral_broadcast cmd;
 	uint8_t evtmask1[] = { 0x1c, 0xe0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
 	uint8_t evtmask2[] = { 0x00, 0xc0, 0x74, 0x00, 0x00, 0x00, 0x00, 0x00 };
 	uint8_t sspmode = 0x01;
@@ -492,10 +492,11 @@ static void start_display(void)
 	bt_hci_register(hci_dev, BT_HCI_EVT_CONN_REQUEST,
 						conn_request, NULL, NULL);
 
-	bt_hci_register(hci_dev, BT_HCI_EVT_SLAVE_PAGE_RESPONSE_TIMEOUT,
+	bt_hci_register(hci_dev, BT_HCI_EVT_PERIPHERAL_PAGE_RESPONSE_TIMEOUT,
 				slave_page_response_timeout, NULL, NULL);
-	bt_hci_register(hci_dev, BT_HCI_EVT_SLAVE_BROADCAST_CHANNEL_MAP_CHANGE,
-				slave_broadcast_channel_map_change, NULL, NULL);
+	bt_hci_register(hci_dev,
+			BT_HCI_EVT_PERIPHERAL_BROADCAST_CHANNEL_MAP_CHANGE,
+			slave_broadcast_channel_map_change, NULL, NULL);
 	bt_hci_register(hci_dev, BT_HCI_EVT_SYNC_TRAIN_COMPLETE,
 					sync_train_complete, NULL, NULL);
 
@@ -510,8 +511,8 @@ static void start_display(void)
 	cmd.max_interval = cpu_to_le16(0x00a0);		/* 100 ms */
 	cmd.timeout = cpu_to_le16(0xfffe);
 
-	bt_hci_send(hci_dev, BT_HCI_CMD_SET_SLAVE_BROADCAST, &cmd, sizeof(cmd),
-					set_slave_broadcast, NULL, NULL);
+	bt_hci_send(hci_dev, BT_HCI_CMD_SET_PERIPHERAL_BROADCAST, &cmd,
+			sizeof(cmd), set_slave_broadcast, NULL, NULL);
 }
 
 static void signal_callback(int signum, void *user_data)
diff --git a/tools/hci-tester.c b/tools/hci-tester.c
index 0fb74e69c7..645d89e721 100644
--- a/tools/hci-tester.c
+++ b/tools/hci-tester.c
@@ -337,12 +337,12 @@ static void test_read_local_supported_codecs(const void *test_data)
 
 static void test_le_read_white_list_size(const void *test_data)
 {
-	test_command(BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE);
+	test_command(BT_HCI_CMD_LE_READ_ACCEPT_LIST_SIZE);
 }
 
 static void test_le_clear_white_list(const void *test_data)
 {
-	test_command(BT_HCI_CMD_LE_CLEAR_WHITE_LIST);
+	test_command(BT_HCI_CMD_LE_CLEAR_ACCEPT_LIST);
 }
 
 static void test_le_encrypt_complete(const void *data, uint8_t size,
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index da53e4484d..ccc082a488 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -4248,7 +4248,7 @@ static const struct generic_data add_device_success_6 = {
 	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
 	.expect_alt_ev_param = add_device_success_param_6,
 	.expect_alt_ev_len = sizeof(add_device_success_param_6),
-	.expect_hci_command = BT_HCI_CMD_LE_ADD_TO_WHITE_LIST,
+	.expect_hci_command = BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST,
 	.expect_hci_param = le_add_to_white_list_param,
 	.expect_hci_len = sizeof(le_add_to_white_list_param),
 };
@@ -4418,7 +4418,7 @@ static const struct generic_data remove_device_success_7 = {
 	.expect_param = remove_device_param_2,
 	.expect_len = sizeof(remove_device_param_2),
 	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_hci_command = BT_HCI_CMD_LE_REMOVE_FROM_WHITE_LIST,
+	.expect_hci_command = BT_HCI_CMD_LE_REMOVE_FROM_ACCEPT_LIST,
 	.expect_hci_param = le_add_to_white_list_param,
 	.expect_hci_len = sizeof(le_add_to_white_list_param),
 	.expect_alt_ev = MGMT_EV_DEVICE_REMOVED,
-- 
2.33.0.259.gc128427fd7-goog

