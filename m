Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB38350D52
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049515; cv=none; b=S5VktCFwh+onGW+AH3SGO2ZJHr9AhNY/MTnNh1+PB1Gu71UxhLezyA/GhJpPi1x3AdTNWk24kXvFYWG6BfTC+nPBb1Si8YsWlZ7iL8bNOR6lG0guwjxPtyGkeRpm049tBMrDaSB1+SLLKZVJWhqhpOTEgh1iAIa+iWSNWqlvBzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049515; c=relaxed/simple;
	bh=sWlqNSCjGT8l7KEHom/Ta84XMONnEaEFcYVcbzvDvew=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FX/d9iGFOfIaIehLS/cZPR4hfd2D0WZYVMDK9tCvqi7NYtVHNwVASeDYzAsVRKV8XgcXQlleWCs3T14DSLiIkIFdMUM/qccqwxK9a7WJ2yuGl5HmAo8zL9i1a8FrS7xBFZcy/D686/yV76mCT5JaIUMfACF1hBLU47gIYibXZRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsbEcWDg; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsbEcWDg"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5de0c1fa660so319485137.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 07:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763049512; x=1763654312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MbQBzBUM9EX1N+DIBIdnB1VwH8dPXEL4HekXtg6L7uw=;
        b=OsbEcWDgZfDPNEWfoj5KITqFn75prnovVo+d6t7rMV5poghfJfoN7Avapee4627Ls9
         qySOtusV2HLxqPuiCkk6jsWnFmQ7KwZ50lf1ViQ4xAWnbnQh0lBj71ociu3VgSacdffA
         L/399RtbVYjGQ+8NxTF1AqxVmUoslQBae8r0V/GlmK8EhOewn2fo2zFwBsbQc3AF4Fhf
         WQ67Wdq1ZZGNNozt1ucScnHKTMFq7kgflIat+GcS7ksVcduG2kyk2mgGD6xDlY7EwwBq
         wOkTUhhNRFGeVUWqHPDHHb99Si19cReyvQN6ge0LFiP+NF2dbFXipXRjhbL2X+GuZp4d
         TGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763049512; x=1763654312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MbQBzBUM9EX1N+DIBIdnB1VwH8dPXEL4HekXtg6L7uw=;
        b=KLcBBWQ9uRWz5cfJ/O5iAJwcvlBie8T95q2WGdgVpr5XHTmVP4Jo7MkJEaC+F4jo8e
         n2WG2in5l7sIk7fC19iZrMlZ+7wx5z4pizfFYMhl7n/KGOpN2NoI5Ykqo3gPj9jrXJPd
         O9R28hwXC+KBcLO+E/M9Rp3gpCkbNco4I4An7wWebfG3nUNJUycYkBjIzYZY6DhVapPw
         TtS73fTCRg+Q3B7VY/hxDDtP9j31ocMZ5T7hhwXwF7haPNE20874QgiJoVJAcgIwXPrK
         B+BI87KhDwYnSpOZ4/QZJC4QTNpe0+YbPP1d9JJYZgz6bZxtRXwkS7bH3OuHIFA7dxnc
         SDmw==
X-Gm-Message-State: AOJu0YxTAlaEttjnNUe+/shrNwCw6QknHcA7mRuJhrO/JxGrof4Q/UUf
	Rng7NAKqOrr648CLfPh530hDToKfZHXRQftjI+p9XUzcwIUtQ8kiqySkUuKJGQ==
X-Gm-Gg: ASbGncvrhIz3zgvMG6UFcl+iyCRsiHgeOBRjXH7G+qtstSTlZ56iB3kx1bEezSeb7Je
	Cr+uZdwuxUjPQ1aAKWRUg9eHnvxwUGJhujfuzErVxpju1x6TBp9rZJSObGq9a1vdPGOI6PPhtm5
	6Z+glHhkmKneyIX1hx8jRjkQ9GRuSv08R7QJHj9pjLjD9iO+Shahs3LEx+ddIgjhPD98ttsPcA7
	r2ZJPk6KQ7cV+Lgx4OXPci9ksFjZZlEVzs7wnwYoLJjxeNtiPXYuMhgvYsJ/HztKf91eeP+esI5
	Gcp7zpK6NE/r6snYh94bRXyAiPp3WTCgo00B6dIKtNzk2dfKxAIaT4GidMcinuHHWvlIwpSSRSw
	6zYOVS6tUKaYNyC2yhIVlxhrUElYT8IArZAy+MoCJLh1FjTwjZZQ5B5h/TkSHSjQYJTyPiP8t+X
	8ZdB0yqpmvEnNpKcs/e06nPjO7
