Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4302C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 20:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344551AbiCWUPT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344544AbiCWUPQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 16:15:16 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52397635F
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 13:13:46 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id b8so2792637pjb.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 13:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oA2b2MSFZ5xMIcZQftlPk/BJnbKEpfSvA/B3B3AZtBo=;
        b=MXnoelzMi+QjHshprhZA/AEVSmHPqLrKX5O5YgsCVLdiMPIRrc1OpMgUeWmQOB4QTy
         C5MEwMWOkRqpDCA0dSwBoUgSrT7ocT6UzqWRIVC6+S5CrUm9sMs25LtTkglefJdCM56w
         KLPS5JEb1/cr1tj/xL4TslFbURXQfKjSoqpySXcMLfukndOLwCRYnhBXYZj9wmMF0ekz
         cdMS1EOK77O2N9UKPYnAS0QUbeWA1Vie91Zv72CqqKBgRHWyoYg/h9eMU+7j3hqAJNFY
         K2s/x9RSmfTeHBoFc9NFRZhdVlSEIGesxNG5KgJ8S8+3ZzaaT22COkQ+Yn5sLWc3tYbr
         Jtkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oA2b2MSFZ5xMIcZQftlPk/BJnbKEpfSvA/B3B3AZtBo=;
        b=Amc15l6uaDn8RNnXQZUc70gjKeFKIwGERQpiTDEMgeD/+s27/fhCH6UUSYQF2FGPad
         hRff1g52JG1/HAmqQOypF3zzF+u67oDYrQ852Ogt85QtQIO9jOAt4Oxa7ZPBa3SBlfte
         tzN6/jmth3iRhwmZyk28ZbRBujoP8nF9dV2rALGGXqHbrwM+z3Pymglz18dD5o2DzFVg
         rz+18G811ed5R7/8GRNvQaq4pdad0D+4I0nvYjO8pWUwVPSVX5LDj3CxlCRXPMhzmCd+
         b8L0FmpV/kl8hqP083a7ossc1z/mmVAYtvYDztpAJ/fsdEUaVC7u6ZIbRE4LzzAb3+F+
         O9Gg==
X-Gm-Message-State: AOAM532ZOfUC3YMlcwTiLTN32ieGcHxsog55FMpLHZ9w3gsDxA/xg9nL
        FfMGwPQSUU5AS2kVrAlkCpPs0Z3XH9w=
X-Google-Smtp-Source: ABdhPJxWlRC8E+RKRxsmOfHlKJ3LN5gEPusRI0SIwssSjLoUxiyITORe5z3vFhGCePiE/OiacJv0Pw==
X-Received: by 2002:a17:902:ca13:b0:153:db88:92cc with SMTP id w19-20020a170902ca1300b00153db8892ccmr1841193pld.80.1648066425590;
        Wed, 23 Mar 2022 13:13:45 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m4-20020a17090a7f8400b001bef3fc3938sm478361pjl.49.2022.03.23.13.13.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:13:45 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/9] mgmt: Introduce mgmt_set_verbose
Date:   Wed, 23 Mar 2022 13:13:35 -0700
Message-Id: <20220323201341.3596128-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323201341.3596128-1-luiz.dentz@gmail.com>
References: <20220323201341.3596128-1-luiz.dentz@gmail.com>
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

