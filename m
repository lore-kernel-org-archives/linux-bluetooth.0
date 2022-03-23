Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F63AC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 22:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345295AbiCWWlj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 18:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbiCWWli (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 18:41:38 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AA53700E
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 15:40:07 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id q11so2934086pln.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 15:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oA2b2MSFZ5xMIcZQftlPk/BJnbKEpfSvA/B3B3AZtBo=;
        b=OCoJjugXv3fAwv37gTfyfV/CRW9+mGz4qfNPMBLYwzQwoRlOOXhCYSMbwge4dCw5Zb
         ngZ7mn2bgUDST6e0Ii+1Hh2MP3K1ya/UU8iYIcZOmtyoLEz2Ppy4dNL7dnuDArjJkIYZ
         5hMoA7dczU3ZttBxQFahoeaboQlEE0V9LDRELSHFGLTbqL0O0vdvwU3WeIJQWUjMEZ+4
         rBAa7aGcOb4IKZpvzgeyQIQ8m8ov501ktmBU6eD9JrKmUCduGL1BR4JDjeSf/kKit9OW
         +j/RYz8M+8etYiha6jAMp3ifakHPZvdRn3U5ewkfA3TIXbcoG0hlO9ejRCyXN050CLra
         Ch4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oA2b2MSFZ5xMIcZQftlPk/BJnbKEpfSvA/B3B3AZtBo=;
        b=uLyX0zy2mxSS7Z4P8ZEFr+x/F9AVnlc7pBb9NTCoIAcvJ8799XT+w+NL726553Rk9b
         jdcmrGJXK714KFBA7tkioH5xhH+zZDhZlmDEhp8ASlmYX7A+vNFmXAQ7dtWr5ICWh5ZR
         W9JtpZV/49+wcslUk1roNEenBUcsZekWs6/8Sp4qybTxTWyqP58ubsXgwN1EpvL2Iam5
         wbvw/Q4338Zr1PJ+8YhDfF9gMtaP6ZtrTAdbh3uruvJpXuZgXTPwlnBMeoFn/uIqWTrk
         7ADnCBQz8xpe9hlZFX+4YynivkYXFNZbog7vvLGaYybMRu32cXMZzCW3tpcU12Q841te
         X1qQ==
X-Gm-Message-State: AOAM530wfpJHXMOxvBaPzbgNyWMJyKF6qkcSALspcrhXXcaTnAanbvr1
        JGetlUqBXGOiTGDRevyvV7R67EcUZxM=
X-Google-Smtp-Source: ABdhPJwRN43kPjKvGz8jivr0VbM2Sw/jmKlatPhEpgQ9pk9AYhCALBZrXT2l7/xvKuUdLNdZPeSQzA==
X-Received: by 2002:a17:903:2311:b0:154:609e:1e1e with SMTP id d17-20020a170903231100b00154609e1e1emr2502588plh.119.1648075206973;
        Wed, 23 Mar 2022 15:40:06 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7888e000000b004f79f59827asm825109pfe.139.2022.03.23.15.40.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 15:40:06 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 3/9] mgmt: Introduce mgmt_set_verbose
Date:   Wed, 23 Mar 2022 15:39:57 -0700
Message-Id: <20220323224003.3736525-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323224003.3736525-1-luiz.dentz@gmail.com>
References: <20220323224003.3736525-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces mgmt_set_verbose which can be used to enable printing
the the likes hexdump of packets, by default it is disabled since in
most cases the hexdump is not very useful and there are better tools
to collect the hexdumo like btmon.
---
 src/shared/mgmt.c | 24 ++++++++++++++++++++----
 src/shared/mgmt.h |  1 +
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index c7e6a6c1d..cf518cc2b 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -50,6 +50,7 @@ struct mgmt {
 	mgmt_debug_func_t debug_callback;
 	mgmt_destroy_func_t debug_destroy;
 	void *debug_data;
+	bool verbose;
 };
 
 struct mgmt_request {
@@ -192,6 +193,15 @@ static void mgmt_log(struct mgmt *mgmt, const char *format, ...)
 	va_end(ap);
 }
 
+static void mgmt_hexdump(struct mgmt *mgmt, char dir, const void *data,
+							size_t len)
+{
+	if (!mgmt->verbose)
+		return;
+
+	util_hexdump(dir, data, len, mgmt->debug_callback, mgmt->debug_data);
+}
+
 static bool send_request(struct mgmt *mgmt, struct mgmt_request *request)
 {
 	struct iovec iov;
@@ -219,8 +229,7 @@ static bool send_request(struct mgmt *mgmt, struct mgmt_request *request)
 
 	DBG(mgmt, "[0x%04x] command 0x%04x", request->index, request->opcode);
 
-	util_hexdump('<', request->buf, ret, mgmt->debug_callback,
-							mgmt->debug_data);
+	mgmt_hexdump(mgmt, '<', request->buf, ret);
 
 	queue_push_tail(mgmt->pending_list, request);
 
@@ -373,8 +382,7 @@ static bool can_read_data(struct io *io, void *user_data)
 	if (bytes_read < 0)
 		return false;
 
-	util_hexdump('>', mgmt->buf, bytes_read,
-				mgmt->debug_callback, mgmt->debug_data);
+	mgmt_hexdump(mgmt, '>', mgmt->buf, bytes_read);
 
 	if (bytes_read < MGMT_HDR_SIZE)
 		return true;
@@ -594,6 +602,14 @@ bool mgmt_set_debug(struct mgmt *mgmt, mgmt_debug_func_t callback,
 	return true;
 }
 
+void mgmt_set_verbose(struct mgmt *mgmt, bool value)
+{
+	if (!mgmt)
+		return;
+
+	mgmt->verbose = value;
+}
+
 bool mgmt_set_close_on_unref(struct mgmt *mgmt, bool do_close)
 {
 	if (!mgmt)
diff --git a/src/shared/mgmt.h b/src/shared/mgmt.h
index b413cea78..0f3e54c16 100644
--- a/src/shared/mgmt.h
+++ b/src/shared/mgmt.h
@@ -28,6 +28,7 @@ typedef void (*mgmt_debug_func_t)(const char *str, void *user_data);
 
 bool mgmt_set_debug(struct mgmt *mgmt, mgmt_debug_func_t callback,
 				void *user_data, mgmt_destroy_func_t destroy);
+void mgmt_set_verbose(struct mgmt *mgmt, bool value);
 
 bool mgmt_set_close_on_unref(struct mgmt *mgmt, bool do_close);
 
-- 
2.35.1

