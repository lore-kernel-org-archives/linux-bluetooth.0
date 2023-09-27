Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8585E82CC0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 21:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjI0VyR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 17:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjI0VyP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 17:54:15 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF45102
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:54:13 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-3512b425662so30401305ab.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695851651; x=1696456451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X07wSkLYOjKxHCw/p4ZSA9t+KzQYCv6DrtWZMUPxG3M=;
        b=ZDlD86O/aNfTsk9Ms9PYDlBctRI8f7k7F7byoMbiuMDNBSqTjDiRgKsGQG0rsW+5GJ
         pKMdMNAwXHPp/xsv8A0VTLDES+t4JrT6y0bczKITCXsLhqOB4mijSndvxs6SSqzajHnA
         0RetFxbHcoZV39fhMxOhH3gDlDCKseZWwNXfm5u3mTWfp9m0NtDTdAMOb/F2BwCq9AjX
         tJDxV+WKjoyJACBo9m3zUYAMNlMItXdoPKCdQufjta0umUk79yK+VsC00Joy8Ux49C7X
         lY8QvekDMwgii2sFqP/ZzS62vtr7YYNrZ1zx5Ec/H9at+aFffOsZkG/726m04m4UP4Gl
         2gQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695851651; x=1696456451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X07wSkLYOjKxHCw/p4ZSA9t+KzQYCv6DrtWZMUPxG3M=;
        b=OJ/z40RamzNY+GW89DyQPIQewJ/HMVbhc8Y+VH5vxM0NyFucOQYHA9oygvpZsHxeO9
         cSN6ZSrU3JU/AmjzNXobGDbNUqmbJ3bJLMZsucwggWcERPOfuY2vU8kxO1Iq2fL0uWG4
         e44iKp8Hlj+rLJUM8PzvGFA5j5Z5hhMZVVuywhJ+d6p5xxvx2gcDR1vs2Wr+l8g79H2b
         xjGplsLgAMjxHGHQ81Uh0jJTfOkh0Ld1uakxS2vKTJvjdZGTok7EGO0FbL1e4WuUnW1o
         yU3r2nlhPRt4J5EnCyFte9uYigVrcnpfccAzoK3pgaTLRp2PKQBI4SD1gr/FHEGOlSz5
         81RQ==
X-Gm-Message-State: AOJu0YwgykYPwZ5t8y1/cuvnOCHciMQorLnggBtqwhX6QpnIhEtcGL6Q
        Xn0jzxvjKkBr/Nfppm1VnOQFEeI1Cqn0VoXs
X-Google-Smtp-Source: AGHT+IE8lHV9w/lmDWinlJPUqCdYiLPaSazAh9ukyphDijXKD6gCRTQjvR4wXO7WNXHFb0J0LQG2VQ==
X-Received: by 2002:a05:6e02:1a88:b0:34f:203c:2432 with SMTP id k8-20020a056e021a8800b0034f203c2432mr4094729ilv.12.1695851651674;
        Wed, 27 Sep 2023 14:54:11 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id g15-20020a02cd0f000000b0042bbfe3dc42sm4225331jaq.173.2023.09.27.14.54.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 14:54:10 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 09/12] shared/bap: Add support for location and contexts to bt_bap_pac_qos
Date:   Wed, 27 Sep 2023 14:53:51 -0700
Message-ID: <20230927215354.1874835-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927215354.1874835-1-luiz.dentz@gmail.com>
References: <20230927215354.1874835-1-luiz.dentz@gmail.com>
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

