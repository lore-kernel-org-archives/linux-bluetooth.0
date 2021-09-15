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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98030C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 08:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 809DC60F23
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 08:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbhIOIeE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236746AbhIOIeD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 04:34:03 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D1EC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 01:32:44 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id b15-20020a05622a020f00b0029e28300d94so1824849qtx.16
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 01:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Tjlo+b9Kh/fDU5KlqdgCXwyLPTHVhXn7bLqazEvJHQQ=;
        b=bsmyx6x51agbeBUhp+CSp8miqpcS5HGhVeJMucff9htftQOmjI9p9Ize/02RCK9uj4
         Qif9Qv2j/nk4AnHaaR+KI07XRUbbk90lTORYDsg3add/5Zt6z9n7zdQ9rDd+hPGav8cz
         8OUAHYEg4DrEwNeLNfYLTh52ZKGEvkBslNSEFdLYp8EcjNC+qQjdQEz2/WpJDZZeaWkY
         +6FqCLN3J7re2HpsOq+KzPS9ftbbPR9KxqTETFWfWrfB0mXQuaqIgagaRvz6A9BikNHd
         q5tYVNcbsPElnAPfS+puBb+t8l/HsyMbbtaO3xTzNdgx3AIwAcQeYKDDFz9NcGNTIrpE
         wh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Tjlo+b9Kh/fDU5KlqdgCXwyLPTHVhXn7bLqazEvJHQQ=;
        b=LCm8cCpxvqIuSzwIv/HJIzdRBnAN12TeHoomj2pKfgqkjBxXvs7bUi+JPHqpF2D/Ie
         nmAJHlZ82aIgbWDeJvD5pN/dBXY36O/Pi12sW/0DPGJsyCzr6vNrMML1t1CGSJzztoSw
         jBMSVnHNKvMSMQn6oL3atzOsevzphTDdFFQh0ggM4TqKKgUKYvbUTV7hfa5sbcJaA1g/
         7+itpjkIx6VIQPoWLI8QrtHpI4hrYlyrCR6VG3to63dg96kkBGrrWenneU+FaX2uRiS+
         Q5vAvuvTz7HGROsaZHZQDEWL+bL0sHxg6cicjHxQlFvtIYnsYRJ4CTb7DKBE/3rQVIEM
         ODKw==
X-Gm-Message-State: AOAM532LTf44BoMnHV/DCLciOXrz0o6AlSbcIAzNKHqmayTXV3et+HNx
        si+9rgErwqTqBgfjtqdSuUqSaGptkoHR0+0BPgA/cdw6BS9o40KAoVx4iwMfxZhVjMWVd1d4oKp
        OTyEdux7NzRKZtp7ABllDnXwPXaxK2Vf7JSqOifvnKzmKIZZ3lFlpdSFxjr3Eqbyxnt64TRujdi
        4J
X-Google-Smtp-Source: ABdhPJzfIZtL2nbMO2BPeXnQOMFANWw2d+inRIpHCr5V5/CGRLhRsT1riUsw+B/oeFju63O+qiGLBzjIu9vO
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:3c6b:8053:7e45:276b])
 (user=apusaka job=sendgmr) by 2002:ad4:4a8b:: with SMTP id
 h11mr9807044qvx.3.1631694763912; Wed, 15 Sep 2021 01:32:43 -0700 (PDT)
Date:   Wed, 15 Sep 2021 16:31:58 +0800
In-Reply-To: <20210915083207.243957-1-apusaka@google.com>
Message-Id: <20210915162843.Bluez.v5.4.Idde74d908204ede645812e49623e367d27c50e58@changeid>
Mime-Version: 1.0
References: <20210915083207.243957-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [Bluez PATCH v5 04/13] emulator: Inclusive language changes
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

BT core spec 5.3 promotes the usage of inclusive languages.
This CL replaces some terms with the more appropriate counterparts,
such as "central", "peripheral", and "accept list".
---

(no changes since v4)

Changes in v4:
* Fix line over 80 columns

