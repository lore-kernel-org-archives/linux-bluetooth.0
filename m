Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8C7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 20:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B5AF60E52
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 20:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhJYUds (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 16:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbhJYUdp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 16:33:45 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D29C061348
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 13:31:22 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d9so11996005pfl.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 13:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ibBibPNypXY+D2ENNoPS+wPVpW1eD6IA597WrTdc+zw=;
        b=DDQCtyltt2YQ1bpPKEnHELBngvsEv+0SSBujSHWhpc+G/X+IoZ+afGn/xuq6Z78VlZ
         bf+6OzhAb9kEqy5dVhNjD3UDpl7KJO8j58hl/g6UNqMxAUlvBiHJrY4CH3y3FamCwhJJ
         gXRVe1+IhzWeHihVrsKmH7vwjWw98I0ZmeaK7fNnhwAUj2KveLVLlb6BCFcDmmB0mX22
         a+gDwfcGpfscIBskJCY90Ddvwp3plsT1ebVdQSJBhGi0kgemQS/mOD0W7WV5It2oU8Fa
         Xvu9zzGHBD6SO67gV4M7LMVFSjhiRd3EXBDclBnEkMRhFMsFDh+TCt/snNSpYQGvCNjs
         i6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ibBibPNypXY+D2ENNoPS+wPVpW1eD6IA597WrTdc+zw=;
        b=LMoS7bIbEJXuMgcyePMREzJI6T4VfsYf501ud3HIejwZYVx3303Fz4ah91jzklxySe
         MAuKiBSJ8R2opHoF2sbVDQIf15kfY4gymxuDo3WXv04c1uzvuryFhTHuNN4evzz9eb60
         bdJJo2cDshI/+1FyLbg4yevKdtHhaITFyUWPuJX59/pZe9T0vI7Y3+Dg3bxPG9OjWKAd
         tKzsDwKZHb5kcskzf1+q8ofQpfrjKLbn8bTv2vCC5tXnYrthK7XEeLAzTAynnL5SAbKR
         h602IY07Gwf28pPOBpr4Oxd81MUzdYdZ3AeflDBj/EJZf+PZrJbDgxm+ORz757hnbahA
         wCVw==
X-Gm-Message-State: AOAM53322nBIWI/7njcI69PE1rNTKNO0/2IYA1ASAZRGt75szvZaCwKR
        ak9RuDjB332xTJ+FkdVYHvSMtMXxjXyYRw==
X-Google-Smtp-Source: ABdhPJzJZIHRM+h8fvey2xlEoMoCnMk4gu9oODKbRTIfjCPIc0O0jqc5OfctBTV1S2jZde9kAoZbLg==
X-Received: by 2002:a65:6a15:: with SMTP id m21mr15446332pgu.415.1635193881588;
        Mon, 25 Oct 2021 13:31:21 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:78ab:b967:528:d348])
        by smtp.gmail.com with ESMTPSA id l12sm21504899pfu.100.2021.10.25.13.31.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 13:31:21 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 1/4] emulator: Add support to config the accept and resolve list
Date:   Mon, 25 Oct 2021 13:31:17 -0700
Message-Id: <20211025203120.513189-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds interfaces to config the accept list and resolve list in
the btdev.
---
 emulator/btdev.c  | 37 +++++++++++++++++++++++++++++--------
 emulator/btdev.h  |  4 ++++
 emulator/hciemu.c | 28 ++++++++++++++++++++++++++++
 emulator/hciemu.h |  4 ++++
 4 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 177633b9c..2cbe24edc 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -198,6 +198,10 @@ struct btdev {
 	} __attribute__ ((packed)) le_cig;
 	uint8_t  le_iso_path[2];
 
+	/* Real time length of AL array */
+	uint8_t le_al_len;
+	/* Real time length of RL array */
+	uint8_t le_rl_len;
 	struct btdev_al le_al[AL_SIZE];
 	struct btdev_rl le_rl[RL_SIZE];
 	uint8_t  le_rl_enable;
@@ -482,6 +486,18 @@ static void rl_clear(struct btdev *dev)
 		rl_reset(&dev->le_rl[i]);
 }
 
