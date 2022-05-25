Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FC0C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 May 2022 01:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242947AbiEYBGX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 May 2022 21:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242953AbiEYBGV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 May 2022 21:06:21 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD55D13D6E
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 18:06:19 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id q203so20070599iod.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 18:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=llOUVdXm7/sdMmkn1APkGXLM8PbJ9HdUQ/Mo53o+8Z8=;
        b=OP8RiIyGZxiGLhFj14udrBylR7s3QGUNmd+dOsyIVuRTPSYPji3v9DRbkJAoXlZJhV
         dEHSVKZciZ0M/X0G11eL2iu6ExIlmBRDgnyP9K73guGQOqNBsNIVSR2v1q4PNlvZqTBq
         zb0t1dpoTQhqYCeQ3sNu1JKATcSoQUirQI+HthpA50wfl8zGUomc1trgZh+IxEJL2hl8
         lO+11BzGQpZWY1Ooq5qAlMdMNEAUxD+H6HGtTmNGfuGbx93fdRbJOXD8uES1OxWZTUMb
         GEZdekgav/S24NcsMEUz61smrnMMrtj5Cntzxi3O6bKY2sH7FQLAETtyXL5tGPNp1246
         qjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=llOUVdXm7/sdMmkn1APkGXLM8PbJ9HdUQ/Mo53o+8Z8=;
        b=Ki2jnSvEshH126RyguhyDZKcFmLVE/VQWMXjq7pp55g4eY4dS7KypW3elM+HetlIXW
         3tjaOJ+JBw4SNWaAz9nH/aUxyJh7Qze3qH5UO4uSDAfJuu6y51hEAlfFLt4Ia/XZX1vC
         ElSKgxImr2aJO/RfTyKs9T04hp6U1wp0bnLCj+gaByRzXOQ9g+3tRQ9D6AtdibrJqJD2
         slE5Xu2OpUCB1ItyvePYAeNC+hjjyoZvkbVmlNBRG6H1G1ctNXYxFT+wbbdB+wbxvDaK
         spH1sTYTsSTE70f7Q5TcFE9/0lyR2Anfl9S2aY0nAOW/kpN2jjNYaHD48yQ/zGcKPmJw
         hn+Q==
X-Gm-Message-State: AOAM532TEK5VQ5V1+ju/pcvon0hvjqF1BvIo183X1XC6jPRHCFCrv/1i
        EvPVlROz6KrS4Lyobwl7Zs3QD+UG+u4=
X-Google-Smtp-Source: ABdhPJxBFTgCOlx4z7NRrtrYuGGNb8qwI7PjX1mwJs0MZXIJJvvAWiPCQz1K32taEqYgkvxgNPLm+g==
X-Received: by 2002:a05:6602:2819:b0:660:c842:2321 with SMTP id d25-20020a056602281900b00660c8422321mr9401061ioe.126.1653440778495;
        Tue, 24 May 2022 18:06:18 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f9-20020a056638022900b0032e3bf65b5esm3826730jaq.38.2022.05.24.18.06.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 18:06:17 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] monitor/att: Fix parsing of notifications
Date:   Tue, 24 May 2022 18:06:15 -0700
Message-Id: <20220525010615.3670970-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220525010615.3670970-1-luiz.dentz@gmail.com>
References: <20220525010615.3670970-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If there are multiple notifications in the same frame the callback may
alter it when using l2cap_frame_pull helpers, so instead this passes a
cloned frame with just the expected length so callbacks cannot alter
original frame.
---
 monitor/att.c   | 10 ++++++++++
 monitor/l2cap.h | 16 ++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index 27d4730fc..f4caca4ca 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -1547,6 +1547,7 @@ static void print_notify(const struct l2cap_frame *frame, uint16_t handle,
 {
 	struct gatt_db_attribute *attr;
 	struct gatt_handler *handler;
+	struct l2cap_frame clone;
 
 	print_handle(frame, handle, false);
 	print_hex_field("  Data", frame->data, len);
@@ -1564,6 +1565,15 @@ static void print_notify(const struct l2cap_frame *frame, uint16_t handle,
 	if (!handler)
 		return;
 
+	/* Use a clone if the callback is not expected to parse the whole
+	 * frame.
+	 */
+	if (len != frame->size) {
+		l2cap_frame_clone(&clone, frame);
+		clone.size = len;
+		frame = &clone;
+	}
+
 	handler->notify(frame);
 }
 
diff --git a/monitor/l2cap.h b/monitor/l2cap.h
index 19e03637a..38d40716b 100644
--- a/monitor/l2cap.h
+++ b/monitor/l2cap.h
@@ -31,11 +31,9 @@ void l2cap_frame_init(struct l2cap_frame *frame, uint16_t index, bool in,
 				uint16_t cid, uint16_t psm,
 				const void *data, uint16_t size);
 
-static inline void *l2cap_frame_pull(struct l2cap_frame *frame,
-				const struct l2cap_frame *source, uint16_t len)
+static inline void l2cap_frame_clone(struct l2cap_frame *frame,
+					const struct l2cap_frame *source)
 {
-	void *data;
-
 	if (frame != source) {
 		frame->index   = source->index;
 		frame->in      = source->in;
@@ -45,7 +43,17 @@ static inline void *l2cap_frame_pull(struct l2cap_frame *frame,
 		frame->psm     = source->psm;
 		frame->chan    = source->chan;
 		frame->mode    = source->mode;
+		frame->data    = source->data;
+		frame->size    = source->size;
 	}
+}
+
+static inline void *l2cap_frame_pull(struct l2cap_frame *frame,
+				const struct l2cap_frame *source, uint16_t len)
+{
+	void *data;
+
+	l2cap_frame_clone(frame, source);
 
 	if (source->size < len)
 		return NULL;
-- 
2.35.1

