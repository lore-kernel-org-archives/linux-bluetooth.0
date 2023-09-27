Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C965FE80A8A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 21:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjI0Vkd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 17:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjI0Vkc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 17:40:32 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDE212A
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:40:30 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7741b18a06aso730369885a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695850829; x=1696455629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZDbId/Oq6bQoYjYM1BCQT82RB8NkOnAtSqUmB0Kd0w=;
        b=nSn/QFh3oJUqNf/SVdBIfrnZuJrkdXW2fFP+ZWn1k0jNm2MzrL5arolTn7g9bdNGge
         F8+uR5nEH6KefXRWPyZNUKMHu2nhQjtWDF9URlhYLOKVK8XYlkRbRHMCbm3JkMBiclov
         VVH8oDt3GcRVBxugnZOFTzgXd4cZnZ+q2/EtbM3FuNGhrIqEYnlONAMyhi7B/y6HOr4G
         bknrIa5dCgD2jW4hZSyrS0u83f1Vej8AYkw6WpuHUQ+BftdOlN6Gx6Tr3k/dQAxIcMCG
         YW7BKKNzsgf/AIiucw3BKYC2zjDaeBmtsFeWgRf8d0DdLkolGF8lsgoGrXDvT8lcqCPx
         xufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695850829; x=1696455629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZDbId/Oq6bQoYjYM1BCQT82RB8NkOnAtSqUmB0Kd0w=;
        b=r3PDTjLH0ZYI/AVM5Czejod07izh4Cbuxtpvf4EIXxMYEHbahLfJNzGJ69kyzzAYBe
         yLTc4RVN7jpzv+a6XaJlQA0goBof/WepEN1ZzKh6PfeEDa1Fg7EilzV7wtWsKnR5mKU2
         IXg17T4aU5mKxn8FH+bWHj8a9E8GoVU/OPTXGMQ5gJ2JojLrJ5ZKYdWix2MY0eXnTAmA
         QC+VQIWcFUIHL6TsWOIExY3j3Rmgpd+pYm1yui5m8hsnzpP2KwTjQ74cyMAkD7NIMRTc
         o/Cv/bb0wWQ7uT4azb+9i1fzXITNjYjNehkUG4/f2uS8Mif8knhE7w8jXxo9axKN1XA6
         4N/A==
X-Gm-Message-State: AOJu0Yy/Q8o/zadFetwImPYj0vW6jHOX5e5F54EV6K9Vo68DVMnfhmCr
        nvTk8EmaOGuw0XlESDcv5p2SpzaY+sQc0xTO
X-Google-Smtp-Source: AGHT+IEWT7/Y2regfcxchE/qqtqxhAlngMHkAJUXyUMxUWRAx2FZno/9rPTHJhzxbRnhvuMVZXPkIw==
X-Received: by 2002:a05:620a:448f:b0:774:226b:c327 with SMTP id x15-20020a05620a448f00b00774226bc327mr4183872qkp.67.1695850829165;
        Wed, 27 Sep 2023 14:40:29 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b00672ea40b8a9sm12546004pfe.170.2023.09.27.14.40.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 14:40:28 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 12/12] bap: Fix freeing value of dbus_message_iter_get_fixed_array
Date:   Wed, 27 Sep 2023 14:40:03 -0700
Message-ID: <20230927214003.1873224-13-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927214003.1873224-1-luiz.dentz@gmail.com>
References: <20230927214003.1873224-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The value returned by dbus_message_iter_get_fixed_array is a reference
and shall not be freed:

 'The returned value is by reference and should not be freed.'
---
 profiles/audio/bap.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 18872329d4ac..48a1a4f86f8d 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -365,19 +365,17 @@ static const GDBusPropertyTable ep_properties[] = {
 	{ }
 };
 
-static int parse_array(DBusMessageIter *iter, struct iovec **iov)
+static int parse_array(DBusMessageIter *iter, struct iovec *iov)
 {
 	DBusMessageIter array;
 
 	if (!iov)
 		return 0;
 
-	if (!(*iov))
-		*iov = new0(struct iovec, 1);
-
 	dbus_message_iter_recurse(iter, &array);
-	dbus_message_iter_get_fixed_array(&array, &(*iov)->iov_base,
-						(int *)&(*iov)->iov_len);
+	dbus_message_iter_get_fixed_array(&array, &iov->iov_base,
+						(int *)&iov->iov_len);
+
 	return 0;
 }
 
@@ -594,10 +592,15 @@ static int parse_bcast_qos(const char *key, int var, DBusMessageIter *iter,
 
 		dbus_message_iter_get_basic(iter, &qos->bcast.timeout);
 	} else if (!strcasecmp(key, "BCode")) {
+		struct iovec iov;
+
 		if (var != DBUS_TYPE_ARRAY)
 			return -EINVAL;
 
-		parse_array(iter, &qos->bcast.bcode);
+		parse_array(iter, &iov);
+
+		util_iov_free(qos->bcast.bcode, 1);
+		qos->bcast.bcode = util_iov_dup(&iov, 1);
 	} else {
 		int err;
 
@@ -653,6 +656,9 @@ static int parse_configuration(DBusMessageIter *props, struct iovec **caps,
 				struct bt_bap_qos *qos)
 {
 	const char *key;
+	struct iovec iov;
+
+	memset(&iov, 0, sizeof(iov));
 
 	while (dbus_message_iter_get_arg_type(props) == DBUS_TYPE_DICT_ENTRY) {
 		DBusMessageIter value, entry;
@@ -670,14 +676,20 @@ static int parse_configuration(DBusMessageIter *props, struct iovec **caps,
 			if (var != DBUS_TYPE_ARRAY)
 				goto fail;
 
-			if (parse_array(&value, caps))
+			if (parse_array(&value, &iov))
 				goto fail;
+
+			util_iov_free(*caps, 1);
+			*caps = util_iov_dup(&iov, 1);
 		} else if (!strcasecmp(key, "Metadata")) {
 			if (var != DBUS_TYPE_ARRAY)
 				goto fail;
 
-			if (parse_array(&value, metadata))
+			if (parse_array(&value, &iov))
 				goto fail;
+
+			util_iov_free(*metadata, 1);
+			*metadata = util_iov_dup(&iov, 1);
 		} else if (!strcasecmp(key, "QoS")) {
 			if (var != DBUS_TYPE_ARRAY)
 				goto fail;
@@ -1202,6 +1214,7 @@ static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *caps,
 		goto done;
 	}
 
+	util_iov_free(ep->caps, 1);
 	ep->caps = util_iov_dup(caps, 1);
 
 	if (metadata && metadata->iov_base && metadata->iov_len) {
-- 
2.41.0