Changes in v2:
* Merging several patches from the same directory into one

 android/tester-main.c |   2 +-
 emulator/btdev.c      | 154 +++++++++++++++++++++---------------------
 emulator/hciemu.c     |  21 +++---
 emulator/hciemu.h     |  12 ++--
 emulator/le.c         |  84 +++++++++++------------
 emulator/serial.c     |   6 +-
 tools/l2cap-tester.c  |  16 ++---
 tools/mgmt-tester.c   |  20 +++---
 tools/rfcomm-tester.c |   4 +-
 tools/sco-tester.c    |   2 +-
 tools/smp-tester.c    |   6 +-
 11 files changed, 164 insertions(+), 163 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index 2bfa770bb5..ff5ecdf834 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -2786,7 +2786,7 @@ void emu_remote_connect_hci_action(void)
 	struct step *step =3D g_new0(struct step, 1);
 	const uint8_t *master_addr;
=20
-	master_addr =3D hciemu_get_master_bdaddr(data->hciemu);
+	master_addr =3D hciemu_get_central_bdaddr(data->hciemu);
=20
 	tester_print("Trying to connect hci");
=20
diff --git a/emulator/btdev.c b/emulator/btdev.c
index 343c065760..148e32b7d0 100644
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
@@ -191,7 +191,7 @@ struct btdev {
 	} __attribute__ ((packed)) le_cig;
 	uint8_t  le_iso_path[2];
=20
-	struct btdev_wl le_wl[WL_SIZE];
+	struct btdev_al le_al[AL_SIZE];
 	struct btdev_rl le_rl[RL_SIZE];
 	uint8_t  le_rl_enable;
 	uint16_t le_rl_timeout;
@@ -445,18 +445,18 @@ static int cmd_set_event_mask(struct btdev *dev, cons=
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
@@ -484,7 +484,7 @@ static void btdev_reset(struct btdev *btdev)
 	btdev->le_scan_enable		=3D 0x00;
 	btdev->le_adv_enable		=3D 0x00;
=20
-	wl_clear(btdev);
+	al_clear(btdev);
 	rl_clear(btdev);
 }
