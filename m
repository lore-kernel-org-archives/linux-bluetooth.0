Return-Path: <SRS0=BuFd=5C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A56C3F2CE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Mar 2020 02:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C94E20674
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Mar 2020 02:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UADu3K2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgCQCLu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Mar 2020 22:11:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35223 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgCQCLu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Mar 2020 22:11:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id u68so11044702pfb.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2020 19:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xPp4LX+rEwNnncRsIX9QEd5PbhIfT9a4PKD3hVnmrgE=;
        b=UADu3K2fnUpFm10dcm7mP1INOM1vSIzOu9NeB7XK7wxRdfDP4ljzW7BJcGz5XOT+96
         4Vx9vgwCycQBx2f/2zkJpgEgeIbO0tIu9HLfethumAIpb2EdQq9m4tdKK0WkcDWu9X6x
         JLc7ZhYgL/v8twHBOJ5Mbb82jva+4YbDrFqwIbcD6wBtW8VDuwHrWmAJ8rR+Zs1wEYNS
         hjiu8Szn9Sbeo3fKIAf4iyQ9I5HwAIuQ7cYWMXBM9Ot7u0jyxbVcXEzHYND9NiDrrQAE
         rhyr+VI68hSmLRxrMXB1hfsv766B5P47U6xduoXbL14O2pAQi7THzOwygDcgyIjWTCqg
         Amcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xPp4LX+rEwNnncRsIX9QEd5PbhIfT9a4PKD3hVnmrgE=;
        b=LNSmNtrWMwCEBgPqA5MKdENzk5XA5x9GqpCLPDHZVnQB7B1fv9AEIbEWGhWM9fKE17
         EkQv27k0GxhS8gjykozg/RoM6WBUKm8TprHUi+clSAapwSjdB72jV+n7bV4yEVcUs3t0
         mFGWI2khFhAPVdoFZQyjooMtRbrsi0/0fYzykHGTm6GGQR4eXw7RSkqq+qmBJqyNoWHj
         mj++DcyEnXH73PCDBG0XRf6SIr5k4yJMIQXFUVD4lx4/CBFCPgh3wYnx3B0Em/f+zMEZ
         KzN/e+db7l/NjNS5CstS6F3gR4zuOojdfTudOiRbQIWiKoWrGhT+bauuEWJtcnbRIop5
         Grww==
X-Gm-Message-State: ANhLgQ28l4Qx+LR6bxRdFrh8lJmT2XrPE3N6LN/cVTCg3CeOIC+/G4SG
        5zqTneAtgqhPAGAXeGsty0cA85B6atk=
X-Google-Smtp-Source: ADFU+vt1ONZGY5SRKKF17jFQVf8Ngj037vB9YGTPO+YdcOReGYWmOeFAvqo29kr7wQE2SPFxy2U4Jw==
X-Received: by 2002:a63:7c02:: with SMTP id x2mr2847856pgc.236.1584411108831;
        Mon, 16 Mar 2020 19:11:48 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f19sm700769pgf.33.2020.03.16.19.11.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 19:11:48 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 6/6] gatt: Enable connecting to EATT channel using Ext-Flowctl mode
Date:   Mon, 16 Mar 2020 19:11:41 -0700
Message-Id: <20200317021141.16398-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317021141.16398-1-luiz.dentz@gmail.com>
References: <20200317021141.16398-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of BT_IO_MODE_EXT_FLOWCTL to connect to EATT channels.
---
 src/gatt-client.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 20efb7ae9..f7e5f38f4 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -2185,6 +2185,9 @@ static void eatt_connect(struct btd_gatt_client *client)
 	DBG("Connection attempt to: %s", addr);
 
 	for (i = bt_att_get_channels(att); i < main_opts.gatt_channels; i++) {
+		int defer_timeout = i + 1 < main_opts.gatt_channels ? 1 : 0;
+
+		/* Attempt to connect using the Ext-Flowctl */
 		io = bt_io_connect(eatt_connect_cb, client, NULL, &gerr,
 					BT_IO_OPT_SOURCE_BDADDR,
 					btd_adapter_get_address(adapter),
@@ -2194,15 +2197,34 @@ static void eatt_connect(struct btd_gatt_client *client)
 					device_get_address(dev),
 					BT_IO_OPT_DEST_TYPE,
 					device_get_le_address_type(dev),
+					BT_IO_OPT_MODE, BT_IO_MODE_EXT_FLOWCTL,
 					BT_IO_OPT_PSM, BT_ATT_EATT_PSM,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 					BT_IO_OPT_MTU, main_opts.gatt_mtu,
+					BT_IO_OPT_DEFER_TIMEOUT, defer_timeout,
 					BT_IO_OPT_INVALID);
 		if (!io) {
-			error("EATT bt_io_connect(%s): %s", addr,
-							gerr->message);
 			g_error_free(gerr);
-			return;
+			/* Fallback to legacy LE Mode */
+			io = bt_io_connect(eatt_connect_cb, client, NULL, &gerr,
+					BT_IO_OPT_SOURCE_BDADDR,
+					btd_adapter_get_address(adapter),
+					BT_IO_OPT_SOURCE_TYPE,
+					btd_adapter_get_address_type(adapter),
+					BT_IO_OPT_DEST_BDADDR,
+					device_get_address(dev),
+					BT_IO_OPT_DEST_TYPE,
+					device_get_le_address_type(dev),
+					BT_IO_OPT_PSM, BT_ATT_EATT_PSM,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_MTU, main_opts.gatt_mtu,
+					BT_IO_OPT_INVALID);
+			if (!io) {
+				error("EATT bt_io_connect(%s): %s", addr,
+							gerr->message);
+				g_error_free(gerr);
+				return;
+			}
 		}
 
 		g_io_channel_unref(io);
-- 
2.21.1

