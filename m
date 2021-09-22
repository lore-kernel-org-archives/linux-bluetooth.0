Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E421C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Sep 2021 21:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A36F611C4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Sep 2021 21:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238072AbhIVVff (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 17:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237770AbhIVVfe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 17:35:34 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6874BC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Sep 2021 14:34:04 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id m26so3868113pff.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Sep 2021 14:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cx6jB6FiEleLmTENrAZdQJGZ+h0Ab38YCK0MLNI63JY=;
        b=VD/jvgN8m4Khe3GUhWBiEBIOhcKUEoRErooRgcpExWwSdjCmUScIAlgU/WSypOj3Up
         U55wTdXrWocaaVJ0PaAv1hutQZjLp4WqCVC51pJYAKawCFDNMMkbh29XYzRMa7s5XLjY
         Y/x6GsyVc/R+tlL7pu3uPolTyy3BnMafPDQkVbIcQ13TjBOxICeTaBkTHWhT5Heh6p1Q
         vytps03zBjkjP1d0VR7hkt6LMK7N3HsBUrNYMkWeVF2ALRnCc/A7jP7N0q2TlMLOKwOH
         ivmgWnMgbKuQ5TVvvsBjpS3vRcCtSMZVy2FscvZEYiZgiSFcP15DoIAommIBur+dMogr
         mgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cx6jB6FiEleLmTENrAZdQJGZ+h0Ab38YCK0MLNI63JY=;
        b=YsbFHrAl+iNm/8eVsurfU/O4LXEFcVmENvGHYVeVNXNlrk2LzY954FI+ioowCksPDS
         l1i1KqefafLMGcBjo+xyvHrDBoIIMFibES9DxY1eXVcpSxAswvsmEtS3E8SUdOUTcLPr
         zRsASjAzsonkD92PtabL8+vxBcVooQwoB8uwosiNVhKJcauoX06MrOlZkjrnjmJLV4qV
         8tEgUwZs7tGj3wAsPai892rSNP6FlmOS9bFkJWsk6CO5jXTIQx0yWnLEk4rkRzwlfeJt
         JR1OoawJZ+b6fT9hK/or6Bq5k5zGan3/oshz2pUcepo81BmlnAkImADX8Z67mMc3wZiE
         /rjA==
X-Gm-Message-State: AOAM5318LkQX3Ttt9NVHYQN0GI87VrXRTK7vP3EhuTL7S+BX10u4MLOf
        nrPFbdGtJs1HPhxS3PUoA6fQZXTEjs4=
X-Google-Smtp-Source: ABdhPJwiy8xiJal9lP3AKjTReWrIsDU0goAVsdUUnMufjGf06+MHIJh4UsIlIU2xgtJlQuxAljQvgA==
X-Received: by 2002:a63:950f:: with SMTP id p15mr941427pgd.265.1632346443447;
        Wed, 22 Sep 2021 14:34:03 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i12sm6378596pjv.19.2021.09.22.14.34.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 14:34:03 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] shared/mgmt: Set MTU to UINT16_MAX
Date:   Wed, 22 Sep 2021 14:33:59 -0700
Message-Id: <20210922213402.1978215-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This sets MTU of MGMT socket to UINT16_MAX since some commands may
require more than the default size (e.g. Load LTKs).

Fixes: https://github.com/bluez/bluez/issues/201
---
 src/shared/mgmt.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index b869fa6ef..cec8993e7 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -42,6 +42,7 @@ struct mgmt {
 	bool in_notify;
 	void *buf;
 	uint16_t len;
+	uint16_t mtu;
 	mgmt_debug_func_t debug_callback;
 	mgmt_destroy_func_t debug_destroy;
 	void *debug_data;
@@ -380,6 +381,32 @@ static bool can_read_data(struct io *io, void *user_data)
 	return true;
 }
 
+static void mgmt_set_mtu(struct mgmt *mgmt)
+{
+	socklen_t len = 0;
+
+	/* Check if kernel support BT_SNDMTU to read the current MTU set */
+	if (getsockopt(mgmt->fd, SOL_BLUETOOTH, BT_SNDMTU, &mgmt->mtu,
+							&len) < 0) {
+		/* If BT_SNDMTU is not supported then MTU cannot be changed and
+		 * MTU is fixed to HCI_MAX_ACL_SIZE.
+		 */
+		mgmt->mtu = HCI_MAX_ACL_SIZE;
+		return;
+	}
+
+	if (mgmt->mtu < UINT16_MAX) {
+		uint16_t mtu = UINT16_MAX;
+
+		/* Try increasing the MTU since some commands may go
+		 * over HCI_MAX_ACL_SIZE (1024)
+		 */
+		if (!setsockopt(mgmt->fd, SOL_BLUETOOTH, BT_SNDMTU, &mtu,
+							sizeof(mtu)))
+			mgmt->mtu = mtu;
+	}
+}
+
 struct mgmt *mgmt_new(int fd)
 {
 	struct mgmt *mgmt;
@@ -423,6 +450,8 @@ struct mgmt *mgmt_new(int fd)
 
 	mgmt->writer_active = false;
 
+	mgmt_set_mtu(mgmt);
+
 	return mgmt_ref(mgmt);
 }
 
@@ -534,9 +563,9 @@ bool mgmt_set_close_on_unref(struct mgmt *mgmt, bool do_close)
 	return true;
 }
 
-static struct mgmt_request *create_request(uint16_t opcode, uint16_t index,
-				uint16_t length, const void *param,
-				mgmt_request_func_t callback,
+static struct mgmt_request *create_request(struct mgmt *mgmt, uint16_t opcode,
+				uint16_t index, uint16_t length,
+				const void *param, mgmt_request_func_t callback,
 				void *user_data, mgmt_destroy_func_t destroy)
 {
 	struct mgmt_request *request;
@@ -548,6 +577,11 @@ static struct mgmt_request *create_request(uint16_t opcode, uint16_t index,
 	if (length > 0 && !param)
 		return NULL;
 
+	if (length > mgmt->mtu) {
+		printf("length %u > %u mgmt->mtu", length, mgmt->mtu);
+		return NULL;
+	}
+
 	request = new0(struct mgmt_request, 1);
 	request->len = length + MGMT_HDR_SIZE;
 	request->buf = malloc(request->len);
@@ -711,7 +745,7 @@ unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
 	if (!mgmt)
 		return 0;
 
-	request = create_request(opcode, index, length, param,
+	request = create_request(mgmt, opcode, index, length, param,
 					callback, user_data, destroy);
 	if (!request)
 		return 0;
@@ -742,7 +776,7 @@ unsigned int mgmt_send_nowait(struct mgmt *mgmt, uint16_t opcode, uint16_t index
 	if (!mgmt)
 		return 0;
 
-	request = create_request(opcode, index, length, param,
+	request = create_request(mgmt, opcode, index, length, param,
 					callback, user_data, destroy);
 	if (!request)
 		return 0;
@@ -768,7 +802,7 @@ unsigned int mgmt_reply(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
 	if (!mgmt)
 		return 0;
 
-	request = create_request(opcode, index, length, param,
+	request = create_request(mgmt, opcode, index, length, param,
 					callback, user_data, destroy);
 	if (!request)
 		return 0;
-- 
2.31.1

