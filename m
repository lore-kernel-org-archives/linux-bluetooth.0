Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2370C48BE5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 04:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97767613B0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 04:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhFWEwH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jun 2021 00:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhFWEwG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jun 2021 00:52:06 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF41C061756
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jun 2021 21:49:49 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id e20so760791pgg.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jun 2021 21:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uZSiXJbnGeuxS5aa3LIqv6u5CYJbvasHC6wO3ANSWgA=;
        b=Y/Ic+ACaWdGdeFAfYaA4lmUkXlacteBfVEhWN9bc5DUC1yeKJ1hh2idiWprwHL6b+U
         39VyS7NJ4xsON/1QP3RsEPpFlZSKerwJT6bO1tX/+7qPPSssYXZYvj9eWawOCr/4amgE
         lHH7nmJD9v+fr+KP3bZ//fPOYozSCSCNCQx3qvhS7xH8zB3bGGOLHxCUZI3L+zlMTUEc
         kv7mW04WLg7VeguHhUKdxQP4veUZNGrhXDVvlvxg942PVtbpa6UpI2/hFdVMJ7/BF7Zo
         uwwS/Ks3cN08oRDwbT0rhI0hFRRoJ15r7LhEFuapcweJwJOs3H1t+rVNcBXzriUWQV9T
         rQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uZSiXJbnGeuxS5aa3LIqv6u5CYJbvasHC6wO3ANSWgA=;
        b=UH1OSUkC0WNruw3vJ55A2m0oPxW9O2gRYaCWEh9Nq9XdXLxBNE9CF33WW6nTU664n+
         Nb/+FYIkh4uOovfxbscblFcbqjZzA6cvRw7yDeDSMsgYoBRQ/S2ThAfWULCS4C3xFcDq
         nY5KitPvk6QZP7dr+Qi1wFqYvfgzwv8F33wvadEJrWeb4BxfhBg+K2ZfG0v3M+3zuvdf
         HDENN0Wm25el5+08I3RN3TwT+iVxhsj5UqB3QOlsA7HK34AhKhPY6hSaiBxdP2CiZMgv
         rdOjmdqq9lcxyQMHiFBudA59uAfMEfEEhQLA6WBMltX5ImFzcubsVTGaKPKN5DEvS6sh
         BiCw==
X-Gm-Message-State: AOAM532fNzGE1ATQyzF3kQ7zR6M0I8wqIfsSWJ/dXJuSeteqiwMMkxpt
        Av4EbdbdH9kjsxE5I7P0Ku/QDr1+dwA=
X-Google-Smtp-Source: ABdhPJzixXEROX1Jwz/tBdUQ6Rci9hEuSujhHrKc8+zOPA72A6fT201lPCGpvWKz+ssvq4qS6939Zg==
X-Received: by 2002:a62:7616:0:b029:305:f420:49cc with SMTP id r22-20020a6276160000b0290305f42049ccmr4409961pfc.51.1624423788437;
        Tue, 22 Jun 2021 21:49:48 -0700 (PDT)
Received: from han1-mobl3.intel.com ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id c184sm900129pfa.38.2021.06.22.21.49.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 21:49:48 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 3/5] emulator/btdev: Add support HCI LE Adv Set Terminated event
Date:   Tue, 22 Jun 2021 21:49:42 -0700
Message-Id: <20210623044944.602205-3-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210623044944.602205-1-hj.tedd.an@gmail.com>
References: <20210623044944.602205-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This patch adds support the HCI_LE_Advertising_Set_Terminated event in
btdev.
---
 emulator/btdev.c | 64 +++++++++++++++++++++++++++++++++++++++++++++---
 monitor/bt.h     |  1 +
 2 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index c5ea35e54..90457a5aa 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -74,6 +74,7 @@ struct btdev_rl {
 };
 
 struct le_ext_adv {
+	struct btdev *dev;
 	uint8_t handle;
 	uint8_t enable;
 	uint8_t type;			/* evt_properties */
@@ -86,6 +87,7 @@ struct le_ext_adv {
 	uint8_t adv_data_len;
 	uint8_t scan_data[252];
 	uint8_t scan_data_len;
+	unsigned int id;
 };
 
 struct btdev {
@@ -4237,6 +4239,11 @@ static void ext_adv_disable(void *data, void *user_data)
 	if (handle && ext_adv->handle != handle)
 		return;
 
+	if (ext_adv->id) {
+		timeout_remove(ext_adv->id);
+		ext_adv->id = 0;
+	}
+
 	ext_adv->enable = 0x00;
 }
 
@@ -4253,6 +4260,7 @@ static struct le_ext_adv *le_ext_adv_new(struct btdev *btdev, uint8_t handle)
 	struct le_ext_adv *ext_adv;
 
 	ext_adv = new0(struct le_ext_adv, 1);
+	ext_adv->dev = btdev;
 	ext_adv->handle = handle;
 
 	/* Add to queue */
@@ -4268,6 +4276,12 @@ static void le_ext_adv_free(void *data)
 {
 	struct le_ext_adv *ext_adv = data;
 
+	/* Remove to queue */
+	queue_remove(ext_adv->dev->le_ext_adv, ext_adv);
+
+	if (ext_adv->id)
+		timeout_remove(ext_adv->id);
+
 	free(ext_adv);
 }
 
@@ -4477,6 +4491,31 @@ static void le_set_ext_adv_enable_complete(struct btdev *btdev,
 		}
 	}
 }