=20
@@ -3566,25 +3566,25 @@ static int cmd_le_create_conn_complete(struct btdev=
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
@@ -3601,23 +3601,23 @@ static bool wl_can_change(struct btdev *dev)
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
-	 * is enabled,
-	 * =E2=80=A2 the scanning filter policy uses the White List and scanning =
is
+	 * =E2=80=A2 any advertising filter policy uses the Accept List and
+	 * advertising is enabled,
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
@@ -3626,16 +3626,16 @@ static int cmd_wl_clear(struct btdev *dev, const vo=
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
@@ -3643,28 +3643,28 @@ static int cmd_add_wl(struct btdev *dev, const void=
 *data, uint8_t len)
 	int i, pos =3D -1;
=20
 	/* This command shall not be used when:
-	 * =E2=80=A2 any advertising filter policy uses the White List and advert=
ising
-	 * is enabled,
-	 * =E2=80=A2 the scanning filter policy uses the White List and scanning =
is
+	 * =E2=80=A2 any advertising filter policy uses the Accept List and
+	 * advertising is enabled,
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
@@ -3677,7 +3677,7 @@ static int cmd_add_wl(struct btdev *dev, const void *=
data, uint8_t len)
 		return 0;
 	}
=20
-	wl_add(&dev->le_wl[pos], cmd->addr_type, (bdaddr_t *)&cmd->addr);
+	al_add(&dev->le_al[pos], cmd->addr_type, (bdaddr_t *)&cmd->addr);
=20
 	status =3D BT_HCI_ERR_SUCCESS;
 	cmd_complete(dev, BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST,
@@ -3686,7 +3686,7 @@ static int cmd_add_wl(struct btdev *dev, const void *=
data, uint8_t len)
 	return 0;
 }
=20
-static int cmd_remove_wl(struct btdev *dev, const void *data, uint8_t len)
+static int cmd_remove_al(struct btdev *dev, const void *data, uint8_t len)
 {
 	const struct bt_hci_cmd_le_remove_from_accept_list *cmd =3D data;
 	uint8_t status;
@@ -3694,37 +3694,37 @@ static int cmd_remove_wl(struct btdev *dev, const v=
oid *data, uint8_t len)
 	char addr[18];
=20
 	/* This command shall not be used when:
-	 * =E2=80=A2 any advertising filter policy uses the White List and advert=
ising
-	 * is enabled,
-	 * =E2=80=A2 the scanning filter policy uses the White List and scanning =
is
+	 * =E2=80=A2 any advertising filter policy uses the Accept List and
+	 * advertising is enabled,
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
@@ -4313,10 +4313,10 @@ static int cmd_gen_dhkey(struct btdev *dev, const v=
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
@@ -5887,10 +5887,10 @@ static void set_le_commands(struct btdev *btdev)
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
@@ -6077,13 +6077,13 @@ static void set_bredrle_features(struct btdev *btde=
v)
 	btdev->features[2] |=3D 0x08;	/* Transparent SCO */
 	btdev->features[3] |=3D 0x40;	/* RSSI with inquiry results */
 	btdev->features[3] |=3D 0x80;	/* Extended SCO link */
-	btdev->features[4] |=3D 0x08;	/* AFH capable slave */
-	btdev->features[4] |=3D 0x10;	/* AFH classification slave */
+	btdev->features[4] |=3D 0x08;	/* AFH capable peripheral */
+	btdev->features[4] |=3D 0x10;	/* AFH classification peripheral */
 	btdev->features[4] |=3D 0x40;	/* LE Supported */
 	btdev->features[5] |=3D 0x02;	/* Sniff subrating */
 	btdev->features[5] |=3D 0x04;	/* Pause encryption */
-	btdev->features[5] |=3D 0x08;	/* AFH capable master */
-	btdev->features[5] |=3D 0x10;	/* AFH classification master */
+	btdev->features[5] |=3D 0x08;	/* AFH capable central */
+	btdev->features[5] |=3D 0x10;	/* AFH classification central */
 	btdev->features[6] |=3D 0x01;	/* Extended Inquiry Response */
 	btdev->features[6] |=3D 0x02;	/* Simultaneous LE and BR/EDR */
 	btdev->features[6] |=3D 0x08;	/* Secure Simple Pairing */
@@ -6113,15 +6113,15 @@ static void set_bredrle_features(struct btdev *btde=
v)
=20
 	if (btdev->type >=3D BTDEV_TYPE_BREDRLE52) {
 		btdev->le_features[1] |=3D 0x20;  /* LE PER ADV */
-		btdev->le_features[3] |=3D 0x10;  /* LE CIS Master */
-		btdev->le_features[3] |=3D 0x20;  /* LE CIS Slave */
+		btdev->le_features[3] |=3D 0x10;  /* LE CIS Central */
+		btdev->le_features[3] |=3D 0x20;  /* LE CIS Peripheral */
 		btdev->le_features[3] |=3D 0x40;  /* LE ISO Broadcaster */
 		btdev->le_features[3] |=3D 0x80;  /* LE Synchronized Receiver */
 		btdev->le_features[4] |=3D 0x01;  /* LE ISO channels */
 	}
=20
-	btdev->feat_page_2[0] |=3D 0x01;	/* CSB - Master Operation */
-	btdev->feat_page_2[0] |=3D 0x02;	/* CSB - Slave Operation */
+	btdev->feat_page_2[0] |=3D 0x01;	/* CPB - Central Operation */
+	btdev->feat_page_2[0] |=3D 0x02;	/* CPB - Peripheral Operation */
 	btdev->feat_page_2[0] |=3D 0x04;	/* Synchronization Train */
 	btdev->feat_page_2[0] |=3D 0x08;	/* Synchronization Scan */
 	btdev->feat_page_2[0] |=3D 0x10;	/* Inquiry Response Notification */
@@ -6139,12 +6139,12 @@ static void set_bredr_features(struct btdev *btdev)
 	btdev->features[1] |=3D 0x08;	/* SCO link */
 	btdev->features[3] |=3D 0x40;	/* RSSI with inquiry results */
 	btdev->features[3] |=3D 0x80;	/* Extended SCO link */
-	btdev->features[4] |=3D 0x08;	/* AFH capable slave */
-	btdev->features[4] |=3D 0x10;	/* AFH classification slave */
+	btdev->features[4] |=3D 0x08;	/* AFH capable peripheral */
+	btdev->features[4] |=3D 0x10;	/* AFH classification peripheral */
 	btdev->features[5] |=3D 0x02;	/* Sniff subrating */
 	btdev->features[5] |=3D 0x04;	/* Pause encryption */
-	btdev->features[5] |=3D 0x08;	/* AFH capable master */
-	btdev->features[5] |=3D 0x10;	/* AFH classification master */
+	btdev->features[5] |=3D 0x08;	/* AFH capable central */
+	btdev->features[5] |=3D 0x10;	/* AFH classification central */
 	btdev->features[6] |=3D 0x01;	/* Extended Inquiry Response */
 	btdev->features[6] |=3D 0x08;	/* Secure Simple Pairing */
 	btdev->features[6] |=3D 0x10;	/* Encapsulated PDU */
@@ -6165,12 +6165,12 @@ static void set_bredr20_features(struct btdev *btde=
v)
 	btdev->features[1] |=3D 0x08;	/* SCO link */
 	btdev->features[3] |=3D 0x40;	/* RSSI with inquiry results */
 	btdev->features[3] |=3D 0x80;	/* Extended SCO link */
-	btdev->features[4] |=3D 0x08;	/* AFH capable slave */
-	btdev->features[4] |=3D 0x10;	/* AFH classification slave */
+	btdev->features[4] |=3D 0x08;	/* AFH capable peripheral */
+	btdev->features[4] |=3D 0x10;	/* AFH classification peripheral */
 	btdev->features[5] |=3D 0x02;	/* Sniff subrating */
 	btdev->features[5] |=3D 0x04;	/* Pause encryption */
-	btdev->features[5] |=3D 0x08;	/* AFH capable master */
-	btdev->features[5] |=3D 0x10;	/* AFH classification master */
+	btdev->features[5] |=3D 0x08;	/* AFH capable central */
+	btdev->features[5] |=3D 0x10;	/* AFH classification central */
 	btdev->features[7] |=3D 0x80;	/* Extended features */
=20
 	btdev->max_page =3D 1;
@@ -6185,7 +6185,7 @@ static void set_le_features(struct btdev *btdev)
=20
 	btdev->le_features[0] |=3D 0x01;	/* LE Encryption */
 	btdev->le_features[0] |=3D 0x02;	/* Connection Parameters Request */
-	btdev->le_features[0] |=3D 0x08;	/* Slave-initiated Features Exchange */
+	btdev->le_features[0] |=3D 0x08;	/* Peripheral-initd Features Exchange */
 }
=20
 static void set_le_states(struct btdev *btdev)
@@ -6198,7 +6198,7 @@ static void set_le_states(struct btdev *btdev)
 	btdev->le_states[4] =3D 0xff;
 	btdev->le_states[5] =3D 0x03;
=20
-	wl_clear(btdev);
+	al_clear(btdev);
 	rl_clear(btdev);
 	btdev->le_rl_enable =3D 0x00;
 	btdev->le_rl_timeout =3D 0x0384;	/* 900 secs or 15 minutes */
diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index fe5ef747a2..bd6bf1e631 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -84,7 +84,7 @@ static void run_command_hook(void *data, void *user_data)
 					run_data->len, hook->user_data);
 }
