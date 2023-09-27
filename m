Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED06E80A8A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 21:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjI0VyV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 17:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjI0VyU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 17:54:20 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A54AFB
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:54:18 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-34fe6722847so36423875ab.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695851657; x=1696456457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZDbId/Oq6bQoYjYM1BCQT82RB8NkOnAtSqUmB0Kd0w=;
        b=K3OoYXiezlxH0q5E/nc5PlxjUJzR/SDdme+slnHrTaSvADuxUi5bwVOOJ1dFpCOc0t
         +I8YDdX+1k5op5se8dGbHqLJcWOIlloT0eu39WNETu4ByPxSwN6M57oqJjnhA82DIOKk
         ph7mo+XT9axhBjPVnql0P56KprJ83X/djonI1r6N4h1DcNOi3V1cvk+qbxu//4D+8bTM
         OFNLGwLJ6nDp5fH2LA1oxpkwyWMz1gGtlPMO3vPBwqIWrlJlUDijD21/HiajUL9fb03n
         U86nU1Ks0rYLnnraTjSY4RJqkvlQNfpSizCtfmh9VxZwIhe8nPMVYnwacJLZ9QFf+qFW
         oy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695851657; x=1696456457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZDbId/Oq6bQoYjYM1BCQT82RB8NkOnAtSqUmB0Kd0w=;
        b=g6Xl/yBenatRN/EdzdVH5iarjCTGnDET9hIH8wIvWvhS/jdHSKDSGVLpEYv44kOJz8
         d/uvHOcVZeSY2KDmSyLz34yVx1LiIO/hBdHDldSEWBW08EaLFEUAk8pTzK1mYtub9bBv
         63UozhRxHXhswYAZ/gLwxxebQJ6X+UrZIpGiNEBDcgScVrCjMUBewBtMFnylwYpxtYfS
         nbVaYnXvvq8wI95JbFb7lvpp2Wfa/oMKuWFa28HWZnwBGJDx7z1wdfy7YAOvLxox2OJv
         iTOnXCsM3TrgQ/OWc8zAntM8xll8WWDfUoe45f0d40okfeL6N3Cqw9yn7QHGwwBLcav1
         1IXg==
X-Gm-Message-State: AOJu0Yx/DPFBpwKvqBpXckXSPCUgLoVNudNxPaXtO1uoQl9+4Z9zQBJL
        wkhW+0g3dkW5bcZlRK/YYuhNzWisdyPYG+H6
X-Google-Smtp-Source: AGHT+IEygfl+qJYPRQ/U4XbJfPBnTWPCDPZeOKGiUJ0W75EsN3CuSo3LlDR8UtqGjkCn1z6xWfCTkQ==
X-Received: by 2002:a05:6e02:1c07:b0:34f:20d9:74a9 with SMTP id l7-20020a056e021c0700b0034f20d974a9mr7650964ilh.11.1695851656915;
        Wed, 27 Sep 2023 14:54:16 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id g15-20020a02cd0f000000b0042bbfe3dc42sm4225331jaq.173.2023.09.27.14.54.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 14:54:15 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 12/12] bap: Fix freeing value of dbus_message_iter_get_fixed_array
Date:   Wed, 27 Sep 2023 14:53:54 -0700
Message-ID: <20230927215354.1874835-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927215354.1874835-1-luiz.dentz@gmail.com>
References: <20230927215354.1874835-1-luiz.dentz@gmail.com>
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

