Return-Path: <SRS0=z6V2=3H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CDCC32771
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jan 2020 05:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1001224679
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jan 2020 05:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RPYzG+CS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbgARFEV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 18 Jan 2020 00:04:21 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45467 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgARFEV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 18 Jan 2020 00:04:21 -0500
Received: by mail-vs1-f67.google.com with SMTP id b4so16127388vsa.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2020 21:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EiyCi8K3kQKf1hOAaemGhAnO0h3FXXVu0X/RsnGp7og=;
        b=RPYzG+CS60UIwqNVz/l5uu6sbRbt+lPFN1bEPpHvm1DliPdJoRBtrQfAnMoKnghIPf
         eyzsVcfylEKEnrUvvnTiVws54UC59xlBVF0C9nRNi3aYie6Dn+6lbh4312bZinAwwcw2
         Xj7L7DJYru6p9fBxXuFjVxaK93lG4In/T6+Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EiyCi8K3kQKf1hOAaemGhAnO0h3FXXVu0X/RsnGp7og=;
        b=k9eQbvU4ZOQWLxHLPdh0ww41CcDsL3fIKZxg/2Aji2aeqrWjZQNt3C/VTlVcdthMeU
         KhwQN9DoZdu0NGkz7xrHAa+ep1K2wP8r00srk/PdHhSdzl962M+ImGmqY62WgcyLuXr+
         /wzEc1usiubhDHIIyyUHayjELTgdEW0TNeMRI+tDREOL/UFW0LM3nv7Xx+QoS4H4MVci
         erQD7ELFuDbP3uYocTy164bPtYoybMqCRPRU9hpIF4Q+wyMc5s62Meh+Tw5PisFrtGOl
         YDIKixzWZbJ2UQQ69hrSBqR+FrdpJ+zzbLIjxP1HpN9fyNEMWh7HkSrH24cff14Kqen2
         uQVA==
X-Gm-Message-State: APjAAAWRCIRV6gMzqYAzNyzw/Wg9rwwqQ22VXi0OdoUaslubisMteF8V
        KCU9Gd6erjBLqTduWxMC05wGjMplISM=
X-Google-Smtp-Source: APXvYqzxqr4U2wb2hZIMEC0uevFY72VwgoFtORAK/87S0P5/tv9pjuC7kf31E7uouJGdHJWNcqrjTg==
X-Received: by 2002:a67:dc90:: with SMTP id g16mr6775677vsk.110.1579323859486;
        Fri, 17 Jan 2020 21:04:19 -0800 (PST)
Received: from alain.c.googlers.com.com (69.104.231.35.bc.googleusercontent.com. [35.231.104.69])
        by smtp.gmail.com with ESMTPSA id h67sm7952040vka.25.2020.01.17.21.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 21:04:18 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v2] bluetooth: Refactoring mgmt cmd op_code structure
Date:   Sat, 18 Jan 2020 05:04:10 +0000
Message-Id: <20200118050410.257697-1-alainm@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change refactors the way op-codes are managed in the kernel to
facilitate easier cherry-picking  of features on downlevel kernels
without incuring significant merge conflicts and op_code collisions.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---
Here is a v2 that implements the alternative way that may address your
forward declaration feedback.  I'm open to any of these or any other
suggestions you may have to address this.

 include/net/bluetooth/hci_core.h |   1 +
 net/bluetooth/hci_sock.c         |  14 +-
 net/bluetooth/mgmt.c             | 426 ++++++++++++++-----------------
 3 files changed, 206 insertions(+), 235 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 89ecf0a80aa1..0cc2f7c11c3a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1494,6 +1494,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
 #define HCI_MGMT_UNCONFIGURED	BIT(3)
 
 struct hci_mgmt_handler {
+	unsigned short op_code;
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
 	size_t data_len;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 3ae508674ef7..4e121607d644 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1490,9 +1490,9 @@ static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk,
 	void *buf;
 	u8 *cp;
 	struct mgmt_hdr *hdr;
-	u16 opcode, index, len;
+	u16 opcode, index, len, i;
 	struct hci_dev *hdev = NULL;
-	const struct hci_mgmt_handler *handler;
+	const struct hci_mgmt_handler *handler = NULL;
 	bool var_len, no_hdev;
 	int err;
 
@@ -1533,16 +1533,18 @@ static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk,
 		}
 	}
 
