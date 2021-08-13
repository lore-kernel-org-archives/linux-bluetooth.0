Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDF5C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0864360F46
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240395AbhHMMV3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240385AbhHMMV2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:21:28 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA24C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:01 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id p21-20020a1709028a95b029012c31764588so6010011plo.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=nzrONIA7bH3137cq7XvGKbnJDxWYiVMJ/GxdDPVyZTQ=;
        b=rKO8fMnm7hV2RaZs1ePzSEWilZXfdXpj8q/vGOj7v56MVJrNZ1Aam+IaHj7xoiZeON
         YrVeToieskmkUpT0cEQOb0gQG+vxjWzn+eqRWBmLguUxR3LCHCSqO0b6kdpZZ0x3Xlep
         pBaqwFERq3ez6vMgimImCA6G75NHFt4qjrMzxeZIO4aW7m+xRvljEblTBU6QYEmoU9aJ
         7KhNmYU/IzwsR4eD/Mt6Sgm3jFvcmgpfLt2niZBM+9PZVYI64CZ1Zi2lhzvc0Tcc5Acd
         216h9KFzX2AoeEPwbhYUL4h9fX4Ne3bJbpi5oEtonZCUgKPVQrXGAXQ3FBMWmD/nyOk8
         MZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=nzrONIA7bH3137cq7XvGKbnJDxWYiVMJ/GxdDPVyZTQ=;
        b=drRkr7s3YP1VuzBlTibPo+gxwvyi0eWPpybdBCLN1zyBWrQC85gW36Minxs2+u3u2l
         acj/wvWyDZtiFoRFVUkmFPOfdqW62lSzkNSRRDllysEy3rLqHLhL6recuJ+OyYUSiN86
         iSHKQo1nYqj1KRx7X2ffbUcpydhlhKRTPnPXHrg2gOeB0rXElkyPkLv4LObjhkVWfFAy
         n99LEX5qf+O81u12Z6uBPzbVE46oJ7zfBSQl2+HRSHFsoMrde2lEGYwD+TfE6BkEXrKl
         C1JpNCVHeijdui0v7ZDvu+GMNGSzvc6acyYbhD9B8Y6D/BqGqwajpiVFC/tG2JCPGBJn
         ONBw==
X-Gm-Message-State: AOAM533bvfkMgC3BaTYo9BD6Df5s8jhytnZGpkDJb/Zl0QW4XtPtKviT
        wUv+LhIdQnuptWq0mftg/Ib9xLgDp9Gs8mhdnoLyO0hI42NYZg9jYjjMxOxpl8nVR9wYtxO0EU+
        1usARYsPKhJrTph3NkyndYKCpVe1O/stRJ3tTGtakVNL9dzySS1V0MLOFPPk475dr+3QNHPF5tw
        0G
X-Google-Smtp-Source: ABdhPJyTBMDHBqHlfaJ1aqPj2NYi8ArW37mvCLdcOjVw/zhHM7Wfh019X6s0gZE9E0ZA4H7IzGnvW5hjrK2S
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a62:e50c:0:b029:2f9:b9b1:d44f with SMTP id
 n12-20020a62e50c0000b02902f9b9b1d44fmr2256978pff.42.1628857261045; Fri, 13
 Aug 2021 05:21:01 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:08 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.23.I59a47b0cbace5a852aa6b4a2021d9fb02ab9afcf@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 23/62] emulator: Inclusive language in filtering device
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"accept list" is preferred, as reflected in the BT core spec 5.3.
---

 emulator/btdev.c | 114 +++++++++++++++++++++++------------------------
 emulator/le.c    |  78 ++++++++++++++++----------------
 2 files changed, 96 insertions(+), 96 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 14c7016ea6..ed79a827f8 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -33,7 +33,7 @@
 #include "monitor/bt.h"
 #include "btdev.h"
=20
-#define WL_SIZE			16
+#define AL_SIZE			16
 #define RL_SIZE			16
 #define CIS_SIZE		3
=20
@@ -61,7 +61,7 @@ struct btdev_conn {
 	struct btdev_conn *link;
 };