X-Google-Smtp-Source: AGHT+IHReYSivzhByJDJFk4e8aaQKgUnSRp+ZLvLN03QSicj09cAgXAWWwkjCmsuJTsBjtl/5/5CQw==
X-Received: by 2002:a05:6102:3909:b0:5db:e909:aa0d with SMTP id ada2fe7eead31-5dfc5b6f76dmr33659137.37.1763049512045;
        Thu, 13 Nov 2025 07:58:32 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9376111e98dsm704023241.7.2025.11.13.07.58.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 07:58:30 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] btdev: Fix set_bredrle_commands
Date: Thu, 13 Nov 2025 10:58:18 -0500
Message-ID: <20251113155818.2628720-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113155818.2628720-1-luiz.dentz@gmail.com>
References: <20251113155818.2628720-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes set_bredrle_commands which was overriding the list of
commands previously set, so instead of setting the extra command
after the command list of the specific version this is now merged
together with each version that requires the extra commands.
---
 emulator/btdev.c | 258 +++++++++++++++++++++++++----------------------
 1 file changed, 136 insertions(+), 122 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 5632a822240a..7019037c7989 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -3267,6 +3267,103 @@ static int cmd_get_mws_transport_config(struct btdev *dev, const void *data,
 	CMD(BT_HCI_CMD_ENHANCED_SETUP_SYNC_CONN, cmd_enhanced_setup_sync_conn, \
 					cmd_enhanced_setup_sync_conn_complete)
 
+static int cmd_set_event_mask_2(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_set_event_mask_page2 *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	memcpy(dev->event_mask_page2, cmd->mask, 8);
+	cmd_complete(dev, BT_HCI_CMD_SET_EVENT_MASK_PAGE2, &status,
+						sizeof(status));
+
+	return 0;
+}
+
+static int cmd_read_sync_train_params(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct bt_hci_rsp_read_sync_train_params rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.interval = cpu_to_le16(dev->sync_train_interval);
+	rsp.timeout = cpu_to_le32(dev->sync_train_timeout);
+	rsp.service_data = dev->sync_train_service_data;
+	cmd_complete(dev, BT_HCI_CMD_READ_SYNC_TRAIN_PARAMS, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_read_sc_support(struct btdev *dev, const void *data, uint8_t len)
+{
+	struct bt_hci_rsp_read_secure_conn_support rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.support = dev->secure_conn_support;
+	cmd_complete(dev, BT_HCI_CMD_READ_SECURE_CONN_SUPPORT, &rsp,
+							sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_write_sc_support(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_write_secure_conn_support *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	dev->secure_conn_support = cmd->support;
+	cmd_complete(dev, BT_HCI_CMD_WRITE_SECURE_CONN_SUPPORT, &status,
+							sizeof(status));
+
+	return 0;
+}
+
+static int cmd_read_auth_payload_timeout(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	/* TODO */
+	return -ENOTSUP;
+}
+
+static int cmd_write_auth_payload_timeout(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	/* TODO */
+	return -ENOTSUP;
+}
+
+static int cmd_read_local_oob_ext_data(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct bt_hci_rsp_read_local_oob_ext_data rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	cmd_complete(dev, BT_HCI_CMD_READ_LOCAL_OOB_EXT_DATA, &rsp,
+							sizeof(rsp));
+
+	return 0;
+}
+
+#define CMD_COMMON_BREDR_LE_40 \
+	CMD(BT_HCI_CMD_SET_EVENT_MASK_PAGE2, cmd_set_event_mask_2, NULL), \
+	CMD(BT_HCI_CMD_READ_SYNC_TRAIN_PARAMS, cmd_read_sync_train_params, \
+					NULL), \
+	CMD(BT_HCI_CMD_READ_SECURE_CONN_SUPPORT, cmd_read_sc_support, NULL), \
+	CMD(BT_HCI_CMD_WRITE_SECURE_CONN_SUPPORT, cmd_write_sc_support, NULL), \
+	CMD(BT_HCI_CMD_READ_AUTH_PAYLOAD_TIMEOUT, \
+					cmd_read_auth_payload_timeout, NULL), \
+	CMD(BT_HCI_CMD_WRITE_AUTH_PAYLOAD_TIMEOUT, \
+					cmd_write_auth_payload_timeout, NULL), \
+	CMD(BT_HCI_CMD_READ_LOCAL_OOB_EXT_DATA, \
+					cmd_read_local_oob_ext_data, NULL)
+
 static const struct btdev_cmd cmd_bredr[] = {
 	CMD_COMMON_ALL,
 	CMD_COMMON_BREDR_LE,
@@ -4732,6 +4829,31 @@ static int cmd_gen_dhkey(struct btdev *dev, const void *data, uint8_t len)
 	CMD(BT_HCI_CMD_LE_SET_RESOLV_ENABLE, cmd_set_rl_enable, NULL), \
 	CMD(BT_HCI_CMD_LE_SET_RESOLV_TIMEOUT, cmd_set_rl_timeout, NULL)
 
+static const struct btdev_cmd cmd_bredr_le[] = {
+	CMD_COMMON_ALL,
+	CMD_COMMON_BREDR_LE,
+	CMD_COMMON_BREDR_20,
+	CMD_COMMON_BREDR_LE_40,
+	CMD_BREDR,
+	CMD_LE,
+	{}
+};
+
+static void set_bredrle_40_commands(struct btdev *btdev)
+{
+	/* Extra BR/EDR commands we want to only support for >= 4.0
+	 * adapters.
+	 */
+	btdev->commands[22] |= 0x04;	/* Set Event Mask Page 2 */
+	btdev->commands[31] |= 0x80;	/* Read Sync Train Parameters */
+	btdev->commands[32] |= 0x04;	/* Read Secure Connections Support */
+	btdev->commands[32] |= 0x08;	/* Write Secure Connections Support */
+	btdev->commands[32] |= 0x10;	/* Read Auth Payload Timeout */
+	btdev->commands[32] |= 0x20;	/* Write Auth Payload Timeout */
+	btdev->commands[32] |= 0x40;	/* Read Local OOB Extended Data */
+	btdev->cmds = cmd_bredr_le;
+}
+
 static int cmd_set_default_phy(struct btdev *dev, const void *data,
 							uint8_t len)
 {
@@ -6041,6 +6163,9 @@ done:
 static const struct btdev_cmd cmd_le_5_0[] = {
 	CMD_COMMON_ALL,
 	CMD_COMMON_BREDR_LE,
+	CMD_COMMON_BREDR_20,
+	CMD_COMMON_BREDR_LE_40,
+	CMD_BREDR,
 	CMD_LE,
 	CMD_LE_50,
 	{}
@@ -7345,6 +7470,9 @@ static int cmd_config_data_path(struct btdev *dev, const void *data,
 static const struct btdev_cmd cmd_le_5_2[] = {
 	CMD_COMMON_ALL,
 	CMD_COMMON_BREDR_LE,
+	CMD_COMMON_BREDR_20,
+	CMD_COMMON_BREDR_LE_40,
+	CMD_BREDR,
 	CMD_LE,
 	CMD_LE_50,
 	CMD_LE_52,
@@ -7398,6 +7526,7 @@ static int cmd_le_read_all_local_features(struct btdev *dev, const void *data,
 
 	memset(&rsp, 0, sizeof(rsp));
 	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.page = 10;
 	memcpy(rsp.features, dev->le_features, 248);
 
 	cmd_complete(dev, BT_HCI_CMD_LE_READ_ALL_LOCAL_FEATURES, &rsp,
@@ -7446,6 +7575,9 @@ static int cmd_le_read_all_remote_features(struct btdev *dev, const void *data,
 static const struct btdev_cmd cmd_le_6_0[] = {
 	CMD_COMMON_ALL,
 	CMD_COMMON_BREDR_LE,
+	CMD_COMMON_BREDR_20,
+	CMD_COMMON_BREDR_LE_40,
+	CMD_BREDR,
 	CMD_LE,
 	CMD_LE_50,
 	CMD_LE_52,
@@ -7514,6 +7646,9 @@ static void set_le_commands(struct btdev *btdev)
 
 	btdev->cmds = cmd_le;
 
+	if (btdev->type >= BTDEV_TYPE_BREDRLE)
+		set_bredrle_40_commands(btdev);
+
 	/* Extra LE commands for >= 5.0 adapters */
 	if (btdev->type >= BTDEV_TYPE_BREDRLE50) {
 		set_le_50_commands(btdev);
@@ -7527,137 +7662,16 @@ static void set_le_commands(struct btdev *btdev)
 	}
 
 	/* Extra LE commands for >= 6.0 adapters */
-	if (btdev->type >= BTDEV_TYPE_BREDRLE52) {
+	if (btdev->type >= BTDEV_TYPE_BREDRLE60) {
 		set_le_60_commands(btdev);
 		btdev->cmds = cmd_le_6_0;
 	}
 }
 
-static int cmd_set_event_mask_2(struct btdev *dev, const void *data,
-							uint8_t len)
-{
-	const struct bt_hci_cmd_set_event_mask_page2 *cmd = data;
-	uint8_t status = BT_HCI_ERR_SUCCESS;
-
-	memcpy(dev->event_mask_page2, cmd->mask, 8);
-	cmd_complete(dev, BT_HCI_CMD_SET_EVENT_MASK_PAGE2, &status,
-						sizeof(status));
-
-	return 0;
-}
-
-static int cmd_read_sync_train_params(struct btdev *dev, const void *data,
-							uint8_t len)
-{
-	struct bt_hci_rsp_read_sync_train_params rsp;
-
-	memset(&rsp, 0, sizeof(rsp));
-
-	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.interval = cpu_to_le16(dev->sync_train_interval);
-	rsp.timeout = cpu_to_le32(dev->sync_train_timeout);
-	rsp.service_data = dev->sync_train_service_data;
-	cmd_complete(dev, BT_HCI_CMD_READ_SYNC_TRAIN_PARAMS, &rsp, sizeof(rsp));
-
-	return 0;
-}
-
-static int cmd_read_sc_support(struct btdev *dev, const void *data, uint8_t len)
-{
-	struct bt_hci_rsp_read_secure_conn_support rsp;
-
-	memset(&rsp, 0, sizeof(rsp));
-
-	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.support = dev->secure_conn_support;
-	cmd_complete(dev, BT_HCI_CMD_READ_SECURE_CONN_SUPPORT, &rsp,
-							sizeof(rsp));
-
-	return 0;
-}
-
-static int cmd_write_sc_support(struct btdev *dev, const void *data,
-							uint8_t len)
-{
-	const struct bt_hci_cmd_write_secure_conn_support *cmd = data;
-	uint8_t status = BT_HCI_ERR_SUCCESS;
-
-	dev->secure_conn_support = cmd->support;
-	cmd_complete(dev, BT_HCI_CMD_WRITE_SECURE_CONN_SUPPORT, &status,
-							sizeof(status));
-
-	return 0;
-}
-
-static int cmd_read_auth_payload_timeout(struct btdev *dev, const void *data,
-							uint8_t len)
-{
-	/* TODO */
-	return -ENOTSUP;
-}
-
-static int cmd_write_auth_payload_timeout(struct btdev *dev, const void *data,
-							uint8_t len)
-{
-	/* TODO */
-	return -ENOTSUP;
-}
-
-static int cmd_read_local_oob_ext_data(struct btdev *dev, const void *data,
-							uint8_t len)
-{
-	struct bt_hci_rsp_read_local_oob_ext_data rsp;
-
-	memset(&rsp, 0, sizeof(rsp));
-
-	rsp.status = BT_HCI_ERR_SUCCESS;
-	cmd_complete(dev, BT_HCI_CMD_READ_LOCAL_OOB_EXT_DATA, &rsp,
-							sizeof(rsp));
-
-	return 0;
-}
-
-#define BT_BREDR_LE \
-	CMD(BT_HCI_CMD_SET_EVENT_MASK_PAGE2, cmd_set_event_mask_2, NULL), \
-	CMD(BT_HCI_CMD_READ_SYNC_TRAIN_PARAMS, cmd_read_sync_train_params, \
-					NULL), \
-	CMD(BT_HCI_CMD_READ_SECURE_CONN_SUPPORT, cmd_read_sc_support, NULL), \
-	CMD(BT_HCI_CMD_WRITE_SECURE_CONN_SUPPORT, cmd_write_sc_support, NULL), \
-	CMD(BT_HCI_CMD_READ_AUTH_PAYLOAD_TIMEOUT, \
-					cmd_read_auth_payload_timeout, NULL), \
-	CMD(BT_HCI_CMD_WRITE_AUTH_PAYLOAD_TIMEOUT, \
-					cmd_write_auth_payload_timeout, NULL), \
-	CMD(BT_HCI_CMD_READ_LOCAL_OOB_EXT_DATA, \
-					cmd_read_local_oob_ext_data, NULL)
-
-static const struct btdev_cmd cmd_bredr_le[] = {
-	CMD_COMMON_ALL,
-	CMD_COMMON_BREDR_LE,
-	CMD_COMMON_BREDR_20,
-	CMD_BREDR,
-	CMD_LE,
-	CMD_LE_50,
-	CMD_LE_52,
-	BT_BREDR_LE,
-	{}
-};
-
 static void set_bredrle_commands(struct btdev *btdev)
 {
 	set_bredr_commands(btdev);
 	set_le_commands(btdev);
-
-	/* Extra BR/EDR commands we want to only support for >= 4.0
-	 * adapters.
-	 */
-	btdev->commands[22] |= 0x04;	/* Set Event Mask Page 2 */
-	btdev->commands[31] |= 0x80;	/* Read Sync Train Parameters */
-	btdev->commands[32] |= 0x04;	/* Read Secure Connections Support */
-	btdev->commands[32] |= 0x08;	/* Write Secure Connections Support */
-	btdev->commands[32] |= 0x10;	/* Read Auth Payload Timeout */
-	btdev->commands[32] |= 0x20;	/* Write Auth Payload Timeout */
-	btdev->commands[32] |= 0x40;	/* Read Local OOB Extended Data */
-	btdev->cmds = cmd_bredr_le;
 }
 
 static void set_amp_commands(struct btdev *btdev)
-- 
2.51.1

