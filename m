Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5287BE80A8A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 21:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjI0Vk2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 17:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjI0Vk1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 17:40:27 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DA4121
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:40:25 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3af609c4dfeso662455b6e.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695850824; x=1696455624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X07wSkLYOjKxHCw/p4ZSA9t+KzQYCv6DrtWZMUPxG3M=;
        b=gK9CozodnHxjR4pX0/r0xvnzcgNUwc7JTrqYXatltFWMhZq+fH0QOw9Avi2Z2jUeUz
         SVJ7OJ0/9GKxzKFO5kmhPIfm2PZKPS8OB31cUx5tqABTxRfgm7YShbtLRI/52Oo5UuoN
         Qt+PmWT/O2Xn25y1/4heF3exRC1mlQWD+f+cPy4pGZAI3kEtlzRougJdZI/IKI2ZTiTy
         BJYorN3X/lBpaQvGkvF8P3BdjvK8sr5kXmLfff7ppmTirJ5h1b/r1EkAA83nQQsc1KAp
         DbbnojV6QK9jaQVzYkXvfJvP95mWUE6TlnxGuhudtqHhf1B/yRohGXuJmweCUhv2CE0d
         m2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695850824; x=1696455624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X07wSkLYOjKxHCw/p4ZSA9t+KzQYCv6DrtWZMUPxG3M=;
        b=CKTMOoJ1aacWjEallOrV93slxvQaJsKbCWFTJtrqnsyY6d8gGS4TeTyVBsHsCbTGpB
         BMtGb4yW7OKivd/I1Z8BQfE0hQj3590mH4svfYGEU414PxZt1uqWZn1L9Q6fyoKvI7Mr
         GLxxozwyt6gjAd0zOYppthCLbwiC7GZKlSUrcl47RoJ4kt0HJcjDATGF5KYC5Pp0stbY
         NJeebNA6rWRH0tjVYLepUBap5yhUllHjvyq1SZ9eFdNWAJX4QnEgtFX+8jm7yv4pRcvS
         4kePhP/EqYI6WG9EpWjY+lomKKHuHVsDrR4w2KpEy5ko3cZ1PYUfMAmnqv0NrRttWB92
         126g==
X-Gm-Message-State: AOJu0YwK4+eE938RrtcbXrERrDchRlFfwGSNmQroakbkMzL/qr8sXhCB
        e+s+rhKqKYkPFYGjpdH3FqomQacmcVlqGZnl
X-Google-Smtp-Source: AGHT+IHfr9TKzYbos089zoeg1+JpfxyRzsQwecAI54HDnoOCdLvQuosEyvZpulNQ2cTao9w1xsOPTg==
X-Received: by 2002:a05:6808:1a24:b0:3a4:633:44d2 with SMTP id bk36-20020a0568081a2400b003a4063344d2mr3945719oib.18.1695850823796;
        Wed, 27 Sep 2023 14:40:23 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b00672ea40b8a9sm12546004pfe.170.2023.09.27.14.40.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 14:40:22 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 09/12] shared/bap: Add support for location and contexts to bt_bap_pac_qos
Date:   Wed, 27 Sep 2023 14:40:00 -0700
Message-ID: <20230927214003.1873224-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927214003.1873224-1-luiz.dentz@gmail.com>
References: <20230927214003.1873224-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for location and contexts to bt_bap_pac_qos and
function to read them.
---
 src/shared/bap.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/bap.h |  6 ++++++
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 6400d1d69221..9e9ea1472029 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2740,7 +2740,12 @@ uint8_t bt_bap_pac_get_type(struct bt_bap_pac *pac)
 
 uint32_t bt_bap_pac_get_locations(struct bt_bap_pac *pac)
 {
-	struct bt_pacs *pacs = pac->bdb->pacs;
+	struct bt_pacs *pacs;
+
+	if (!pac)
+		return 0;
+
+	pacs = pac->bdb->pacs;
 
 	switch (pac->type) {
 	case BT_BAP_SOURCE:
@@ -2752,6 +2757,52 @@ uint32_t bt_bap_pac_get_locations(struct bt_bap_pac *pac)
 	}
 }
 
+uint16_t bt_bap_pac_get_supported_context(struct bt_bap_pac *pac)
+{
+	struct bt_pacs *pacs;
+
+	if (!pac)
+		return 0;
+
+	pacs = pac->bdb->pacs;
+
+	switch (pac->type) {
+	case BT_BAP_SOURCE:
+		return pacs->supported_source_context_value;
+	case BT_BAP_SINK:
+		return pacs->supported_sink_context_value;
+	default:
+		return 0;
+	}
+}
+
+uint16_t bt_bap_pac_get_context(struct bt_bap_pac *pac)
+{
+	struct bt_pacs *pacs;
+
+	if (!pac)
+		return 0;
+
+	pacs = pac->bdb->pacs;
+
+	switch (pac->type) {
+	case BT_BAP_SOURCE:
+		return pacs->source_context_value;
+	case BT_BAP_SINK:
+		return pacs->sink_context_value;
+	default:
+		return 0;
+	}
+}
+
+struct bt_bap_pac_qos *bt_bap_pac_get_qos(struct bt_bap_pac *pac)
+{
+	if (!pac || !pac->qos.phy)
+		return NULL;
+
+	return &pac->qos;
+}
+
 uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream)
 {
 	if (!stream)
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 72d6022a32ec..ebe4dbf7d858 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -168,6 +168,12 @@ uint8_t bt_bap_pac_get_type(struct bt_bap_pac *pac);
 
 uint32_t bt_bap_pac_get_locations(struct bt_bap_pac *pac);
 
+uint16_t bt_bap_pac_get_supported_context(struct bt_bap_pac *pac);
+
+uint16_t bt_bap_pac_get_context(struct bt_bap_pac *pac);
+
+struct bt_bap_pac_qos *bt_bap_pac_get_qos(struct bt_bap_pac *pac);
+
 uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
 
 struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac);
-- 
2.41.0