=20
-static void master_command_callback(uint16_t opcode,
+static void central_command_callback(uint16_t opcode,
 				const void *data, uint8_t len,
 				btdev_callback callback, void *user_data)
 {
@@ -230,7 +230,7 @@ static bool create_vhci(struct hciemu *hciemu)
 	if (!btdev)
 		return false;
=20
-	btdev_set_command_handler(btdev, master_command_callback, hciemu);
+	btdev_set_command_handler(btdev, central_command_callback, hciemu);
=20
 	fd =3D open("/dev/vhci", O_RDWR | O_NONBLOCK | O_CLOEXEC);
 	if (fd < 0) {
@@ -462,7 +462,7 @@ static void bthost_print(const char *str, void *user_da=
ta)
 					"bthost: %s", str);
 }
=20
-static void btdev_master_debug(const char *str, void *user_data)
+static void btdev_central_debug(const char *str, void *user_data)
 {
 	struct hciemu *hciemu =3D user_data;
=20
@@ -500,7 +500,7 @@ bool hciemu_set_debug(struct hciemu *hciemu, hciemu_deb=
ug_func_t callback,
 	hciemu->debug_destroy =3D destroy;
 	hciemu->debug_data =3D user_data;
=20
-	btdev_set_debug(hciemu->dev, btdev_master_debug, hciemu, NULL);
+	btdev_set_debug(hciemu->dev, btdev_central_debug, hciemu, NULL);
=20
 	queue_foreach(hciemu->clients, hciemu_client_set_debug, hciemu);
=20
@@ -528,7 +528,7 @@ uint8_t *hciemu_get_features(struct hciemu *hciemu)
 	return btdev_get_features(hciemu->dev);
 }
=20
-const uint8_t *hciemu_get_master_bdaddr(struct hciemu *hciemu)
+const uint8_t *hciemu_get_central_bdaddr(struct hciemu *hciemu)
 {
 	if (!hciemu || !hciemu->dev)
 		return NULL;
@@ -556,7 +556,7 @@ const uint8_t *hciemu_get_client_bdaddr(struct hciemu *=
hciemu)
 	return hciemu_client_bdaddr(client);
 }
=20
-uint8_t hciemu_get_master_scan_enable(struct hciemu *hciemu)
+uint8_t hciemu_get_central_scan_enable(struct hciemu *hciemu)
 {
 	if (!hciemu || !hciemu->dev)
 		return 0;
@@ -564,7 +564,7 @@ uint8_t hciemu_get_master_scan_enable(struct hciemu *hc=
iemu)
 	return btdev_get_scan_enable(hciemu->dev);
 }
=20
-uint8_t hciemu_get_master_le_scan_enable(struct hciemu *hciemu)
+uint8_t hciemu_get_central_le_scan_enable(struct hciemu *hciemu)
 {
 	if (!hciemu || !hciemu->dev)
 		return 0;
@@ -572,7 +572,8 @@ uint8_t hciemu_get_master_le_scan_enable(struct hciemu =
*hciemu)
 	return btdev_get_le_scan_enable(hciemu->dev);
 }
=20
-void hciemu_set_master_le_states(struct hciemu *hciemu, const uint8_t *le_=
states)
+void hciemu_set_central_le_states(struct hciemu *hciemu,
+						const uint8_t *le_states)
 {
 	if (!hciemu || !hciemu->dev)
 		return;
@@ -580,7 +581,7 @@ void hciemu_set_master_le_states(struct hciemu *hciemu,=
 const uint8_t *le_states
 	btdev_set_le_states(hciemu->dev, le_states);
 }
=20
-bool hciemu_add_master_post_command_hook(struct hciemu *hciemu,
+bool hciemu_add_central_post_command_hook(struct hciemu *hciemu,
 			hciemu_command_func_t function, void *user_data)
 {
 	struct hciemu_command_hook *hook;
@@ -603,7 +604,7 @@ bool hciemu_add_master_post_command_hook(struct hciemu =
*hciemu,
 	return true;
 }
=20
-bool hciemu_clear_master_post_command_hooks(struct hciemu *hciemu)
+bool hciemu_clear_central_post_command_hooks(struct hciemu *hciemu)
 {
 	if (!hciemu)
 		return false;
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index 8bf2d070ea..3d3d93b4b0 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -50,14 +50,14 @@ struct bthost *hciemu_client_get_host(struct hciemu *hc=
iemu);
 const char *hciemu_get_address(struct hciemu *hciemu);
 uint8_t *hciemu_get_features(struct hciemu *hciemu);
=20
-const uint8_t *hciemu_get_master_bdaddr(struct hciemu *hciemu);
+const uint8_t *hciemu_get_central_bdaddr(struct hciemu *hciemu);
 const uint8_t *hciemu_get_client_bdaddr(struct hciemu *hciemu);
=20
-uint8_t hciemu_get_master_scan_enable(struct hciemu *hciemu);
+uint8_t hciemu_get_central_scan_enable(struct hciemu *hciemu);
=20
-uint8_t hciemu_get_master_le_scan_enable(struct hciemu *hciemu);
+uint8_t hciemu_get_central_le_scan_enable(struct hciemu *hciemu);
=20
-void hciemu_set_master_le_states(struct hciemu *hciemu,
+void hciemu_set_central_le_states(struct hciemu *hciemu,
 						const uint8_t *le_states);
=20
 typedef void (*hciemu_command_func_t)(uint16_t opcode, const void *data,
@@ -66,10 +66,10 @@ typedef void (*hciemu_command_func_t)(uint16_t opcode, =
const void *data,
 typedef bool (*hciemu_hook_func_t)(const void *data, uint16_t len,
 							void *user_data);
=20
-bool hciemu_add_master_post_command_hook(struct hciemu *hciemu,
+bool hciemu_add_central_post_command_hook(struct hciemu *hciemu,
 			hciemu_command_func_t function, void *user_data);
=20
-bool hciemu_clear_master_post_command_hooks(struct hciemu *hciemu);
+bool hciemu_clear_central_post_command_hooks(struct hciemu *hciemu);
=20
 int hciemu_add_hook(struct hciemu *hciemu, enum hciemu_hook_type type,
 				uint16_t opcode, hciemu_hook_func_t function,
diff --git a/emulator/le.c b/emulator/le.c
index 23f2579426..07a44c5f1c 100644
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
@@ -343,7 +343,7 @@ static void reset_defaults(struct bt_le *hci)
 	hci->le_features[0] |=3D 0x01;	/* LE Encryption */
 	//hci->le_features[0] |=3D 0x02;	/* Connection Parameter Request Procedur=
e */
 	//hci->le_features[0] |=3D 0x04;	/* Extended Reject Indication */
-	//hci->le_features[0] |=3D 0x08;	/* Slave-initiated Features Exchange */
+	//hci->le_features[0] |=3D 0x08;	/* Peripheral-initd Features Exchange */
 	hci->le_features[0] |=3D 0x10;	/* LE Ping */
 	hci->le_features[0] |=3D 0x20;	/* LE Data Packet Length Extension */
 	hci->le_features[0] |=3D 0x40;	/* LL Privacy */
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
@@ -399,8 +399,8 @@ static void reset_defaults(struct bt_le *hci)
 	hci->le_states[0] |=3D 0x08;	/* High Duty Cycle Directed Advertising */
 	hci->le_states[0] |=3D 0x10;	/* Passive Scanning */
 	hci->le_states[0] |=3D 0x20;	/* Active Scanning */
-	hci->le_states[0] |=3D 0x40;	/* Initiating + Connection (Master Role) */
-	hci->le_states[0] |=3D 0x80;	/* Connection (Slave Role) */
+	hci->le_states[0] |=3D 0x40;	/* Initiating + Conn (Central Role) */
+	hci->le_states[0] |=3D 0x80;	/* Connection (Peripheral Role) */
 	hci->le_states[1] |=3D 0x01;	/* Passive Scanning +
 					 * Non-connectable Advertising */
=20
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
diff --git a/emulator/serial.c b/emulator/serial.c
index b44af0dcce..c9e6d7cd67 100644
--- a/emulator/serial.c
+++ b/emulator/serial.c
@@ -151,19 +151,19 @@ static void open_pty(struct serial *serial)
=20
 	serial->fd =3D posix_openpt(O_RDWR | O_NOCTTY);
 	if (serial->fd < 0) {
-		perror("Failed to get master pseudo terminal");
+		perror("Failed to get central pseudo terminal");
 		return;
 	}
=20
 	if (grantpt(serial->fd) < 0) {
-		perror("Failed to grant slave pseudo terminal");
+		perror("Failed to grant peripheral pseudo terminal");
 		close(serial->fd);
 		serial->fd =3D -1;
 		return;
 	}
=20
 	if (unlockpt(serial->fd) < 0) {
-		perror("Failed to unlock slave pseudo terminal");
+		perror("Failed to unlock peripheral pseudo terminal");
 		close(serial->fd);
 		serial->fd =3D -1;
 		return;
diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 11d549f22a..169a989f54 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -1116,7 +1116,7 @@ static int create_l2cap_sock(struct test_data *data, =
uint16_t psm,
 		return err;
 	}
=20
-	master_bdaddr =3D hciemu_get_master_bdaddr(data->hciemu);
+	master_bdaddr =3D hciemu_get_central_bdaddr(data->hciemu);
 	if (!master_bdaddr) {
 		tester_warn("No master bdaddr");
 		close(sk);
@@ -1301,7 +1301,7 @@ static void test_connect(const void *test_data)
 	}
=20
 	if (l2data->direct_advertising)
-		hciemu_add_master_post_command_hook(data->hciemu,
+		hciemu_add_central_post_command_hook(data->hciemu,
 						direct_adv_cmd_complete, NULL);
=20
 	sk =3D create_l2cap_sock(data, 0, l2data->cid, l2data->sec_level,
@@ -1419,7 +1419,7 @@ static gboolean test_close_socket_1_part_3(gpointer a=
rg)
 		return FALSE;
 	}
=20
-	if (hciemu_get_master_le_scan_enable(data->hciemu)) {
+	if (hciemu_get_central_le_scan_enable(data->hciemu)) {
 		tester_print("Delayed check whether scann is off failed");
 		tester_test_failed();
 		return FALSE;
@@ -1440,7 +1440,7 @@ static gboolean test_close_socket_1_part_2(gpointer a=
rgs)
 	 * was added to kernel whitelist, and scan was started. We
 	 * should be still scanning.
 	 */
-	if (!hciemu_get_master_le_scan_enable(data->hciemu)) {
+	if (!hciemu_get_central_le_scan_enable(data->hciemu)) {
 		tester_print("Error - should be still scanning");
 		tester_test_failed();
 		return FALSE;
@@ -1467,7 +1467,7 @@ static gboolean test_close_socket_2_part_3(gpointer a=
rg)
 	int err;
=20
 	/* Scan should be already over, we're trying to create connection */
-	if (hciemu_get_master_le_scan_enable(data->hciemu)) {
+	if (hciemu_get_central_le_scan_enable(data->hciemu)) {
 		tester_print("Error - should no longer scan");
 		tester_test_failed();
 		return FALSE;
@@ -1563,7 +1563,7 @@ static void test_close_socket(const void *test_data)
 	const struct l2cap_data *l2data =3D data->test_data;
 	const uint8_t *client_bdaddr;
=20
-	hciemu_add_master_post_command_hook(data->hciemu,
+	hciemu_add_central_post_command_hook(data->hciemu,
 					test_close_socket_router, data);
=20
 	if (l2data->client_bdaddr !=3D NULL)
@@ -1668,7 +1668,7 @@ static void test_connect_2(const void *test_data)
 	test_2_connect_cb_cnt =3D 0;
 	test_scan_enable_counter =3D 0;
=20
-	hciemu_add_master_post_command_hook(data->hciemu,
+	hciemu_add_central_post_command_hook(data->hciemu,
 				test_connect_2_router, data);
=20
 	if (l2data->server_psm) {
@@ -1869,7 +1869,7 @@ static void test_server(const void *test_data)
 		tester_print("Listening for connections");
 	}
=20
-	master_bdaddr =3D hciemu_get_master_bdaddr(data->hciemu);
+	master_bdaddr =3D hciemu_get_central_bdaddr(data->hciemu);
 	if (!master_bdaddr) {
 		tester_warn("No master bdaddr");
 		tester_test_failed();
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index ccc082a488..dc53faf3af 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -365,7 +365,7 @@ static void read_index_list_callback(uint8_t status, ui=
nt16_t length,
 		hciemu_set_debug(data->hciemu, print_debug, "hciemu: ", NULL);
=20
 	if (test && test->setup_le_states)
-		hciemu_set_master_le_states(data->hciemu, test->le_states);
+		hciemu_set_central_le_states(data->hciemu, test->le_states);
 }
=20
 static void test_pre_setup(const void *test_data)
@@ -7136,7 +7136,7 @@ static void command_setup_hci_callback(uint16_t opcod=
e, const void *param,
 		return;
 	}
=20
-	hciemu_clear_master_post_command_hooks(data->hciemu);
+	hciemu_clear_central_post_command_hooks(data->hciemu);
 	test_setup_condition_complete(data);
 }
=20
@@ -7202,7 +7202,7 @@ static void setup_command_generic(const void *test_da=
ta)
 		tester_print("Registering setup expected HCI command callback");
 		tester_print("Setup expected HCI command 0x%04x",
 					 test->setup_expect_hci_command);
-		hciemu_add_master_post_command_hook(data->hciemu,
+		hciemu_add_central_post_command_hook(data->hciemu,
 					command_setup_hci_callback, data);
 		test_add_setup_condition(data);
 	}
@@ -9529,7 +9529,7 @@ static void setup_ll_privacy_device(const void *test_=
data)
=20
 	tester_print("Setup expected HCI command 0x%04x",
 					 test->setup_expect_hci_command);
-	hciemu_add_master_post_command_hook(data->hciemu,
+	hciemu_add_central_post_command_hook(data->hciemu,
 					command_setup_hci_callback, data);
 	test_add_setup_condition(data);
=20
@@ -9686,7 +9686,7 @@ static void test_command_generic(const void *test_dat=
a)
=20
 	if (test->expect_hci_command) {
 		tester_print("Registering HCI command callback");
-		hciemu_add_master_post_command_hook(data->hciemu,
+		hciemu_add_central_post_command_hook(data->hciemu,
 						command_hci_callback, data);
 		test_add_condition(data);
 	}
@@ -9720,13 +9720,13 @@ static void check_scan(void *user_data)
 {
 	struct test_data *data =3D tester_get_data();
=20
-	if (hciemu_get_master_le_scan_enable(data->hciemu)) {
+	if (hciemu_get_central_le_scan_enable(data->hciemu)) {
 		tester_warn("LE scan still enabled");
 		tester_test_failed();
 		return;
 	}
=20
-	if (hciemu_get_master_scan_enable(data->hciemu)) {
+	if (hciemu_get_central_scan_enable(data->hciemu)) {
 		tester_warn("BR/EDR scan still enabled");
 		tester_test_failed();
 		return;
@@ -9817,7 +9817,7 @@ static void test_pairing_acceptor(const void *test_da=
ta)
 		test_add_condition(data);
 	}
=20
-	master_bdaddr =3D hciemu_get_master_bdaddr(data->hciemu);
+	master_bdaddr =3D hciemu_get_central_bdaddr(data->hciemu);
 	if (!master_bdaddr) {
 		tester_warn("No master bdaddr");
 		tester_test_failed();
@@ -9882,7 +9882,7 @@ static void test_command_generic_connect(const void *=
test_data)
 	data->mgmt_alt_ev_id =3D id;
 	test_add_condition(data);
=20
-	master_bdaddr =3D hciemu_get_master_bdaddr(data->hciemu);
+	master_bdaddr =3D hciemu_get_central_bdaddr(data->hciemu);
 	if (!master_bdaddr) {
 		tester_warn("No master bdaddr");
 		tester_test_failed();
@@ -9961,7 +9961,7 @@ static void add_device_callback(uint8_t status, uint1=
6_t len, const void *param,
 	if (test->client_enable_adv)
 		return;
=20
-	master_bdaddr =3D hciemu_get_master_bdaddr(data->hciemu);
+	master_bdaddr =3D hciemu_get_central_bdaddr(data->hciemu);
 	if (!master_bdaddr) {
 		tester_warn("No master bdaddr");
 		tester_test_failed();
diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index 9bae5b9d54..78b08663bd 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -542,7 +542,7 @@ static void test_connect(const void *test_data)
 	bthost_add_rfcomm_server(bthost, cli->server_channel,
 						rfcomm_connect_cb, NULL);
=20
-	master_addr =3D hciemu_get_master_bdaddr(data->hciemu);
+	master_addr =3D hciemu_get_central_bdaddr(data->hciemu);
 	client_addr =3D hciemu_get_client_bdaddr(data->hciemu);
=20
 	sk =3D create_rfcomm_sock((bdaddr_t *) master_addr, 0);
@@ -680,7 +680,7 @@ static void test_server(const void *test_data)
 	GIOChannel *io;
 	int sk;
=20
-	master_addr =3D hciemu_get_master_bdaddr(data->hciemu);
+	master_addr =3D hciemu_get_central_bdaddr(data->hciemu);
=20
 	sk =3D create_rfcomm_sock((bdaddr_t *) master_addr, srv->server_channel);
 	if (sk < 0) {
diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index b341fa49f7..6e7cf6843f 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -530,7 +530,7 @@ static int create_sco_sock(struct test_data *data)
 		return err;
 	}
=20
-	master_bdaddr =3D hciemu_get_master_bdaddr(data->hciemu);
+	master_bdaddr =3D hciemu_get_central_bdaddr(data->hciemu);
 	if (!master_bdaddr) {
 		tester_warn("No master bdaddr");
 		return -ENODEV;
diff --git a/tools/smp-tester.c b/tools/smp-tester.c
index 644c451c29..b075c5df8a 100644
--- a/tools/smp-tester.c
+++ b/tools/smp-tester.c
@@ -767,7 +767,7 @@ static void init_bdaddr(struct test_data *data)
 {
 	const uint8_t *master_bdaddr, *client_bdaddr;
=20
-	master_bdaddr =3D hciemu_get_master_bdaddr(data->hciemu);
+	master_bdaddr =3D hciemu_get_central_bdaddr(data->hciemu);
 	if (!master_bdaddr) {
 		tester_warn("No master bdaddr");
 		tester_test_failed();
@@ -808,7 +808,7 @@ static void test_client(const void *test_data)
=20
 	if (smp->expect_hci_command) {
 		tester_print("Registering HCI command callback");
-		hciemu_add_master_post_command_hook(data->hciemu,
+		hciemu_add_central_post_command_hook(data->hciemu,
 						command_hci_callback, data);
 		test_add_condition(data);
 	}
@@ -889,7 +889,7 @@ static void test_server(const void *test_data)
=20
 	if (smp->expect_hci_command) {
 		tester_print("Registering HCI command callback");
-		hciemu_add_master_post_command_hook(data->hciemu,
+		hciemu_add_central_post_command_hook(data->hciemu,
 						command_hci_callback, data);
 		test_add_condition(data);
 	}
--=20
2.33.0.464.g1972c5931b-goog

