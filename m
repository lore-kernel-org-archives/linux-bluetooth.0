Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20ADC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Oct 2021 22:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C4B611C3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Oct 2021 22:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243373AbhJOWoy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Oct 2021 18:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243355AbhJOWox (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Oct 2021 18:44:53 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8E5C061570
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Oct 2021 15:42:46 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id k26so9542634pfi.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Oct 2021 15:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=u7EeiV7znlJ57bJ/K19nT2MwsmEe5IMZ9y/c/FTp604=;
        b=Qb5QLBdEAu5NNTtxt440JHcmcbaVyLwYAw0IJl7p/Z1yDl41JM5boZzT7JwuNWx6zb
         VBawKLFBwtSRQWy5EGuuNodh2rOodgrai/PIFdERB9uuKjKEJRs6jk9AqaK+a2jZCKSM
         H24YyvL/ENoUY0sFP4CaKZRaM9f6D3uUSRX9uuTFi6oeRQj908ibe3S1uCGEIG3px/iF
         xse/pFEu/X/QQRisCmAfKkFd6BwkI2QgKgxZnNnT31AZ9OP0hXpjMTgKdF9e+wA8RC6D
         7pPjrobna0n2VGC8bu2KjHN6mfgnBjg2yjPR/2SxNH7j/OqEUbV2K78AhwTzxAHr4d8A
         Kb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u7EeiV7znlJ57bJ/K19nT2MwsmEe5IMZ9y/c/FTp604=;
        b=ftAHeG121aiqjtOFWgVsd9a/Lk2rKVjSaGPfmZedrpUYYOTDgFAsrEQdCvuiXDYEZ5
         Vi72DXdAevKWNzMIkL9beR4y/0qtItRyiYmWmIgF7+K0v0UYpqAir7xpzTXyUXd9pqVL
         xxcx8zByTpODElVI90TuQVCbLY4L8/IZMhNi/skg6/+ua8Kt1Mes440zNJffbpzUwqSl
         9mb3pt9KEC2xc6Ttvgdrxiy4Z/+LJmASmk7n6gEMrFIE4TTia7g3r2xz9IU5HF3thlHZ
         JIl7V5Yzw7IaQjZ+62eiglMf7AWa7duJQO58hGzO8CY19mK50fxPF7pN5qvw7oUt1HHC
         1ykA==
X-Gm-Message-State: AOAM5313G2QFbYHmKayxCyFXX7X9dcIqUHZy+zsnhSavCjIEjkOz0Ej8
        C36rffVpU1dzrc2W7jtguGLkSA72F3Quig==
X-Google-Smtp-Source: ABdhPJwHzrjFHFtIKRusOWQIxwzSrFryd9Hch3fWf6iiQW/py5c1dYgEgE9vMRGq7rYg8oCoskajnw==
X-Received: by 2002:a63:81c3:: with SMTP id t186mr4279521pgd.205.1634337765842;
        Fri, 15 Oct 2021 15:42:45 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:7cf0:730:2c83:c489])
        by smtp.gmail.com with ESMTPSA id c192sm5749770pfb.110.2021.10.15.15.42.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 15:42:45 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ PATCH v11 3/4] emulator: Add support to get the advertising address
