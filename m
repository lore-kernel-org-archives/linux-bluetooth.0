Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FAFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 20:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A181960E0B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 20:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbhJYUdt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 16:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbhJYUdq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 16:33:46 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C3BC061745
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 13:31:23 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id t184so12022141pfd.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 13:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YtgMF/aE7f3R8Ln9dfMopZcvYwb0dG6lRLohzMGKZHY=;
        b=XuRySU/6PmCX5B1YQJ2OxwCsw7XqXMmTp/Eh1CI21Nn8NRTd1FhJylATBYKolLDGep
         VbT3GSrY2XVqzn8gWzjgaxr6BIpsxzpQ8nEcWR+GKETlrORiojDRHDoIJTKovvxDfu5d
         dSVbcHXm9eh4/P5JqVndu1f06wlXWep3wsyDYx43ITwl0xTARCdFmVbOrAY1DEXolcjC
         nTPZ/U65Lc64zop4cZtr9kKPbpSyqUf3sxtknmirSDuWwUPVwM/MyWvFGFV1pyIAi75y
         tNWNNS/MV21ZTrQwDfX4e3fLWEFPrbWZbZARe06srm4bwyVntph1isX4WkEmJNow1EIP
         I+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YtgMF/aE7f3R8Ln9dfMopZcvYwb0dG6lRLohzMGKZHY=;
        b=Y7ChTstPL40DK6YfmrpP0UxA/avzNg2Gva0Oonc0lpYlhm4WJAuJJ9gLslpA58+nBc
         6/pAd6NbZUMWnraBpDBAaIHHsyeCkVFobma2FU4b8CpC+PzNdug1d3IAeSsbSNe/wtWP
         dZibZEcb9H7vE5jWO3R8pINchByOmHwYC6b+iq3ATsnQKzIvPhKBcz9b+YdLhXFNt1AJ
         jGjeR8B/VglS4TMBdtUNcN97gChh+GKARoHXM4MoLHYu5Q6y3xJGvo9G1pCRnl1xwK3V
         DdNrzc8NArnNIE9HWqYg0w3aDFr9GqCuuMnT7dT3v4QjdIJppD81v95aDfMRjv4MXS0J
         rKKA==
X-Gm-Message-State: AOAM530uuuaTPiFXsEQURSzTaR49K0O4xAGXo3kABVtJd/K8+3fI/X33
        TXMBtx+8Y2Ycgp/B/7APq40xLak5AyX6aA==
X-Google-Smtp-Source: ABdhPJzLOn8rqD6BctOq8wtVvyqoC6VFpFoIgp+jnhSqH/1Y0k0UHIoNB6vyGH2jthyCrkkgzYUKZg==
X-Received: by 2002:aa7:9727:0:b0:47b:e175:2320 with SMTP id k7-20020aa79727000000b0047be1752320mr14562931pfg.77.1635193882892;
        Mon, 25 Oct 2021 13:31:22 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:78ab:b967:528:d348])
        by smtp.gmail.com with ESMTPSA id l12sm21504899pfu.100.2021.10.25.13.31.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 13:31:22 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 3/4] emulator: Add support to get the advertising address
Date:   Mon, 25 Oct 2021 13:31:19 -0700
Message-Id: <20211025203120.513189-3-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025203120.513189-1-hj.tedd.an@gmail.com>
References: <20211025203120.513189-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch add supprt emulator to get the advertising address of the
central device.
---
 emulator/btdev.c  | 23 +++++++++++++++++++++--
 emulator/btdev.h  |  2 ++
 emulator/hciemu.c | 15 +++++++++++++++
 emulator/hciemu.h |  3 +++
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 2cbe24edc..7b311f347 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -4703,6 +4703,7 @@ static void send_ext_adv(struct btdev *btdev, const struct btdev *remote,
 					struct le_ext_adv *ext_adv,
 					uint16_t type, bool is_scan_rsp)
 {
+
 	struct __packed {
 		uint8_t num_reports;
 		union {
@@ -4818,6 +4819,9 @@ static int cmd_set_ext_adv_enable(struct btdev *dev, const void *data,
 
 		/* Disable all advertising sets */
 		queue_foreach(dev->le_ext_adv, ext_adv_disable, NULL);
+
+		dev->le_adv_enable = 0x00;
+
 		goto exit_complete;
 	}
 
@@ -4872,6 +4876,8 @@ static int cmd_set_ext_adv_enable(struct btdev *dev, const void *data,
 
 		ext_adv->enable = cmd->enable;
 
+		dev->le_adv_enable = 0x01;
+
 		if (!cmd->enable)
 			ext_adv_disable(ext_adv, NULL);
 		else if (eas->duration)
@@ -4936,7 +4942,7 @@ static int cmd_remove_adv_set(struct btdev *dev, const void *data,
 						UINT_TO_PTR(cmd->handle));
 	if (!ext_adv) {
 		status = BT_HCI_ERR_UNKNOWN_ADVERTISING_ID;
-		cmd_complete(dev, BT_HCI_CMD_LE_SET_EXT_ADV_DATA, &status,
+		cmd_complete(dev, BT_HCI_CMD_LE_REMOVE_ADV_SET, &status,
 						sizeof(status));
 		return 0;
 	}
@@ -5206,7 +5212,7 @@ static void le_ext_conn_complete(struct btdev *btdev,
 		/* Set Local RPA if an RPA was generated for the advertising */
 		if (ext_adv->rpa)
 			memcpy(ev.local_rpa, ext_adv->random_addr,
-					sizeof(ev.local_rpa));
+							sizeof(ev.local_rpa));
 
 		le_meta_event(conn->link->dev,
 				BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE, &ev,
@@ -6435,6 +6441,19 @@ uint8_t btdev_get_le_scan_enable(struct btdev *btdev)
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
index b5f9979a8..9493938c6 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -78,6 +78,8 @@ uint8_t btdev_get_scan_enable(struct btdev *btdev);
 
 uint8_t btdev_get_le_scan_enable(struct btdev *btdev);
 
+const uint8_t *btdev_get_adv_addr(struct btdev *btdev, uint8_t handle);
+
 void btdev_set_le_states(struct btdev *btdev, const uint8_t *le_states);
 
 void btdev_set_al_len(struct btdev *btdev, uint8_t len);
diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index 1f7af3b93..057f76ff3 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -629,6 +629,21 @@ void hciemu_set_central_le_rl_len(struct hciemu *hciemu, uint8_t len)
 	btdev_set_rl_len(dev, len);
 }
 
+const uint8_t *hciemu_get_central_adv_addr(struct hciemu *hciemu,
+								uint8_t handle)
+{
+	struct btdev *dev;
+
+	if (!hciemu || !hciemu->vhci)
+		return NULL;
+
+	dev = vhci_get_btdev(hciemu->vhci);
+	if (!dev)
+		return NULL;
+
+	return btdev_get_adv_addr(dev, handle);
+}
+
 bool hciemu_add_central_post_command_hook(struct hciemu *hciemu,
 			hciemu_command_func_t function, void *user_data)
 {
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index 2a49d8bad..3a06ca578 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -65,6 +65,9 @@ void hciemu_set_central_le_al_len(struct hciemu *hciemu, uint8_t len);
 
 void hciemu_set_central_le_rl_len(struct hciemu *hciemu, uint8_t len);
 
+const uint8_t *hciemu_get_central_adv_addr(struct hciemu *hciemu,
+							uint8_t handle);
+
 typedef void (*hciemu_command_func_t)(uint16_t opcode, const void *data,
 						uint8_t len, void *user_data);
 
-- 
2.25.1

