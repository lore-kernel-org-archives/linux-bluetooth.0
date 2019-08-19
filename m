Return-Path: <SRS0=9IM7=WP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94802C3A59D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Aug 2019 09:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A35C2087E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Aug 2019 09:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="RpReEYwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfHSJdg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Aug 2019 05:33:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41072 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfHSJdf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Aug 2019 05:33:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id j16so7945991wrr.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2019 02:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ehNaPZXcJIb49vOrtmr0pHbP9NuT9Sx4pMktWxbAVp4=;
        b=RpReEYwmrzUF9sHyiivZNdoBPMINpW0Ki4JdphnemjNuMgTjHSg+MV1D7mwiUZSMZm
         wKp6h0e0dY7rvMgrWuqCJSG2ckxNorznasknGSLxYkcoVnqryvYoMWufQj3jyVPpKrQe
         7ScMa+s0U7BKP0Z8qg3YUBjhyGFHSs9oQLwq8VyCWUHEOq+ECnNXJVJRyU5goRajotWQ
         tMpTiac68f/uTJgpm5sxa6F0xqcDFRsfmLkbPLOdJfsvrNbuMw5Lz6Nq2aNuM8ErAdGf
         9/nGuoI8gyUqgwVwKzvkjg7Eb2Z+2Gri4ae2h71fXQikL2vXdklAd8eTuOMBkx1ApnQM
         og+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ehNaPZXcJIb49vOrtmr0pHbP9NuT9Sx4pMktWxbAVp4=;
        b=Tw2M0vDTRI2QvcFMhAizYESSH0N+Sn1+/SoYjVAYfFxnUz2tfwd2eSdtXp3zd2f+TB
         FdL2w4vgHWpZ6UddthHgmfdIDTVyj0/wNjDuqoEa+liNDdT50H49SbYkjO1bIDwlK6AR
         Qy6Zd+xTx3T2/SjiL5QtaGJIBVGOqvbxWCyFrK541KCTDxg81x3ckYrFSuePEddCs/QR
         4NUtNe7kkvq88KFmbZ3v9P276VTgPhqkPdmEn+ca7rFRpCIWcRM5abJfx4i5Gi26uBqF
         duIhZRfO2CVl4AhqtKchzTKrymNy0A69yFbdtWZXhxSoBm3oVXFd4iH27o6KHUWwrXTb
         wfkQ==
X-Gm-Message-State: APjAAAXy3bvvvZu4rw9KxDOVFTRxabYpdoyv7r1qBih5lnUbI1Fnrxre
        SvCD3yoXP1EHo0kD6Y1lIZT+NH79HiM=
X-Google-Smtp-Source: APXvYqxwp5CDfoN7xBh44tMQjApEuE0fPlVqG8DJfmLzGM6I9ZAwXuGijIBK2cjjACCkBfWo6u48gg==
X-Received: by 2002:a5d:4703:: with SMTP id y3mr27765385wrq.63.1566207213481;
        Mon, 19 Aug 2019 02:33:33 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id o9sm21675360wrm.88.2019.08.19.02.33.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 02:33:32 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] mesh: Normalize Access Key AID and Index naming in models
Date:   Mon, 19 Aug 2019 11:33:22 +0200
Message-Id: <20190819093324.10566-3-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190819093324.10566-1-michal.lowas-rzechonek@silvair.com>
References: <20190819093324.10566-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

After 8f0839a1c46300ceb1b129d17a3bff446ff79d08, mesh/crypto uses _aid
suffix for keys' AID property, so let's change the wording in mesh/model
as well.
---
 mesh/model.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index 8f3d67ecf..2ecaf00e9 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -355,7 +355,7 @@ static void forward_model(void *a, void *b)
 
 static int dev_packet_decrypt(struct mesh_node *node, const uint8_t *data,
 				uint16_t size, bool szmict, uint16_t src,
-				uint16_t dst, uint8_t key_id, uint32_t seq,
+				uint16_t dst, uint8_t key_aid, uint32_t seq,
 				uint32_t iv_idx, uint8_t *out)
 {
 	uint8_t dev_key[16];
@@ -366,7 +366,7 @@ static int dev_packet_decrypt(struct mesh_node *node, const uint8_t *data,
 		return -1;
 
 	if (mesh_crypto_payload_decrypt(NULL, 0, data, size, szmict, src,
-					dst, key_id, seq, iv_idx, out, key))
+					dst, key_aid, seq, iv_idx, out, key))
 		return APP_IDX_DEV_LOCAL;
 
 	if (!keyring_get_remote_dev_key(node, src, dev_key))
@@ -374,7 +374,7 @@ static int dev_packet_decrypt(struct mesh_node *node, const uint8_t *data,
 
 	key = dev_key;
 	if (mesh_crypto_payload_decrypt(NULL, 0, data, size, szmict, src,
-					dst, key_id, seq, iv_idx, out, key))
+					dst, key_aid, seq, iv_idx, out, key))
 		return APP_IDX_DEV_REMOTE;
 
 	return -1;
@@ -382,7 +382,7 @@ static int dev_packet_decrypt(struct mesh_node *node, const uint8_t *data,
 
 static int virt_packet_decrypt(struct mesh_net *net, const uint8_t *data,
 				uint16_t size, bool szmict, uint16_t src,
-				uint16_t dst, uint8_t key_id, uint32_t seq,
+				uint16_t dst, uint8_t key_aid, uint32_t seq,
 				uint32_t iv_idx, uint8_t *out,
 				struct mesh_virtual **decrypt_virt)
 {
@@ -397,7 +397,8 @@ static int virt_packet_decrypt(struct mesh_net *net, const uint8_t *data,
 
 		decrypt_idx = appkey_packet_decrypt(net, szmict, seq,
 							iv_idx, src, dst,
-							virt->label, 16, key_id,
+							virt->label, 16,
+							key_aid,
 							data, size, out);
 
 		if (decrypt_idx >= 0) {
@@ -768,7 +769,7 @@ static void send_dev_key_msg_rcvd(struct mesh_node *node, uint8_t ele_idx,
 }
 
 static void send_msg_rcvd(struct mesh_node *node, uint8_t ele_idx, bool is_sub,
-					uint16_t src, uint16_t key_idx,
+					uint16_t src, uint16_t app_idx,
 					uint16_t size, const uint8_t *data)
 {
 	struct l_dbus *dbus = dbus_get_bus();
@@ -790,7 +791,7 @@ static void send_msg_rcvd(struct mesh_node *node, uint8_t ele_idx, bool is_sub,
 	builder = l_dbus_message_builder_new(msg);
 
 	l_dbus_message_builder_append_basic(builder, 'q', &src);
-	l_dbus_message_builder_append_basic(builder, 'q', &key_idx);
+	l_dbus_message_builder_append_basic(builder, 'q', &app_idx);
 	l_dbus_message_builder_append_basic(builder, 'b', &is_sub);
 
 	dbus_append_byte_array(builder, data, size);
-- 
2.19.1