+static void adv_set_terminate(struct btdev *dev, uint8_t status, uint8_t handle,
+					uint16_t conn_handle, uint8_t num_evts)
+{
+	struct bt_hci_evt_le_adv_set_term ev;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.status = status;
+	ev.handle = handle;
+	ev.conn_handle = cpu_to_le16(conn_handle);
+	ev.num_evts = num_evts;
+
+	le_meta_event(dev, BT_HCI_EVT_LE_ADV_SET_TERM, &ev, sizeof(ev));
+}
+
+static bool ext_adv_timeout(void *user_data)
+{
+	struct le_ext_adv *adv = user_data;
+
+	adv->id = 0;
+	adv_set_terminate(adv->dev, BT_HCI_ERR_ADV_TIMEOUT, adv->handle,
+								0x0000, 0x00);
+	le_ext_adv_free(adv);
+
+	return false;
+}
 
 static int cmd_set_ext_adv_enable(struct btdev *dev, const void *data,
 							uint8_t len)
@@ -4517,6 +4556,13 @@ static int cmd_set_ext_adv_enable(struct btdev *dev, const void *data,
 		}
 
 		ext_adv->enable = cmd->enable;
+
+		if (!cmd->enable)
+			ext_adv_disable(ext_adv, NULL);
+		else if (eas->duration)
+			ext_adv->id = timeout_add(eas->duration * 10,
+							ext_adv_timeout,
+							ext_adv, NULL);
 	}
 
 exit_complete:
@@ -4785,6 +4831,19 @@ static int cmd_ext_create_conn(struct btdev *dev, const void *data, uint8_t len)
 	return 0;
 }
 
+static void ext_adv_term(void *data, void *user_data)
+{
+	struct le_ext_adv *adv = data;
+	struct btdev_conn *conn = user_data;
+
+	/* if connectable bit is set the send adv terminate */
+	if (conn && adv->type & 0x01) {
+		adv_set_terminate(conn->dev, 0x00, adv->handle, conn->handle,
+									0x00);
+		le_ext_adv_free(adv);
+	}
+}
+
 static void le_ext_conn_complete(struct btdev *btdev,
 			const struct bt_hci_cmd_le_ext_create_conn *cmd,
 			struct le_ext_adv *ext_adv,
@@ -4803,9 +4862,8 @@ static void le_ext_conn_complete(struct btdev *btdev,
 			return;
 
 		/* Disable EXT ADV */
-		queue_foreach(btdev->le_ext_adv, ext_adv_disable, NULL);
-		queue_foreach(conn->link->dev->le_ext_adv, ext_adv_disable,
-									NULL);
+		queue_foreach(btdev->le_ext_adv, ext_adv_term, conn);
+		queue_foreach(conn->link->dev->le_ext_adv, ext_adv_term, conn);
 
 		ev.status = status;
 		ev.peer_addr_type = btdev->le_scan_own_addr_type;
diff --git a/monitor/bt.h b/monitor/bt.h
index d60bbdb20..738bc294b 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3656,6 +3656,7 @@ struct bt_hci_evt_le_req_peer_sca_complete {
 #define BT_HCI_ERR_UNSUPPORTED_FEATURE		0x11
 #define BT_HCI_ERR_INVALID_PARAMETERS		0x12
 #define BT_HCI_ERR_UNSPECIFIED_ERROR		0x1f
+#define BT_HCI_ERR_ADV_TIMEOUT                 0x3c
 #define BT_HCI_ERR_CONN_FAILED_TO_ESTABLISH	0x3e
 #define BT_HCI_ERR_UNKNOWN_ADVERTISING_ID	0x42
 
-- 
2.26.3