-	if (opcode >= chan->handler_count ||
-	    chan->handlers[opcode].func == NULL) {
+	for (i = 0; i < chan->handler_count; ++i) {
+		if (opcode == chan->handlers[i].op_code)
+			handler = &chan->handlers[i];
+	}
+
+	if (!handler || !handler->func) {
 		BT_DBG("Unknown op %u", opcode);
 		err = mgmt_cmd_status(sk, index, opcode,
 				      MGMT_STATUS_UNKNOWN_COMMAND);
 		goto done;
 	}
 
-	handler = &chan->handlers[opcode];
-
 	if (!hci_sock_test_flag(sk, HCI_SOCK_TRUSTED) &&
 	    !(handler->flags & HCI_MGMT_UNTRUSTED)) {
 		err = mgmt_cmd_status(sk, index, opcode,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0dc610faab70..b0a24395b4bb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -40,75 +40,6 @@
 #define MGMT_VERSION	1
 #define MGMT_REVISION	15
 
-static const u16 mgmt_commands[] = {
-	MGMT_OP_READ_INDEX_LIST,
-	MGMT_OP_READ_INFO,
-	MGMT_OP_SET_POWERED,
-	MGMT_OP_SET_DISCOVERABLE,
-	MGMT_OP_SET_CONNECTABLE,
-	MGMT_OP_SET_FAST_CONNECTABLE,
-	MGMT_OP_SET_BONDABLE,
-	MGMT_OP_SET_LINK_SECURITY,
-	MGMT_OP_SET_SSP,
-	MGMT_OP_SET_HS,
-	MGMT_OP_SET_LE,
-	MGMT_OP_SET_DEV_CLASS,
-	MGMT_OP_SET_LOCAL_NAME,
-	MGMT_OP_ADD_UUID,
-	MGMT_OP_REMOVE_UUID,
-	MGMT_OP_LOAD_LINK_KEYS,
-	MGMT_OP_LOAD_LONG_TERM_KEYS,
-	MGMT_OP_DISCONNECT,
-	MGMT_OP_GET_CONNECTIONS,
-	MGMT_OP_PIN_CODE_REPLY,
-	MGMT_OP_PIN_CODE_NEG_REPLY,
-	MGMT_OP_SET_IO_CAPABILITY,
-	MGMT_OP_PAIR_DEVICE,
-	MGMT_OP_CANCEL_PAIR_DEVICE,
-	MGMT_OP_UNPAIR_DEVICE,
-	MGMT_OP_USER_CONFIRM_REPLY,
-	MGMT_OP_USER_CONFIRM_NEG_REPLY,
-	MGMT_OP_USER_PASSKEY_REPLY,
-	MGMT_OP_USER_PASSKEY_NEG_REPLY,
-	MGMT_OP_READ_LOCAL_OOB_DATA,
-	MGMT_OP_ADD_REMOTE_OOB_DATA,
-	MGMT_OP_REMOVE_REMOTE_OOB_DATA,
-	MGMT_OP_START_DISCOVERY,
-	MGMT_OP_STOP_DISCOVERY,
-	MGMT_OP_CONFIRM_NAME,
-	MGMT_OP_BLOCK_DEVICE,
-	MGMT_OP_UNBLOCK_DEVICE,
-	MGMT_OP_SET_DEVICE_ID,
-	MGMT_OP_SET_ADVERTISING,
-	MGMT_OP_SET_BREDR,
-	MGMT_OP_SET_STATIC_ADDRESS,
-	MGMT_OP_SET_SCAN_PARAMS,
-	MGMT_OP_SET_SECURE_CONN,
-	MGMT_OP_SET_DEBUG_KEYS,
-	MGMT_OP_SET_PRIVACY,
-	MGMT_OP_LOAD_IRKS,
-	MGMT_OP_GET_CONN_INFO,
-	MGMT_OP_GET_CLOCK_INFO,
-	MGMT_OP_ADD_DEVICE,
-	MGMT_OP_REMOVE_DEVICE,
-	MGMT_OP_LOAD_CONN_PARAM,
-	MGMT_OP_READ_UNCONF_INDEX_LIST,
-	MGMT_OP_READ_CONFIG_INFO,
-	MGMT_OP_SET_EXTERNAL_CONFIG,
-	MGMT_OP_SET_PUBLIC_ADDRESS,
-	MGMT_OP_START_SERVICE_DISCOVERY,
-	MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
-	MGMT_OP_READ_EXT_INDEX_LIST,
-	MGMT_OP_READ_ADV_FEATURES,
-	MGMT_OP_ADD_ADVERTISING,
-	MGMT_OP_REMOVE_ADVERTISING,
-	MGMT_OP_GET_ADV_SIZE_INFO,
-	MGMT_OP_START_LIMITED_DISCOVERY,
-	MGMT_OP_READ_EXT_INFO,
-	MGMT_OP_SET_APPEARANCE,
-	MGMT_OP_SET_BLOCKED_KEYS,
-};
-
 static const u16 mgmt_events[] = {
 	MGMT_EV_CONTROLLER_ERROR,
 	MGMT_EV_INDEX_ADDED,
@@ -147,15 +78,6 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_EXT_INFO_CHANGED,
 };
 
-static const u16 mgmt_untrusted_commands[] = {
-	MGMT_OP_READ_INDEX_LIST,
-	MGMT_OP_READ_INFO,
-	MGMT_OP_READ_UNCONF_INDEX_LIST,
-	MGMT_OP_READ_CONFIG_INFO,
-	MGMT_OP_READ_EXT_INDEX_LIST,
-	MGMT_OP_READ_EXT_INFO,
-};
-
 static const u16 mgmt_untrusted_events[] = {
 	MGMT_EV_INDEX_ADDED,
 	MGMT_EV_INDEX_REMOVED,
@@ -176,7 +98,7 @@ static const u16 mgmt_untrusted_events[] = {
 		 "\x00\x00\x00\x00\x00\x00\x00\x00"
 
 /* HCI to MGMT error code conversion table */
-static u8 mgmt_status_table[] = {
+static const u8 mgmt_status_table[] = {
 	MGMT_STATUS_SUCCESS,
 	MGMT_STATUS_UNKNOWN_COMMAND,	/* Unknown Command */
 	MGMT_STATUS_NOT_CONNECTED,	/* No Connection */
@@ -298,58 +220,6 @@ static int read_version(struct sock *sk, struct hci_dev *hdev, void *data,
 				 &rp, sizeof(rp));
 }
 
-static int read_commands(struct sock *sk, struct hci_dev *hdev, void *data,
-			 u16 data_len)
-{
-	struct mgmt_rp_read_commands *rp;
-	u16 num_commands, num_events;
-	size_t rp_size;
-	int i, err;
-
-	BT_DBG("sock %p", sk);
-
-	if (hci_sock_test_flag(sk, HCI_SOCK_TRUSTED)) {
-		num_commands = ARRAY_SIZE(mgmt_commands);
-		num_events = ARRAY_SIZE(mgmt_events);
-	} else {
-		num_commands = ARRAY_SIZE(mgmt_untrusted_commands);
-		num_events = ARRAY_SIZE(mgmt_untrusted_events);
-	}
-
-	rp_size = sizeof(*rp) + ((num_commands + num_events) * sizeof(u16));
-
-	rp = kmalloc(rp_size, GFP_KERNEL);
-	if (!rp)
-		return -ENOMEM;
-
-	rp->num_commands = cpu_to_le16(num_commands);
-	rp->num_events = cpu_to_le16(num_events);
-
-	if (hci_sock_test_flag(sk, HCI_SOCK_TRUSTED)) {
-		__le16 *opcode = rp->opcodes;
-
-		for (i = 0; i < num_commands; i++, opcode++)
-			put_unaligned_le16(mgmt_commands[i], opcode);
-
-		for (i = 0; i < num_events; i++, opcode++)
-			put_unaligned_le16(mgmt_events[i], opcode);
-	} else {
-		__le16 *opcode = rp->opcodes;
-
-		for (i = 0; i < num_commands; i++, opcode++)
-			put_unaligned_le16(mgmt_untrusted_commands[i], opcode);
-
-		for (i = 0; i < num_events; i++, opcode++)
-			put_unaligned_le16(mgmt_untrusted_events[i], opcode);
-	}
-
-	err = mgmt_cmd_complete(sk, MGMT_INDEX_NONE, MGMT_OP_READ_COMMANDS, 0,
-				rp, rp_size);
-	kfree(rp);
-
-	return err;
-}
-
 static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 			   u16 data_len)
 {
@@ -6894,104 +6764,6 @@ static int get_adv_size_info(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
-static const struct hci_mgmt_handler mgmt_handlers[] = {
-	{ NULL }, /* 0x0000 (no command) */
-	{ read_version,            MGMT_READ_VERSION_SIZE,
-						HCI_MGMT_NO_HDEV |
-						HCI_MGMT_UNTRUSTED },
-	{ read_commands,           MGMT_READ_COMMANDS_SIZE,
-						HCI_MGMT_NO_HDEV |
-						HCI_MGMT_UNTRUSTED },
-	{ read_index_list,         MGMT_READ_INDEX_LIST_SIZE,
-						HCI_MGMT_NO_HDEV |
-						HCI_MGMT_UNTRUSTED },
-	{ read_controller_info,    MGMT_READ_INFO_SIZE,
-						HCI_MGMT_UNTRUSTED },
-	{ set_powered,             MGMT_SETTING_SIZE },
-	{ set_discoverable,        MGMT_SET_DISCOVERABLE_SIZE },
-	{ set_connectable,         MGMT_SETTING_SIZE },
-	{ set_fast_connectable,    MGMT_SETTING_SIZE },
-	{ set_bondable,            MGMT_SETTING_SIZE },
-	{ set_link_security,       MGMT_SETTING_SIZE },
-	{ set_ssp,                 MGMT_SETTING_SIZE },
-	{ set_hs,                  MGMT_SETTING_SIZE },
-	{ set_le,                  MGMT_SETTING_SIZE },
-	{ set_dev_class,           MGMT_SET_DEV_CLASS_SIZE },
-	{ set_local_name,          MGMT_SET_LOCAL_NAME_SIZE },
-	{ add_uuid,                MGMT_ADD_UUID_SIZE },
-	{ remove_uuid,             MGMT_REMOVE_UUID_SIZE },
-	{ load_link_keys,          MGMT_LOAD_LINK_KEYS_SIZE,
-						HCI_MGMT_VAR_LEN },
-	{ load_long_term_keys,     MGMT_LOAD_LONG_TERM_KEYS_SIZE,
-						HCI_MGMT_VAR_LEN },
-	{ disconnect,              MGMT_DISCONNECT_SIZE },
-	{ get_connections,         MGMT_GET_CONNECTIONS_SIZE },
-	{ pin_code_reply,          MGMT_PIN_CODE_REPLY_SIZE },
-	{ pin_code_neg_reply,      MGMT_PIN_CODE_NEG_REPLY_SIZE },
-	{ set_io_capability,       MGMT_SET_IO_CAPABILITY_SIZE },
-	{ pair_device,             MGMT_PAIR_DEVICE_SIZE },
-	{ cancel_pair_device,      MGMT_CANCEL_PAIR_DEVICE_SIZE },
-	{ unpair_device,           MGMT_UNPAIR_DEVICE_SIZE },
-	{ user_confirm_reply,      MGMT_USER_CONFIRM_REPLY_SIZE },
-	{ user_confirm_neg_reply,  MGMT_USER_CONFIRM_NEG_REPLY_SIZE },
-	{ user_passkey_reply,      MGMT_USER_PASSKEY_REPLY_SIZE },
-	{ user_passkey_neg_reply,  MGMT_USER_PASSKEY_NEG_REPLY_SIZE },
-	{ read_local_oob_data,     MGMT_READ_LOCAL_OOB_DATA_SIZE },
-	{ add_remote_oob_data,     MGMT_ADD_REMOTE_OOB_DATA_SIZE,
-						HCI_MGMT_VAR_LEN },
-	{ remove_remote_oob_data,  MGMT_REMOVE_REMOTE_OOB_DATA_SIZE },
-	{ start_discovery,         MGMT_START_DISCOVERY_SIZE },
-	{ stop_discovery,          MGMT_STOP_DISCOVERY_SIZE },
-	{ confirm_name,            MGMT_CONFIRM_NAME_SIZE },
-	{ block_device,            MGMT_BLOCK_DEVICE_SIZE },
-	{ unblock_device,          MGMT_UNBLOCK_DEVICE_SIZE },
-	{ set_device_id,           MGMT_SET_DEVICE_ID_SIZE },
-	{ set_advertising,         MGMT_SETTING_SIZE },
-	{ set_bredr,               MGMT_SETTING_SIZE },
-	{ set_static_address,      MGMT_SET_STATIC_ADDRESS_SIZE },
-	{ set_scan_params,         MGMT_SET_SCAN_PARAMS_SIZE },
-	{ set_secure_conn,         MGMT_SETTING_SIZE },
-	{ set_debug_keys,          MGMT_SETTING_SIZE },
-	{ set_privacy,             MGMT_SET_PRIVACY_SIZE },
-	{ load_irks,               MGMT_LOAD_IRKS_SIZE,
-						HCI_MGMT_VAR_LEN },
-	{ get_conn_info,           MGMT_GET_CONN_INFO_SIZE },
-	{ get_clock_info,          MGMT_GET_CLOCK_INFO_SIZE },
-	{ add_device,              MGMT_ADD_DEVICE_SIZE },
-	{ remove_device,           MGMT_REMOVE_DEVICE_SIZE },
-	{ load_conn_param,         MGMT_LOAD_CONN_PARAM_SIZE,
-						HCI_MGMT_VAR_LEN },
-	{ read_unconf_index_list,  MGMT_READ_UNCONF_INDEX_LIST_SIZE,
-						HCI_MGMT_NO_HDEV |
-						HCI_MGMT_UNTRUSTED },
-	{ read_config_info,        MGMT_READ_CONFIG_INFO_SIZE,
-						HCI_MGMT_UNCONFIGURED |
-						HCI_MGMT_UNTRUSTED },
-	{ set_external_config,     MGMT_SET_EXTERNAL_CONFIG_SIZE,
-						HCI_MGMT_UNCONFIGURED },
-	{ set_public_address,      MGMT_SET_PUBLIC_ADDRESS_SIZE,
-						HCI_MGMT_UNCONFIGURED },
-	{ start_service_discovery, MGMT_START_SERVICE_DISCOVERY_SIZE,
-						HCI_MGMT_VAR_LEN },
-	{ read_local_oob_ext_data, MGMT_READ_LOCAL_OOB_EXT_DATA_SIZE },
-	{ read_ext_index_list,     MGMT_READ_EXT_INDEX_LIST_SIZE,
-						HCI_MGMT_NO_HDEV |
-						HCI_MGMT_UNTRUSTED },
-	{ read_adv_features,       MGMT_READ_ADV_FEATURES_SIZE },
-	{ add_advertising,	   MGMT_ADD_ADVERTISING_SIZE,
-						HCI_MGMT_VAR_LEN },
-	{ remove_advertising,	   MGMT_REMOVE_ADVERTISING_SIZE },
-	{ get_adv_size_info,       MGMT_GET_ADV_SIZE_INFO_SIZE },
-	{ start_limited_discovery, MGMT_START_DISCOVERY_SIZE },
-	{ read_ext_controller_info,MGMT_READ_EXT_INFO_SIZE,
-						HCI_MGMT_UNTRUSTED },
-	{ set_appearance,	   MGMT_SET_APPEARANCE_SIZE },
-	{ get_phy_configuration,   MGMT_GET_PHY_CONFIGURATION_SIZE },
-	{ set_phy_configuration,   MGMT_SET_PHY_CONFIGURATION_SIZE },
-	{ set_blocked_keys,	   MGMT_OP_SET_BLOCKED_KEYS_SIZE,
-						HCI_MGMT_VAR_LEN },
-};
-
 void mgmt_index_added(struct hci_dev *hdev)
 {
 	struct mgmt_ev_ext_index ev;
@@ -8012,6 +7784,202 @@ void mgmt_discovering(struct hci_dev *hdev, u8 discovering)
 	mgmt_event(MGMT_EV_DISCOVERING, hdev, &ev, sizeof(ev), NULL);
 }
 
+static int read_commands(struct sock *sk, struct hci_dev *hdev, void *data,
+			 u16 data_len);
+
+static const struct hci_mgmt_handler mgmt_handlers[] = {
+	{ 0x0000, NULL },
+	{ MGMT_OP_READ_VERSION, read_version, MGMT_READ_VERSION_SIZE,
+						HCI_MGMT_NO_HDEV |
+						HCI_MGMT_UNTRUSTED },
+	{ MGMT_OP_READ_COMMANDS, read_commands, MGMT_READ_COMMANDS_SIZE,
+						HCI_MGMT_NO_HDEV |
+						HCI_MGMT_UNTRUSTED },
+	{ MGMT_OP_READ_INDEX_LIST, read_index_list, MGMT_READ_INDEX_LIST_SIZE,
+						HCI_MGMT_NO_HDEV |
+						HCI_MGMT_UNTRUSTED },
+	{ MGMT_OP_READ_INFO, read_controller_info, MGMT_READ_INFO_SIZE,
+						HCI_MGMT_UNTRUSTED },
+	{ MGMT_OP_SET_POWERED, set_powered, MGMT_SETTING_SIZE },
+	{ MGMT_OP_SET_DISCOVERABLE, set_discoverable,
+						MGMT_SET_DISCOVERABLE_SIZE },
+	{ MGMT_OP_SET_CONNECTABLE, set_connectable, MGMT_SETTING_SIZE },
+	{ MGMT_OP_SET_FAST_CONNECTABLE, set_fast_connectable,
+							MGMT_SETTING_SIZE },
+	{ MGMT_OP_SET_BONDABLE, set_bondable, MGMT_SETTING_SIZE },
+	{ MGMT_OP_SET_LINK_SECURITY, set_link_security, MGMT_SETTING_SIZE },
+	{ MGMT_OP_SET_SSP, set_ssp, MGMT_SETTING_SIZE },
+	{ MGMT_OP_SET_HS, set_hs, MGMT_SETTING_SIZE },
+	{ MGMT_OP_SET_LE, set_le, MGMT_SETTING_SIZE },
+	{ MGMT_OP_SET_DEV_CLASS, set_dev_class, MGMT_SET_DEV_CLASS_SIZE },
+	{ MGMT_OP_SET_LOCAL_NAME, set_local_name, MGMT_SET_LOCAL_NAME_SIZE },
+	{ MGMT_OP_ADD_UUID, add_uuid, MGMT_ADD_UUID_SIZE },
+	{ MGMT_OP_REMOVE_UUID, remove_uuid, MGMT_REMOVE_UUID_SIZE },
+	{ MGMT_OP_LOAD_LINK_KEYS, load_link_keys, MGMT_LOAD_LINK_KEYS_SIZE,
+							HCI_MGMT_VAR_LEN },
+	{ MGMT_OP_LOAD_LONG_TERM_KEYS, load_long_term_keys,
+						MGMT_LOAD_LONG_TERM_KEYS_SIZE,
+						HCI_MGMT_VAR_LEN },
+	{ MGMT_OP_DISCONNECT, disconnect, MGMT_DISCONNECT_SIZE },
+	{ MGMT_OP_GET_CONNECTIONS, get_connections, MGMT_GET_CONNECTIONS_SIZE },
+	{ MGMT_OP_PIN_CODE_REPLY, pin_code_reply, MGMT_PIN_CODE_REPLY_SIZE },
+	{ MGMT_OP_PIN_CODE_NEG_REPLY, pin_code_neg_reply,
+						MGMT_PIN_CODE_NEG_REPLY_SIZE },
+	{ MGMT_OP_SET_IO_CAPABILITY, set_io_capability,
+						MGMT_SET_IO_CAPABILITY_SIZE },
+	{ MGMT_OP_PAIR_DEVICE, pair_device, MGMT_PAIR_DEVICE_SIZE },
+	{ MGMT_OP_CANCEL_PAIR_DEVICE, cancel_pair_device,
+						MGMT_CANCEL_PAIR_DEVICE_SIZE },
+	{ MGMT_OP_UNPAIR_DEVICE, unpair_device, MGMT_UNPAIR_DEVICE_SIZE },
+	{ MGMT_OP_USER_CONFIRM_REPLY, user_confirm_reply,
+						MGMT_USER_CONFIRM_REPLY_SIZE },
+	{ MGMT_OP_USER_CONFIRM_NEG_REPLY, user_confirm_neg_reply,
+					MGMT_USER_CONFIRM_NEG_REPLY_SIZE },
+	{ MGMT_OP_USER_PASSKEY_REPLY, user_passkey_reply,
+						MGMT_USER_PASSKEY_REPLY_SIZE },
+	{ MGMT_OP_USER_PASSKEY_NEG_REPLY, user_passkey_neg_reply,
+					MGMT_USER_PASSKEY_NEG_REPLY_SIZE },
+	{ MGMT_OP_READ_LOCAL_OOB_DATA, read_local_oob_data,
+						MGMT_READ_LOCAL_OOB_DATA_SIZE },
+	{ MGMT_OP_ADD_REMOTE_OOB_DATA, add_remote_oob_data,
+						MGMT_ADD_REMOTE_OOB_DATA_SIZE,
+						HCI_MGMT_VAR_LEN },
+	{ MGMT_OP_REMOVE_REMOTE_OOB_DATA, remove_remote_oob_data,
+					MGMT_REMOVE_REMOTE_OOB_DATA_SIZE },
+	{ MGMT_OP_START_DISCOVERY, start_discovery, MGMT_START_DISCOVERY_SIZE },
+	{ MGMT_OP_STOP_DISCOVERY, stop_discovery, MGMT_STOP_DISCOVERY_SIZE },
+	{ MGMT_OP_CONFIRM_NAME, confirm_name, MGMT_CONFIRM_NAME_SIZE },
+	{ MGMT_OP_BLOCK_DEVICE, block_device, MGMT_BLOCK_DEVICE_SIZE },
+	{ MGMT_OP_UNBLOCK_DEVICE, unblock_device, MGMT_UNBLOCK_DEVICE_SIZE },
+	{ MGMT_OP_SET_DEVICE_ID, set_device_id, MGMT_SET_DEVICE_ID_SIZE },
+	{ MGMT_OP_SET_ADVERTISING, set_advertising, MGMT_SETTING_SIZE },
+	{ MGMT_OP_SET_BREDR, set_bredr, MGMT_SETTING_SIZE },
+	{ MGMT_OP_SET_STATIC_ADDRESS, set_static_address,
+						MGMT_SET_STATIC_ADDRESS_SIZE },
+	{ MGMT_OP_SET_SCAN_PARAMS, set_scan_params, MGMT_SET_SCAN_PARAMS_SIZE },
+	{ MGMT_OP_SET_SECURE_CONN, set_secure_conn, MGMT_SETTING_SIZE },
+	{ MGMT_OP_SET_DEBUG_KEYS, set_debug_keys, MGMT_SETTING_SIZE },
+	{ MGMT_OP_SET_PRIVACY, set_privacy, MGMT_SET_PRIVACY_SIZE },
+	{ MGMT_OP_LOAD_IRKS, load_irks, MGMT_LOAD_IRKS_SIZE, HCI_MGMT_VAR_LEN },
+	{ MGMT_OP_GET_CONN_INFO, get_conn_info, MGMT_GET_CONN_INFO_SIZE },
+	{ MGMT_OP_GET_CLOCK_INFO, get_clock_info, MGMT_GET_CLOCK_INFO_SIZE },
+	{ MGMT_OP_ADD_DEVICE, add_device, MGMT_ADD_DEVICE_SIZE },
+	{ MGMT_OP_REMOVE_DEVICE, remove_device, MGMT_REMOVE_DEVICE_SIZE },
+	{ MGMT_OP_LOAD_CONN_PARAM, load_conn_param, MGMT_LOAD_CONN_PARAM_SIZE,
+						HCI_MGMT_VAR_LEN },
+	{ MGMT_OP_READ_UNCONF_INDEX_LIST, read_unconf_index_list,
+					MGMT_READ_UNCONF_INDEX_LIST_SIZE,
+					HCI_MGMT_NO_HDEV |
+					HCI_MGMT_UNTRUSTED },
+	{ MGMT_OP_READ_CONFIG_INFO, read_config_info,
+						MGMT_READ_CONFIG_INFO_SIZE,
+						HCI_MGMT_UNCONFIGURED |
+						HCI_MGMT_UNTRUSTED },
+	{ MGMT_OP_SET_EXTERNAL_CONFIG, set_external_config,
+						MGMT_SET_EXTERNAL_CONFIG_SIZE,
+						HCI_MGMT_UNCONFIGURED },
+	{ MGMT_OP_SET_PUBLIC_ADDRESS, set_public_address,
+						MGMT_SET_PUBLIC_ADDRESS_SIZE,
+						HCI_MGMT_UNCONFIGURED },
+	{ MGMT_OP_START_SERVICE_DISCOVERY, start_service_discovery,
+					MGMT_START_SERVICE_DISCOVERY_SIZE,
+					HCI_MGMT_VAR_LEN },
+	{ MGMT_OP_READ_LOCAL_OOB_EXT_DATA, read_local_oob_ext_data,
+					MGMT_READ_LOCAL_OOB_EXT_DATA_SIZE },
+	{ MGMT_OP_READ_EXT_INDEX_LIST, read_ext_index_list,
+						MGMT_READ_EXT_INDEX_LIST_SIZE,
+						HCI_MGMT_NO_HDEV |
+						HCI_MGMT_UNTRUSTED },
+	{ MGMT_OP_READ_ADV_FEATURES, read_adv_features,
+						MGMT_READ_ADV_FEATURES_SIZE },
+	{ MGMT_OP_ADD_ADVERTISING, add_advertising, MGMT_ADD_ADVERTISING_SIZE,
+						HCI_MGMT_VAR_LEN },
+	{ MGMT_OP_REMOVE_ADVERTISING, remove_advertising,
+						MGMT_REMOVE_ADVERTISING_SIZE },
+	{ MGMT_OP_GET_ADV_SIZE_INFO, get_adv_size_info,
+						MGMT_GET_ADV_SIZE_INFO_SIZE },
+	{ MGMT_OP_START_LIMITED_DISCOVERY, start_limited_discovery,
+						MGMT_START_DISCOVERY_SIZE },
+	{ MGMT_OP_READ_EXT_INFO, read_ext_controller_info,
+							MGMT_READ_EXT_INFO_SIZE,
+							HCI_MGMT_UNTRUSTED },
+	{ MGMT_OP_SET_APPEARANCE, set_appearance, MGMT_SET_APPEARANCE_SIZE },
+	{ MGMT_OP_GET_PHY_CONFIGURATION, get_phy_configuration,
+					MGMT_GET_PHY_CONFIGURATION_SIZE },
+	{ MGMT_OP_SET_PHY_CONFIGURATION, set_phy_configuration,
+					MGMT_SET_PHY_CONFIGURATION_SIZE },
+	{ MGMT_OP_SET_BLOCKED_KEYS, set_blocked_keys,
+					MGMT_OP_SET_BLOCKED_KEYS_SIZE,
+					HCI_MGMT_VAR_LEN },
+};
+
+static int read_commands(struct sock *sk, struct hci_dev *hdev, void *data,
+			 u16 data_len)
+{
+	struct mgmt_rp_read_commands *rp;
+	u16 num_commands = 0, num_events;
+	size_t rp_size;
+	int i, err;
+
+	BT_DBG("sock %p", sk);
+
+	if (hci_sock_test_flag(sk, HCI_SOCK_TRUSTED)) {
+		for (i = 0; i < ARRAY_SIZE(mgmt_handlers); ++i) {
+			if ((mgmt_handlers[i].flags &
+						HCI_MGMT_UNTRUSTED) == 0)
+				++num_commands;
+		}
+
+		num_events = ARRAY_SIZE(mgmt_events);
+	} else {
+		for (i = 0; i < ARRAY_SIZE(mgmt_handlers); ++i) {
+			if (mgmt_handlers[i].flags & HCI_MGMT_UNTRUSTED)
+				++num_commands;
+		}
+
+		num_events = ARRAY_SIZE(mgmt_untrusted_events);
+	}
+
+	rp_size = sizeof(*rp) + ((num_commands + num_events) * sizeof(u16));
+
+	rp = kmalloc(rp_size, GFP_KERNEL);
+	if (!rp)
+		return -ENOMEM;
+
+	rp->num_commands = cpu_to_le16(num_commands);
+	rp->num_events = cpu_to_le16(num_events);
+
+	if (hci_sock_test_flag(sk, HCI_SOCK_TRUSTED)) {
+		__le16 *opcode = rp->opcodes;
+
+		for (i = 0; i < ARRAY_SIZE(mgmt_handlers); ++i, ++opcode) {
+			if ((mgmt_handlers[i].flags & HCI_MGMT_UNTRUSTED) == 0)
+				put_unaligned_le16(mgmt_handlers[i].op_code,
+						   opcode);
+		}
+
+		for (i = 0; i < num_events; i++, opcode++)
+			put_unaligned_le16(mgmt_events[i], opcode);
+	} else {
+		__le16 *opcode = rp->opcodes;
+
+		for (i = 0; i < ARRAY_SIZE(mgmt_handlers); ++i, ++opcode) {
+			if (mgmt_handlers[i].flags & HCI_MGMT_UNTRUSTED)
+				put_unaligned_le16(mgmt_handlers[i].op_code,
+						   opcode);
+		}
+
+		for (i = 0; i < num_events; i++, opcode++)
+			put_unaligned_le16(mgmt_untrusted_events[i], opcode);
+	}
+
+	err = mgmt_cmd_complete(sk, MGMT_INDEX_NONE, MGMT_OP_READ_COMMANDS, 0,
+				rp, rp_size);
+	kfree(rp);
+
+	return err;
+}
+
 static struct hci_mgmt_chan chan = {
 	.channel	= HCI_CHANNEL_CONTROL,
 	.handler_count	= ARRAY_SIZE(mgmt_handlers),
-- 
2.25.0.341.g760bfbb309-goog

