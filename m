Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55252ECAAD5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Aug 2022 23:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345495AbiHZXUj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 19:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344880AbiHZXUh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 19:20:37 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E385B5A63
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 16:20:36 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 202so2653911pgc.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 16:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=Y9UeP1LMUCj9M1cIMDaXSsm/TaUly8MjK/WdqL6cyXE=;
        b=TgPdfpW5b2iThVM3B8uZQxcudwAScvfnuxL/NC4HhMRwomeQaHhyulQ4cHFe8OvhES
         QTWax5sWqRf2lR/BZZIrtcef7v6VsQ4QYWhKPbHrByV6atqwjJfJsx3eH8el/SOAd4Ob
         U1uAKts5Y/4b31/TjlVS8WEG9RL+I/c+kgotV2MU4c0MuXv5EBwRzE0y8LHv3J6cZaz9
         F4Vw2xdxWcAu4B4zBxYNF059B5QXnOw0sV5V1wX6G1XnGfVuQ2L+8KIUOqOjjkF++Y3z
         w/CEdLz1sPwpnGJYx4U7FVZL/bV2xd7uRcsYxcYfHPGy2uVVOCbk/jzbDWyJ6C1TPWLI
         7icA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=Y9UeP1LMUCj9M1cIMDaXSsm/TaUly8MjK/WdqL6cyXE=;
        b=45EfhmWlwgd5NWZJZF8hamBWITPViUrX6b99V0W2cPeV86LUQGyLFAo+MqJtMXzanv
         BlbIUqKpDm9qAbG626fZMcPkLM+Baz+ca3LHdFtal1iIEGztcE3diSf7DF9W2GqJVf6/
         I8Ed2ySBQYp023AhV5uhBg9ef+TUNpXW2ujFMt+vy20NeVISEkA1/61AEx5gAFIiCkIL
         UYtj4WxMKCysXxOLgmYXJ5qX6NaEa6Nmz2dJ47lXii9RgANv1b9W9PNW6YrtMnRO85md
         o4UrkJOtxFAtOoeo1TTYW1rpNL1U5uw8vrG/VA9S1BvZ3lxzjB+sCdBGab1MN34jiHl8
         U3Kw==
X-Gm-Message-State: ACgBeo0rsmmxN5I6ZFAH41WCAloK+aiy3ivdE52dYDCThBQFcom14hF4
        c/QpBL6/j8es6kM06qNFtK3T8TtKGYA=
X-Google-Smtp-Source: AA6agR7j+4Mb6deeWC4PXW4Up0m2uQpwouqkkRrXbDBHW3E6jI0mdUbekpvC2jiCcAFx4mFFJYwIdw==
X-Received: by 2002:a63:2265:0:b0:42b:b14:7b42 with SMTP id t37-20020a632265000000b0042b0b147b42mr4921697pgm.528.1661556035319;
        Fri, 26 Aug 2022 16:20:35 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n15-20020aa7984f000000b0053645475a6dsm2312338pfq.66.2022.08.26.16.20.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 16:20:34 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/9] adapter: Add btd_adapter_find_device_by_fd
Date:   Fri, 26 Aug 2022 16:20:23 -0700
Message-Id: <20220826232031.20391-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220826232031.20391-1-luiz.dentz@gmail.com>
References: <20220826232031.20391-1-luiz.dentz@gmail.com>
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