+/* Set the real time length of AL array */
+void btdev_set_al_len(struct btdev *btdev, uint8_t len)
+{
+	btdev->le_al_len = len;
+}
+
+/* Set the real time length of RL array */
+void btdev_set_rl_len(struct btdev *btdev, uint8_t len)
+{
+	btdev->le_rl_len = len;
+}
+
 static void btdev_reset(struct btdev *btdev)
 {
 	/* FIXME: include here clearing of all states that should be
@@ -493,6 +509,9 @@ static void btdev_reset(struct btdev *btdev)
 
 	al_clear(btdev);
 	rl_clear(btdev);
+
+	btdev->le_al_len = AL_SIZE;
+	btdev->le_rl_len = RL_SIZE;
 }
 
 static int cmd_reset(struct btdev *dev, const void *data, uint8_t len)
@@ -3578,7 +3597,7 @@ static int cmd_read_al_size(struct btdev *dev, const void *data, uint8_t len)
 	struct bt_hci_rsp_le_read_accept_list_size rsp;
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.size = AL_SIZE;
+	rsp.size = dev->le_al_len;
 	cmd_complete(dev, BT_HCI_CMD_LE_READ_ACCEPT_LIST_SIZE, &rsp,
 						sizeof(rsp));
 
@@ -3669,7 +3688,7 @@ static int cmd_add_al(struct btdev *dev, const void *data, uint8_t len)
 		goto done;
 	}
 
-	for (i = 0; i < AL_SIZE; i++) {
+	for (i = 0; i < dev->le_al_len; i++) {
 		struct btdev_al *al = &dev->le_al[i];
 
 		if (AL_ADDR_EQUAL(al, cmd->addr_type, &cmd->addr)) {
@@ -3731,7 +3750,7 @@ static int cmd_remove_al(struct btdev *dev, const void *data, uint8_t len)
 		goto done;
 	}
 
-	for (i = 0; i < AL_SIZE; i++) {
+	for (i = 0; i < dev->le_al_len; i++) {
 		struct btdev_al *al = &dev->le_al[i];
 
 		ba2str(&al->addr, addr);
@@ -3746,7 +3765,7 @@ static int cmd_remove_al(struct btdev *dev, const void *data, uint8_t len)
 		}
 	}
 
-	if (i == AL_SIZE) {
+	if (i == dev->le_al_len) {
 		status = BT_HCI_ERR_INVALID_PARAMETERS;
 		goto done;
 	}
@@ -3785,7 +3804,7 @@ static int cmd_add_rl(struct btdev *dev, const void *data, uint8_t len)
 		goto done;
 	}
 
-	for (i = 0; i < RL_SIZE; i++) {
+	for (i = 0; i < dev->le_rl_len; i++) {
 		struct btdev_rl *rl = &dev->le_rl[i];
 
 		if (RL_ADDR_EQUAL(rl, cmd->addr_type, &cmd->addr)) {
@@ -3847,7 +3866,7 @@ static int cmd_remove_rl(struct btdev *dev, const void *data, uint8_t len)
 		goto done;
 	}
 
-	for (i = 0; i < RL_SIZE; i++) {
+	for (i = 0; i < dev->le_rl_len; i++) {
 		struct btdev_rl *rl = &dev->le_rl[i];
 
 		if (RL_ADDR_EQUAL(rl, cmd->addr_type, &cmd->addr)) {
@@ -3856,7 +3875,7 @@ static int cmd_remove_rl(struct btdev *dev, const void *data, uint8_t len)
 		}
 	}
 
-	if (i == RL_SIZE) {
+	if (i == dev->le_rl_len) {
 		status = BT_HCI_ERR_INVALID_PARAMETERS;
 		goto done;
 	}
@@ -3902,7 +3921,7 @@ static int cmd_read_rl_size(struct btdev *dev, const void *data, uint8_t len)
 	struct bt_hci_rsp_le_read_resolv_list_size rsp;
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.size = RL_SIZE;
+	rsp.size = dev->le_rl_len;
 
 	cmd_complete(dev, BT_HCI_CMD_LE_READ_RESOLV_LIST_SIZE,
 							&rsp, sizeof(rsp));
@@ -6358,6 +6377,8 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 	btdev->conns = queue_new();
 	btdev->le_ext_adv = queue_new();
 
+	btdev->le_al_len = AL_SIZE;
+	btdev->le_rl_len = RL_SIZE;
 	return btdev;
 }
 
diff --git a/emulator/btdev.h b/emulator/btdev.h
index 412bfd158..b5f9979a8 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -80,6 +80,10 @@ uint8_t btdev_get_le_scan_enable(struct btdev *btdev);
 
 void btdev_set_le_states(struct btdev *btdev, const uint8_t *le_states);
 
+void btdev_set_al_len(struct btdev *btdev, uint8_t len);
+
+void btdev_set_rl_len(struct btdev *btdev, uint8_t len);
+
 void btdev_set_command_handler(struct btdev *btdev, btdev_command_func handler,
 							void *user_data);
 
diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index 4752c8a4d..1f7af3b93 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -601,6 +601,34 @@ void hciemu_set_central_le_states(struct hciemu *hciemu,
 	btdev_set_le_states(dev, le_states);
 }
 
+void hciemu_set_central_le_al_len(struct hciemu *hciemu, uint8_t len)
+{
+	struct btdev *dev;
+
+	if (!hciemu || !hciemu->vhci)
+		return;
+
+	dev = vhci_get_btdev(hciemu->vhci);
+	if (!dev)
+		return;
+
+	btdev_set_al_len(dev, len);
+}
+
+void hciemu_set_central_le_rl_len(struct hciemu *hciemu, uint8_t len)
+{
+	struct btdev *dev;
+
+	if (!hciemu || !hciemu->vhci)
+		return;
+
+	dev = vhci_get_btdev(hciemu->vhci);
+	if (!dev)
+		return;
+
+	btdev_set_rl_len(dev, len);
+}
+
 bool hciemu_add_central_post_command_hook(struct hciemu *hciemu,
 			hciemu_command_func_t function, void *user_data)
 {
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index 338fa844d..2a49d8bad 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -61,6 +61,10 @@ uint8_t hciemu_get_central_le_scan_enable(struct hciemu *hciemu);
 void hciemu_set_central_le_states(struct hciemu *hciemu,
 						const uint8_t *le_states);
 
+void hciemu_set_central_le_al_len(struct hciemu *hciemu, uint8_t len);
+
+void hciemu_set_central_le_rl_len(struct hciemu *hciemu, uint8_t len);
+
 typedef void (*hciemu_command_func_t)(uint16_t opcode, const void *data,
 						uint8_t len, void *user_data);
 
-- 
2.25.1

