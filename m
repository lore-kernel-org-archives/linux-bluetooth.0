Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAB8C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Oct 2021 19:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B68E160F6F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Oct 2021 19:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241308AbhJGTim (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Oct 2021 15:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241238AbhJGTil (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Oct 2021 15:38:41 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99241C061570
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Oct 2021 12:36:47 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id qe4-20020a17090b4f8400b0019f663cfcd1so7720496pjb.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Oct 2021 12:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=u7EeiV7znlJ57bJ/K19nT2MwsmEe5IMZ9y/c/FTp604=;
        b=OtXMAUZS1l/OyBklVeWkodIrGhCsdbOSOBQVAm83Bt+T7UwPcT1ImC9DG8KYzQQ70A
         +jhMKhzbgzjtOHaYHv593kniVAeA9yTMkxcjRwFSimz43SEHVvXaoBg53IuJ0oOVMB23
         wXO6n6rk5qXqRC90iqKgxp4eYsnshaFh0P49qz1mUc0j33IHfjLlYZkKom9qvvwcwBXN
         9zFo+qZBPxuentUxZd0QgFYbFoAOT2Um4+DHE3XrtnHXednOi83UiXPRL7v3Lab4qb8Q
         FWWp0X+r4BAN+krHgEKbZS4d+3xrSbon+CRiXU92QnNUTc4cxQ7ar8iStugzqibl967h
         FUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u7EeiV7znlJ57bJ/K19nT2MwsmEe5IMZ9y/c/FTp604=;
        b=v8hab7KbMkYZvj7gnQRyFAtIGIH/xYSan1xyPPL4hpOqc9xOAQ479fk5rfLvMjwtvO
         XllPlpxhDQDjtfLltSxtRZ6pL1Jlz34EXOiv6OZjLg/JNwMJdEms4igQUzHdAWcCebEG
         uk6/bcAF8HbmDG8OSK2SxDw9d7gZPU8xdUiHWSkJ3ndUujJo0h6WlRgWsoah39s0H289
         38J/5nkHqv41ks89SAktJfDmSqVW/R9eq3UG27r5Fc9PBXwvgqhhGWdRYkGrvdBohIJZ
         VCr8bmPmJxaYshHH55D9sHgo/ElGiVwemNNYwLiRXiob0E0RqH2QNB4OWJmDgMPCnKVw
         GDwQ==
X-Gm-Message-State: AOAM530p1qytFqEgHlMXOtbax4WykmIKekbxppceTwhcV8mpd3lQzNM5
        9mrd2bZ9xE6sxyzaj00J73GeKB9Pusr34w==
X-Google-Smtp-Source: ABdhPJyPCrnFU2n+FAqC6EX6if7tKT6Ns3AmDpTTyLCr/moMN8KVYqvWXAy0ggbwW+35JnKE9HP4sA==
X-Received: by 2002:a17:902:7c17:b0:13e:2dd5:e5c4 with SMTP id x23-20020a1709027c1700b0013e2dd5e5c4mr5788097pll.68.1633635406809;
        Thu, 07 Oct 2021 12:36:46 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:4a7b:d840:6dbb:9d5c])
        by smtp.gmail.com with ESMTPSA id d9sm118815pgn.64.2021.10.07.12.36.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 12:36:46 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ PATCH v10 3/4] emulator: Add support to get the advertising address
Date:   Thu,  7 Oct 2021 12:36:42 -0700
Message-Id: <20211007193643.61436-3-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007193643.61436-1-hj.tedd.an@gmail.com>
References: <20211007193643.61436-1-hj.tedd.an@gmail.com>
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