=20
-struct btdev_wl {
+struct btdev_al {
 	uint8_t type;
 	bdaddr_t addr;
 };
@@ -190,7 +190,7 @@ struct btdev {
 	} __attribute__ ((packed)) le_cig;
 	uint8_t  le_iso_path[2];
=20
-	struct btdev_wl le_wl[WL_SIZE];
+	struct btdev_al le_al[AL_SIZE];
 	struct btdev_rl le_rl[RL_SIZE];
 	uint8_t  le_rl_enable;
 	uint16_t le_rl_timeout;
@@ -426,18 +426,18 @@ static int cmd_set_event_mask(struct btdev *dev, cons=
t void *data, uint8_t len)
 	return 0;
 }
=20
-static void wl_reset(struct btdev_wl *wl)
+static void al_reset(struct btdev_al *al)
 {
-	wl->type =3D 0xff;
-	bacpy(&wl->addr, BDADDR_ANY);
+	al->type =3D 0xff;
+	bacpy(&al->addr, BDADDR_ANY);
 }
=20
-static void wl_clear(struct btdev *dev)
+static void al_clear(struct btdev *dev)
 {
 	int i;
=20
-	for (i =3D 0; i < WL_SIZE; i++)
-		wl_reset(&dev->le_wl[i]);
+	for (i =3D 0; i < AL_SIZE; i++)
+		al_reset(&dev->le_al[i]);
 }
=20
 static void rl_reset(struct btdev_rl *rl)
@@ -465,7 +465,7 @@ static void btdev_reset(struct btdev *btdev)
 	btdev->le_scan_enable		=3D 0x00;
 	btdev->le_adv_enable		=3D 0x00;
=20
-	wl_clear(btdev);
+	al_clear(btdev);
 	rl_clear(btdev);
 }
=20
@@ -3490,25 +3490,25 @@ static int cmd_le_create_conn_complete(struct btdev=
 *dev, const void *data,
 	return 0;
 }
=20
-static int cmd_read_wl_size(struct btdev *dev, const void *data, uint8_t l=
en)
+static int cmd_read_al_size(struct btdev *dev, const void *data, uint8_t l=
en)
 {
 	struct bt_hci_rsp_le_read_accept_list_size rsp;
=20
 	rsp.status =3D BT_HCI_ERR_SUCCESS;
-	rsp.size =3D WL_SIZE;
+	rsp.size =3D AL_SIZE;
 	cmd_complete(dev, BT_HCI_CMD_LE_READ_ACCEPT_LIST_SIZE, &rsp,
 						sizeof(rsp));
=20
 	return 0;
 }