Date:   Fri, 15 Oct 2021 15:42:41 -0700
Message-Id: <20211015224242.351166-3-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015224242.351166-1-hj.tedd.an@gmail.com>
References: <20211015224242.351166-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch add supprt emulator to get the advertising address of the
central device.
---
 emulator/btdev.c  | 31 ++++++++++++++++++++++++++-----
 emulator/btdev.h  |  2 ++
 emulator/hciemu.c | 10 ++++++++++
 emulator/hciemu.h |  3 +++
 4 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 2c199ed85..fd6d699c6 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -4648,6 +4648,7 @@ static void send_ext_adv(struct btdev *btdev, const struct btdev *remote,
 					struct le_ext_adv *ext_adv,
 					uint16_t type, bool is_scan_rsp)
 {
+
 	struct __packed {
 		uint8_t num_reports;
 		union {
@@ -4763,6 +4764,9 @@ static int cmd_set_ext_adv_enable(struct btdev *dev, const void *data,
 
 		/* Disable all advertising sets */
 		queue_foreach(dev->le_ext_adv, ext_adv_disable, NULL);
+
+		dev->le_adv_enable = 0x00;
+
 		goto exit_complete;
 	}
 
@@ -4817,6 +4821,8 @@ static int cmd_set_ext_adv_enable(struct btdev *dev, const void *data,
 
 		ext_adv->enable = cmd->enable;
 
+		dev->le_adv_enable = 0x01;
+
 		if (!cmd->enable)
 			ext_adv_disable(ext_adv, NULL);
 		else if (eas->duration)
@@ -4881,7 +4887,7 @@ static int cmd_remove_adv_set(struct btdev *dev, const void *data,
 						UINT_TO_PTR(cmd->handle));
 	if (!ext_adv) {
 		status = BT_HCI_ERR_UNKNOWN_ADVERTISING_ID;
-		cmd_complete(dev, BT_HCI_CMD_LE_SET_EXT_ADV_DATA, &status,
+		cmd_complete(dev, BT_HCI_CMD_LE_REMOVE_ADV_SET, &status,
 						sizeof(status));
 		return 0;
 	}
@@ -5147,6 +5153,11 @@ static void le_ext_conn_complete(struct btdev *btdev,
 		ev.latency = lecc->latency;
 		ev.supv_timeout = lecc->supv_timeout;
 
+		/* Set Local RPA if an RPA was generated for the advertising */
+		if (ext_adv->rpa)
+			memcpy(ev.local_rpa, ext_adv->random_addr,
+						sizeof(ev.local_rpa));
+
 		le_meta_event(conn->link->dev,
 				BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE, &ev,
 				sizeof(ev));
@@ -5160,10 +5171,7 @@ static void le_ext_conn_complete(struct btdev *btdev,
 	memcpy(ev.peer_addr, cmd->peer_addr, 6);
 	ev.role = 0x00;
 
-	/* Set Local RPA if an RPA was generated for the advertising */
-	if (ext_adv->rpa)
-		memcpy(ev.local_rpa, ext_adv->random_addr,
-					sizeof(ev.local_rpa));
+	memset(ev.local_rpa, 0, sizeof(ev.local_rpa));
 
 	le_meta_event(btdev, BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE, &ev,
 						sizeof(ev));
@@ -6371,6 +6379,19 @@ uint8_t btdev_get_le_scan_enable(struct btdev *btdev)
 	return btdev->le_scan_enable;
 }
 
+const uint8_t *btdev_get_adv_addr(struct btdev *btdev, uint8_t handle)
+{
+	struct le_ext_adv *ext_adv;
+
+	/* Check if Ext Adv is already existed */
+	ext_adv = queue_find(btdev->le_ext_adv, match_ext_adv_handle,
+							UINT_TO_PTR(handle));
+	if (!ext_adv)
+		return NULL;
+
+	return ext_adv_addr(btdev, ext_adv);
+}
+
 void btdev_set_le_states(struct btdev *btdev, const uint8_t *le_states)
 {
 	memcpy(btdev->le_states, le_states, sizeof(btdev->le_states));
diff --git a/emulator/btdev.h b/emulator/btdev.h
index cce49db3b..cd259cf9b 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -78,6 +78,8 @@ uint8_t btdev_get_scan_enable(struct btdev *btdev);
 
 uint8_t btdev_get_le_scan_enable(struct btdev *btdev);
 
+const uint8_t *btdev_get_adv_addr(struct btdev *btdev, uint8_t handle);
+
 void btdev_set_le_states(struct btdev *btdev, const uint8_t *le_states);
 
 void btdev_set_al_len(struct btdev *btdev, uint8_t len);
diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index d18b3469b..28d1aa0d1 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -597,6 +597,16 @@ void hciemu_set_central_le_rl_len(struct hciemu *hciemu, uint8_t len)
 	btdev_set_rl_len(hciemu->dev, len);
 }
 
+const uint8_t *hciemu_get_central_adv_addr(struct hciemu *hciemu,
+								uint8_t handle)
+{
+	if (!hciemu || !hciemu->dev)
+		return NULL;
+
+
+	return btdev_get_adv_addr(hciemu->dev, handle);
+}
+
 bool hciemu_add_central_post_command_hook(struct hciemu *hciemu,
 			hciemu_command_func_t function, void *user_data)
 {
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index 73a90c1e6..71302d52f 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -64,6 +64,9 @@ void hciemu_set_central_le_al_len(struct hciemu *hciemu, uint8_t len);
 
 void hciemu_set_central_le_rl_len(struct hciemu *hciemu, uint8_t len);
 
+const uint8_t *hciemu_get_central_adv_addr(struct hciemu *hciemu,
+							uint8_t handle);
+
 typedef void (*hciemu_command_func_t)(uint16_t opcode, const void *data,
 						uint8_t len, void *user_data);
 
-- 
2.25.1

