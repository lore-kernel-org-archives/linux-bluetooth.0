Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B22C25B08
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Aug 2022 23:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242337AbiHQXly (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Aug 2022 19:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241321AbiHQXlx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Aug 2022 19:41:53 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6742F8A1C6
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Aug 2022 16:41:52 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id h27so37136qkk.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Aug 2022 16:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=PGmZ7DQ3cpNSfiS5ddnYWL4e9lGgSws8kjOomJcuQlA=;
        b=enYoba4viz2zGJq5e1Ez7YsD2TGS9M63xvEsLzqSxIfZUrJUUSZcEwRxV1NXzKuMLB
         O0fsS9HJhuWDsDBDKgw08jpBcIfnZBq2REWOosCEeeT05YH5BQYT16wzOU0fJbD+KEDg
         IuLmH5VAqfExBDf7YX+pnQqpQIq7zOQp58mp+5CU5SWKBf4Q/FzDPdLPhOsPD7gMXM56
         /k8ONI+UlJNuq+QeYSQ4Z2JC1egoWoBF7zrunk+2w1STW9R+PREW+hJ+5fFV+jCbvMoR
         HAEDKoBurikqAb5Pbk12I9gtt593mWzlYi55AexmnEwI3vVeO3I5UYevDYzbprOXFmZr
         Hngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=PGmZ7DQ3cpNSfiS5ddnYWL4e9lGgSws8kjOomJcuQlA=;
        b=6gLMMXPlVUI9gsUV0teFrwXNZXojlmwFRI0U4syx7u2OMngIZOKAWrkWTYEX4iRLVW
         pis5cwHalKeYgNJSRWCuRAulCi1Vc+i6BXp+5AXvxCXny99LMA0alq4oKguymUsGyYLh
         DoZMKOQ3yOTzRVW7qCEGZBPGfkN2GC/MSFrEG8BEgQqzJ9aqI2RNHQI0mFGUs3eM6vI2
         m0TwgfgZkO9PXDO+HE/eo8Fz2XmMuQ5H5vtjizCxnUR41KcvXrrY5XQBp/BjiJ5aRAH1
         8Yhqtmo5xLyld/EftttlhIkiQKQ02UB+CsL8CPJGLO6fbMZvPkZusgvbMxnTwefd0Pcs
         eifg==
X-Gm-Message-State: ACgBeo005kabGoS5T5m+DH6BHLj5klkKRp8k0z/N9SwaL3DzbsMmYG+S
        It5NfodWafYcujgWkdyKDcT0kjtVha6NYnD6
X-Google-Smtp-Source: AA6agR6G0qCosmLiKsnZ5sKI6WBaJnYig4Yo9LSzzSLr5BiD6A96ZZN1K85zz/HLbEOqBG/21P2TfQ==
X-Received: by 2002:a37:6c86:0:b0:6b9:4a99:3ab7 with SMTP id h128-20020a376c86000000b006b94a993ab7mr354831qkc.534.1660779711110;
        Wed, 17 Aug 2022 16:41:51 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r25-20020ae9d619000000b006bb2f555ba4sm189637qkk.41.2022.08.17.16.41.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 16:41:50 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/9] adapter: Add btd_adapter_find_device_by_fd
Date:   Wed, 17 Aug 2022 16:41:38 -0700
Message-Id: <20220817234146.224081-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220817234146.224081-1-luiz.dentz@gmail.com>
References: <20220817234146.224081-1-luiz.dentz@gmail.com>
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
index ec26aab1a771..d33fc9bd661c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1364,6 +1364,39 @@ struct btd_device *btd_adapter_get_device(struct btd_adapter *adapter,
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