=20
-static bool wl_can_change(struct btdev *dev)
+static bool al_can_change(struct btdev *dev)
 {
-	 /* filter policy uses the White List and advertising is enable. */
+	 /* filter policy uses the Accept List and advertising is enable. */
 	if (dev->le_adv_enable && dev->le_adv_filter_policy)
 		return false;
=20
-	/* scanning filter policy uses the White List and scanning is enabled */
+	/* scan filter policy uses the Accept List and scanning is enabled */
 	if (dev->le_scan_enable) {
 		switch (dev->le_scan_filter_policy) {
 		case 0x00:
@@ -3525,23 +3525,23 @@ static bool wl_can_change(struct btdev *dev)
 	return true;
 }
=20
-static int cmd_wl_clear(struct btdev *dev, const void *data, uint8_t len)
+static int cmd_al_clear(struct btdev *dev, const void *data, uint8_t len)
 {
 	uint8_t status;
=20
 	/* This command shall not be used when:
-	 * =E2=80=A2 any advertising filter policy uses the White List and advert=
ising
+	 * =E2=80=A2 any advertising filter policy uses the Accept List and adver=
tising
 	 * is enabled,
-	 * =E2=80=A2 the scanning filter policy uses the White List and scanning =
is
+	 * =E2=80=A2 the scanning filter policy uses the Accept List and scanning=
 is
 	 * enabled, or
-	 * =E2=80=A2 the initiator filter policy uses the White List and an
+	 * =E2=80=A2 the initiator filter policy uses the Accept List and an
 	 * HCI_LE_Create_Connection or HCI_LE_Extended_Create_Connection
 	 * command is outstanding.
 	 */
-	if (!wl_can_change(dev))
+	if (!al_can_change(dev))
 		return -EPERM;
=20
-	wl_clear(dev);
+	al_clear(dev);
=20
 	status =3D BT_HCI_ERR_SUCCESS;
 	cmd_complete(dev, BT_HCI_CMD_LE_CLEAR_ACCEPT_LIST, &status,
@@ -3550,16 +3550,16 @@ static int cmd_wl_clear(struct btdev *dev, const vo=
id *data, uint8_t len)
 	return 0;
 }
=20
-#define WL_ADDR_EQUAL(_wl, _type, _addr) \
-	(_wl->type =3D=3D _type && !bacmp(&_wl->addr, (bdaddr_t *)_addr))
+#define AL_ADDR_EQUAL(_al, _type, _addr) \
+	(_al->type =3D=3D _type && !bacmp(&_al->addr, (bdaddr_t *)_addr))
=20
-static void wl_add(struct btdev_wl *wl, uint8_t type, bdaddr_t *addr)
+static void al_add(struct btdev_al *al, uint8_t type, bdaddr_t *addr)
 {
-	wl->type =3D type;
-	bacpy(&wl->addr, addr);
+	al->type =3D type;
+	bacpy(&al->addr, addr);
 }
=20
-static int cmd_add_wl(struct btdev *dev, const void *data, uint8_t len)
+static int cmd_add_al(struct btdev *dev, const void *data, uint8_t len)
 {
 	const struct bt_hci_cmd_le_add_to_accept_list *cmd =3D data;
 	uint8_t status;
@@ -3567,28 +3567,28 @@ static int cmd_add_wl(struct btdev *dev, const void=
 *data, uint8_t len)
 	int i, pos =3D -1;
=20
 	/* This command shall not be used when:
-	 * =E2=80=A2 any advertising filter policy uses the White List and advert=
ising
+	 * =E2=80=A2 any advertising filter policy uses the Accept List and adver=
tising
 	 * is enabled,
-	 * =E2=80=A2 the scanning filter policy uses the White List and scanning =
is
+	 * =E2=80=A2 the scanning filter policy uses the Accept List and scanning=
 is
 	 * enabled, or
-	 * =E2=80=A2 the initiator filter policy uses the White List and an
+	 * =E2=80=A2 the initiator filter policy uses the Accept List and an
 	 * HCI_LE_Create_Connection or HCI_LE_Extended_Create_Connection
 	 * command is outstanding.
 	 */
-	if (!wl_can_change(dev))
+	if (!al_can_change(dev))
 		return -EPERM;
=20
 	/* Valid range for address type is 0x00 to 0x01 */
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
=20
-	for (i =3D 0; i < WL_SIZE; i++) {
-		struct btdev_wl *wl =3D &dev->le_wl[i];
+	for (i =3D 0; i < AL_SIZE; i++) {
+		struct btdev_al *al =3D &dev->le_al[i];
=20
-		if (WL_ADDR_EQUAL(wl, cmd->addr_type, &cmd->addr)) {
+		if (AL_ADDR_EQUAL(al, cmd->addr_type, &cmd->addr)) {
 			exists =3D true;
 			break;
-		} else if (pos < 0 && wl->type =3D=3D 0xff)
+		} else if (pos < 0 && al->type =3D=3D 0xff)
 			pos =3D i;
 	}
=20
@@ -3601,7 +3601,7 @@ static int cmd_add_wl(struct btdev *dev, const void *=
data, uint8_t len)
 		return 0;
 	}
=20
-	wl_add(&dev->le_wl[pos], cmd->addr_type, (bdaddr_t *)&cmd->addr);
+	al_add(&dev->le_al[pos], cmd->addr_type, (bdaddr_t *)&cmd->addr);
=20
 	status =3D BT_HCI_ERR_SUCCESS;
 	cmd_complete(dev, BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST,
@@ -3610,7 +3610,7 @@ static int cmd_add_wl(struct btdev *dev, const void *=
data, uint8_t len)
 	return 0;
 }
=20
-static int cmd_remove_wl(struct btdev *dev, const void *data, uint8_t len)
+static int cmd_remove_al(struct btdev *dev, const void *data, uint8_t len)
 {
 	const struct bt_hci_cmd_le_remove_from_accept_list *cmd =3D data;
 	uint8_t status;
@@ -3618,37 +3618,37 @@ static int cmd_remove_wl(struct btdev *dev, const v=
oid *data, uint8_t len)
 	char addr[18];
=20
 	/* This command shall not be used when:
-	 * =E2=80=A2 any advertising filter policy uses the White List and advert=
ising
+	 * =E2=80=A2 any advertising filter policy uses the Accept List and adver=
tising
 	 * is enabled,
-	 * =E2=80=A2 the scanning filter policy uses the White List and scanning =
is
+	 * =E2=80=A2 the scanning filter policy uses the Accept List and scanning=
 is
 	 * enabled, or
-	 * =E2=80=A2 the initiator filter policy uses the White List and an
+	 * =E2=80=A2 the initiator filter policy uses the Accept List and an
 	 * HCI_LE_Create_Connection or HCI_LE_Extended_Create_Connection
 	 * command is outstanding.
 	 */
-	if (!wl_can_change(dev))
+	if (!al_can_change(dev))
 		return -EPERM;
=20
 	/* Valid range for address type is 0x00 to 0x01 */
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
=20
-	for (i =3D 0; i < WL_SIZE; i++) {
-		struct btdev_wl *wl =3D &dev->le_wl[i];
+	for (i =3D 0; i < AL_SIZE; i++) {
+		struct btdev_al *al =3D &dev->le_al[i];
=20
-		ba2str(&wl->addr, addr);
+		ba2str(&al->addr, addr);
=20
 		util_debug(dev->debug_callback, dev->debug_data,
-				"type 0x%02x addr %s", dev->le_wl[i].type,
+				"type 0x%02x addr %s", dev->le_al[i].type,
 				addr);
=20
-		if (WL_ADDR_EQUAL(wl, cmd->addr_type, &cmd->addr)) {
-			wl_reset(wl);
+		if (AL_ADDR_EQUAL(al, cmd->addr_type, &cmd->addr)) {
+			al_reset(al);
 			break;
 		}
 	}
=20
-	if (i =3D=3D WL_SIZE)
+	if (i =3D=3D AL_SIZE)
 		return -EINVAL;
=20
 	status =3D BT_HCI_ERR_SUCCESS;
@@ -4237,10 +4237,10 @@ static int cmd_gen_dhkey(struct btdev *dev, const v=
oid *data, uint8_t len)
 					cmd_set_scan_enable_complete), \
 	CMD(BT_HCI_CMD_LE_CREATE_CONN, cmd_le_create_conn, \
 					cmd_le_create_conn_complete), \
-	CMD(BT_HCI_CMD_LE_READ_ACCEPT_LIST_SIZE, cmd_read_wl_size, NULL), \
-	CMD(BT_HCI_CMD_LE_CLEAR_ACCEPT_LIST, cmd_wl_clear, NULL), \
-	CMD(BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST, cmd_add_wl, NULL), \
-	CMD(BT_HCI_CMD_LE_REMOVE_FROM_ACCEPT_LIST, cmd_remove_wl, NULL), \
+	CMD(BT_HCI_CMD_LE_READ_ACCEPT_LIST_SIZE, cmd_read_al_size, NULL), \
+	CMD(BT_HCI_CMD_LE_CLEAR_ACCEPT_LIST, cmd_al_clear, NULL), \
+	CMD(BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST, cmd_add_al, NULL), \
+	CMD(BT_HCI_CMD_LE_REMOVE_FROM_ACCEPT_LIST, cmd_remove_al, NULL), \
 	CMD(BT_HCI_CMD_LE_CONN_UPDATE, cmd_conn_update, \
 					cmd_conn_update_complete), \
 	CMD(BT_HCI_CMD_LE_READ_REMOTE_FEATURES, cmd_le_read_remote_features, \
@@ -5759,10 +5759,10 @@ static void set_le_commands(struct btdev *btdev)
 	btdev->commands[26] |=3D 0x04;	/* LE Set Scan Parameters */
 	btdev->commands[26] |=3D 0x08;	/* LE Set Scan Enable */
 	btdev->commands[26] |=3D 0x10;	/* LE Create Connection */
-	btdev->commands[26] |=3D 0x40;	/* LE Read White List Size */
-	btdev->commands[26] |=3D 0x80;	/* LE Clear White List */
-	btdev->commands[27] |=3D 0x01;	/* LE Add Device to White List */
-	btdev->commands[27] |=3D 0x02;	/* LE Remove Device from White List */
+	btdev->commands[26] |=3D 0x40;	/* LE Read Accept List Size */
+	btdev->commands[26] |=3D 0x80;	/* LE Clear Accept List */
+	btdev->commands[27] |=3D 0x01;	/* LE Add Device to Accept List */
+	btdev->commands[27] |=3D 0x02;	/* LE Remove Device from Accept List */
 	btdev->commands[27] |=3D 0x04;	/* LE Connection Update */
 	btdev->commands[27] |=3D 0x20;	/* LE Read Remote Used Features */
 	btdev->commands[27] |=3D 0x40;	/* LE Encrypt */
@@ -6070,7 +6070,7 @@ static void set_le_states(struct btdev *btdev)
 	btdev->le_states[4] =3D 0xff;
 	btdev->le_states[5] =3D 0x03;
=20
-	wl_clear(btdev);
+	al_clear(btdev);
 	rl_clear(btdev);
 	btdev->le_rl_enable =3D 0x00;
 	btdev->le_rl_timeout =3D 0x0384;	/* 900 secs or 15 minutes */
diff --git a/emulator/le.c b/emulator/le.c
index 31186ce1a1..0735b81e6e 100644
--- a/emulator/le.c
+++ b/emulator/le.c
@@ -34,7 +34,7 @@
 #include "phy.h"
 #include "le.h"
=20
-#define WHITE_LIST_SIZE		16
+#define ACCEPT_LIST_SIZE	16
 #define RESOLV_LIST_SIZE	16
 #define SCAN_CACHE_SIZE		64
=20
@@ -102,8 +102,8 @@ struct bt_le {
 	uint8_t  le_conn_own_addr_type;
 	uint8_t  le_conn_enable;
=20
-	uint8_t  le_white_list_size;
-	uint8_t  le_white_list[WHITE_LIST_SIZE][7];
+	uint8_t  le_accept_list_size;
+	uint8_t  le_accept_list[ACCEPT_LIST_SIZE][7];
 	uint8_t  le_states[8];
=20
 	uint16_t le_default_tx_len;
@@ -122,27 +122,27 @@ struct bt_le {
 	uint8_t scan_cache_count;
 };
=20
-static bool is_in_white_list(struct bt_le *hci, uint8_t addr_type,
+static bool is_in_accept_list(struct bt_le *hci, uint8_t addr_type,
 							const uint8_t addr[6])
 {
 	int i;
=20
-	for (i =3D 0; i < hci->le_white_list_size; i++) {
-		if (hci->le_white_list[i][0] =3D=3D addr_type &&
-				!memcmp(&hci->le_white_list[i][1], addr, 6))
+	for (i =3D 0; i < hci->le_accept_list_size; i++) {
+		if (hci->le_accept_list[i][0] =3D=3D addr_type &&
+				!memcmp(&hci->le_accept_list[i][1], addr, 6))
 			return true;
 	}
=20
 	return false;
 }
=20
-static void clear_white_list(struct bt_le *hci)
+static void clear_accept_list(struct bt_le *hci)
 {
 	int i;
=20
-	for (i =3D 0; i < hci->le_white_list_size; i++) {
-		hci->le_white_list[i][0] =3D 0xff;
-		memset(&hci->le_white_list[i][1], 0, 6);
+	for (i =3D 0; i < hci->le_accept_list_size; i++) {
+		hci->le_accept_list[i][0] =3D 0xff;
+		memset(&hci->le_accept_list[i][1], 0, 6);
 	}
 }
=20
@@ -243,10 +243,10 @@ static void reset_defaults(struct bt_le *hci)
 	hci->commands[26] |=3D 0x08;	/* LE Set Scan Enable */
 	hci->commands[26] |=3D 0x10;	/* LE Create Connection */
 	hci->commands[26] |=3D 0x20;	/* LE Create Connection Cancel */
-	hci->commands[26] |=3D 0x40;	/* LE Read White List Size */
-	hci->commands[26] |=3D 0x80;	/* LE Clear White List */
-	hci->commands[27] |=3D 0x01;	/* LE Add Device To White List */
-	hci->commands[27] |=3D 0x02;	/* LE Remove Device From White List */
+	hci->commands[26] |=3D 0x40;	/* LE Read Accept List Size */
+	hci->commands[26] |=3D 0x80;	/* LE Clear Accept List */
+	hci->commands[27] |=3D 0x01;	/* LE Add Device To Accept List */
+	hci->commands[27] |=3D 0x02;	/* LE Remove Device From Accept List */
 	//hci->commands[27] |=3D 0x04;	/* LE Connection Update */
 	//hci->commands[27] |=3D 0x08;	/* LE Set Host Channel Classification */
 	//hci->commands[27] |=3D 0x10;	/* LE Read Channel Map */
@@ -389,8 +389,8 @@ static void reset_defaults(struct bt_le *hci)
=20
 	hci->le_conn_enable =3D 0x00;
=20
-	hci->le_white_list_size =3D WHITE_LIST_SIZE;
-	clear_white_list(hci);
+	hci->le_accept_list_size =3D ACCEPT_LIST_SIZE;
+	clear_accept_list(hci);
=20
 	memset(hci->le_states, 0, sizeof(hci->le_states));
 	hci->le_states[0] |=3D 0x01;	/* Non-connectable Advertising */
@@ -1208,31 +1208,31 @@ static void cmd_le_create_conn_cancel(struct bt_le =
*hci,
 							&evt, sizeof(evt));
 }
=20
-static void cmd_le_read_white_list_size(struct bt_le *hci,
+static void cmd_le_read_accept_list_size(struct bt_le *hci,
 						const void *data, uint8_t size)
 {
 	struct bt_hci_rsp_le_read_accept_list_size rsp;
=20
 	rsp.status =3D BT_HCI_ERR_SUCCESS;
-	rsp.size =3D hci->le_white_list_size;
+	rsp.size =3D hci->le_accept_list_size;
=20
 	cmd_complete(hci, BT_HCI_CMD_LE_READ_ACCEPT_LIST_SIZE,
 							&rsp, sizeof(rsp));
 }
=20
-static void cmd_le_clear_white_list(struct bt_le *hci,
+static void cmd_le_clear_accept_list(struct bt_le *hci,
 						const void *data, uint8_t size)
 {
 	uint8_t status;
=20
-	clear_white_list(hci);
+	clear_accept_list(hci);
=20
 	status =3D BT_HCI_ERR_SUCCESS;
 	cmd_complete(hci, BT_HCI_CMD_LE_CLEAR_ACCEPT_LIST,
 						&status, sizeof(status));
 }
=20
-static void cmd_le_add_to_white_list(struct bt_le *hci,
+static void cmd_le_add_to_accept_list(struct bt_le *hci,
 						const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_add_to_accept_list *cmd =3D data;
@@ -1247,13 +1247,13 @@ static void cmd_le_add_to_white_list(struct bt_le *=
hci,
 		return;
 	}
=20
-	for (i =3D 0; i < hci->le_white_list_size; i++) {
-		if (hci->le_white_list[i][0] =3D=3D cmd->addr_type &&
-				!memcmp(&hci->le_white_list[i][1],
+	for (i =3D 0; i < hci->le_accept_list_size; i++) {
+		if (hci->le_accept_list[i][0] =3D=3D cmd->addr_type &&
+				!memcmp(&hci->le_accept_list[i][1],
 							cmd->addr, 6)) {
 			exists =3D true;
 			break;
-		} else if (pos < 0 && hci->le_white_list[i][0] =3D=3D 0xff)
+		} else if (pos < 0 && hci->le_accept_list[i][0] =3D=3D 0xff)
 			pos =3D i;
 	}
=20
@@ -1269,15 +1269,15 @@ static void cmd_le_add_to_white_list(struct bt_le *=
hci,
 		return;
 	}
=20
-	hci->le_white_list[pos][0] =3D cmd->addr_type;
-	memcpy(&hci->le_white_list[pos][1], cmd->addr, 6);
+	hci->le_accept_list[pos][0] =3D cmd->addr_type;
+	memcpy(&hci->le_accept_list[pos][1], cmd->addr, 6);
=20
 	status =3D BT_HCI_ERR_SUCCESS;
 	cmd_complete(hci, BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST,
 						&status, sizeof(status));
 }
=20
-static void cmd_le_remove_from_white_list(struct bt_le *hci,
+static void cmd_le_remove_from_accept_list(struct bt_le *hci,
 						const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_remove_from_accept_list *cmd =3D data;
@@ -1291,9 +1291,9 @@ static void cmd_le_remove_from_white_list(struct bt_l=
e *hci,
 		return;
 	}
=20
-	for (i =3D 0; i < hci->le_white_list_size; i++) {
-		if (hci->le_white_list[i][0] =3D=3D cmd->addr_type &&
-				!memcmp(&hci->le_white_list[i][1],
+	for (i =3D 0; i < hci->le_accept_list_size; i++) {
+		if (hci->le_accept_list[i][0] =3D=3D cmd->addr_type &&
+				!memcmp(&hci->le_accept_list[i][1],
 							cmd->addr, 6)) {
 			pos =3D i;
 			break;
@@ -1306,8 +1306,8 @@ static void cmd_le_remove_from_white_list(struct bt_l=
e *hci,
 		return;
 	}
=20
-	hci->le_white_list[pos][0] =3D 0xff;
-	memset(&hci->le_white_list[pos][1], 0, 6);
+	hci->le_accept_list[pos][0] =3D 0xff;
+	memset(&hci->le_accept_list[pos][1], 0, 6);
=20
 	status =3D BT_HCI_ERR_SUCCESS;
 	cmd_complete(hci, BT_HCI_CMD_LE_REMOVE_FROM_ACCEPT_LIST,
@@ -1831,13 +1831,13 @@ static const struct {
 	{ BT_HCI_CMD_LE_CREATE_CONN_CANCEL,
 				cmd_le_create_conn_cancel, 0, true },
 	{ BT_HCI_CMD_LE_READ_ACCEPT_LIST_SIZE,
-				cmd_le_read_white_list_size, 0, true },
+				cmd_le_read_accept_list_size, 0, true },
 	{ BT_HCI_CMD_LE_CLEAR_ACCEPT_LIST,
-				cmd_le_clear_white_list, 0, true },
+				cmd_le_clear_accept_list, 0, true },
 	{ BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST,
-				cmd_le_add_to_white_list,  7, true },
+				cmd_le_add_to_accept_list,  7, true },
 	{ BT_HCI_CMD_LE_REMOVE_FROM_ACCEPT_LIST,
-				cmd_le_remove_from_white_list, 7, true },
+				cmd_le_remove_from_accept_list, 7, true },
=20
 	{ BT_HCI_CMD_LE_ENCRYPT, cmd_le_encrypt, 32, true },
 	{ BT_HCI_CMD_LE_RAND, cmd_le_rand, 0, true },
@@ -1963,7 +1963,7 @@ static void phy_recv_callback(uint16_t type, const vo=
id *data,
=20
 			if (hci->le_scan_filter_policy =3D=3D 0x01 ||
 					hci->le_scan_filter_policy =3D=3D 0x03) {
-				if (!is_in_white_list(hci, tx_addr_type,
+				if (!is_in_accept_list(hci, tx_addr_type,
 								tx_addr))
 					break;
 			}
--=20
2.33.0.rc1.237.g0d66db33f3-goog

