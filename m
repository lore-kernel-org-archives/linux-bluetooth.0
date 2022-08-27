Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115E7ECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Aug 2022 00:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiH0AFs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 20:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiH0AFq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 20:05:46 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45DEBB906
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 17:05:44 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r69so2741561pgr.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 17:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=Y9UeP1LMUCj9M1cIMDaXSsm/TaUly8MjK/WdqL6cyXE=;
        b=X3XG/qd2SbIzw00ZpePIE71MCVtmIpRN/fasobZQZ6gPHUggus/XODQbcRu58jPjs8
         N8ZasJuR0oBH2+VA0rF9k80/8Z2ok5d26Lq0LxEaAJabsByLq+CZrPgiwAWPw6Twwxt2
         Hokcxqkm75DQPQxqie1yRmevV5X33HTSaoqGXo6HLJo/m1APbwXKfmfHq0yvMQi5d+qM
         ztnBy2VFzPKHLdHkZZeL7IIn32lfdtv2wPNnRQAG87GLp0rJyE2YU0lo6X9xWBsU+SnT
         yriU0+2WGyZClGZN5AL2zajWRWRZ2Kb6t4B+hI4uL/jhaQ537R6LpSNfI64o1HINQ2qq
         QVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=Y9UeP1LMUCj9M1cIMDaXSsm/TaUly8MjK/WdqL6cyXE=;
        b=2NxFgt4ZRW67SVXc5+UUdogdkRz/nR8iYnViqYs4dfpKXMfCdrGWxf/FgJtCcx6dxD
         gCCHzo2gYyHnscOEC91rCEQx2ftcGw9+EtiR9HGDZmc+BZrXE8q3lDbKYGViCIXlHm10
         T2zxPQUCe9Ix+VxbP3mf12bE2CGyWZaRvnKeFWJ2vx9ojXEO2OvsJwO0YHay4/bS40cB
         cyr/SEc7SyhNg80936g1HSFVzgN5ViRde8NTRzrtzpBTherqfFRDhX8rqUGbydqsLYbg
         o2u/kGk4fvAav+bqS6O84ETM8OCGGtv2utQ+PtkfgyWCgg01VZXE7Mw2jV3QjRPzqWrH
         PYIw==
X-Gm-Message-State: ACgBeo1D71joy5VgZXL+dQSl+tQmCIBYBB1FjsC643qyN4ZVJXJYy9Co
        yAkYUFOfHUX2L0fzLyHf3nL9tM46+ho=
X-Google-Smtp-Source: AA6agR6+2P3PaQIzaw7IA0/CDzloM+oIqZihUCoAZS5ESG7rEoFEq5EXJbZp8qizSqNiXyjSuPMO5w==
X-Received: by 2002:a65:4682:0:b0:41d:f44b:4227 with SMTP id h2-20020a654682000000b0041df44b4227mr4991193pgr.381.1661558743707;
        Fri, 26 Aug 2022 17:05:43 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o1-20020a17090a168100b001fa8b909ef0sm2249487pja.7.2022.08.26.17.05.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 17:05:43 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 01/11] adapter: Add btd_adapter_find_device_by_fd
Date:   Fri, 26 Aug 2022 17:05:30 -0700
Message-Id: <20220827000540.113414-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827000540.113414-1-luiz.dentz@gmail.com>
References: <20220827000540.113414-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds btd_adapter_find_device_by_fd that lookup a device by a fd
socket destination address.
---
 src/adapter.c | 33 +++++++++++++++++++++++++++++++++
 src/adapter.h |  1 +
 2 files changed, 34 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index b453e86a03c1..51b099daefdf 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1383,6 +1383,39 @@ struct btd_device *btd_adapter_get_device(struct btd_adapter *adapter,
 	return adapter_create_device(adapter, addr, addr_type);
 }
 
+struct btd_device *btd_adapter_find_device_by_fd(int fd)
+{
+	bdaddr_t src, dst;
+	uint8_t dst_type;
+	GIOChannel *io = NULL;
+	GError *gerr = NULL;
+	struct btd_adapter *adapter;
+
+	io = g_io_channel_unix_new(fd);
+	if (!io)
+		return NULL;
+
+	bt_io_get(io, &gerr,
+			BT_IO_OPT_SOURCE_BDADDR, &src,
+			BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_DEST_TYPE, &dst_type,
+			BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("bt_io_get: %s", gerr->message);
+		g_error_free(gerr);
+		g_io_channel_unref(io);
+		return NULL;
+	}
+
+	g_io_channel_unref(io);
+
+	adapter = adapter_find(&src);
+	if (!adapter)
+		return NULL;
+
+	return btd_adapter_find_device(adapter, &dst, dst_type);
+}
+
 sdp_list_t *btd_adapter_get_services(struct btd_adapter *adapter)
 {
 	return adapter->services;
diff --git a/src/adapter.h b/src/adapter.h
index b09044edda70..f38f473b79d7 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -86,6 +86,7 @@ struct btd_device *btd_adapter_find_device(struct btd_adapter *adapter,
 							uint8_t dst_type);
 struct btd_device *btd_adapter_find_device_by_path(struct btd_adapter *adapter,
 						   const char *path);
+struct btd_device *btd_adapter_find_device_by_fd(int fd);
 
 void btd_adapter_update_found_device(struct btd_adapter *adapter,
 					const bdaddr_t *bdaddr,
-- 
2.37.2

