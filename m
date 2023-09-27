Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D19E82CC0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 21:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjI0VkJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 17:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0VkI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 17:40:08 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2C3D6
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:40:07 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-690d8fb3b7eso10889752b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695850806; x=1696455606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UZDbId/Oq6bQoYjYM1BCQT82RB8NkOnAtSqUmB0Kd0w=;
        b=KuzB7LRIUHXGG9MhBkrycDv52nC+4MIva/x3XnB5upiKYQVDm/iUB3j9OnzBbSffWw
         TBywpKUHRWybNW++hcQot35ZjYutBOvyyTxXvP1Z4RayqgSVov++FaUMQrQtK1UHSK3a
         vGkgvnP1Z+VXHFFD1OwXt10+uOIm+TaWLIT8wE0ZsDMx/HrMiETbBhPMG04oWBqe1lWQ
         B6Csdk/H74quYJJbqMmNLKveMONY2F3X5/Uuf46sF1g49IdDN5adp3nyHiah8ESNgwZs
         dt1JJWfmegdGtswql7Idm3bt6natlGhaiA5GzeI2dJhoR3Ge0uMC2Pz4KclRBxAl2+6s
         hI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695850806; x=1696455606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZDbId/Oq6bQoYjYM1BCQT82RB8NkOnAtSqUmB0Kd0w=;
        b=nXQmoYzQMTK1Nn/iz1S94oxY3UevhKyL3VfCWjH8rMcGoQpXcDuIQj83tTOhLiU9YP
         LQp/OL6xmCo/X1zAnh16MiYnlFFZn4BfzD+tQTjl7MRT+eouMwVFuDSoxf8bJnPhdYLA
         eEc+3RON9M8Dzg+rpAqBnZrqpkkTF35H45I7Tq3Mioa8VghSR6IIfDP9UDR6Jok5T2bM
         nAHaRe2KiS+WA668EswwDfYKAnDx7tt9o8Erl88AhRvdf0deRPWHhNgDfrlyY9Rbc+8C
         wPpJQnh7YGaeDIuQ6nU1dr+mGW2f5tU/jSvCVQ0C26ujSf2QumOkDdhwlK4Gdc+op1GU
         eJmg==
X-Gm-Message-State: AOJu0Yy4+1otrctJcdUHg8ivCEDBzp9lzI9N+PxuSpU+l4gIrTsu/9kC
        1uFjFH5nP04WfA+DvnT9YAHxRQ3onYxBalZR
X-Google-Smtp-Source: AGHT+IEjeadmeW3e7ehJUayzq5wu79oLTxAGjFS3b2ZAZ5gn0QnlqBagVEl+OhdHKoyjfVdfVhyQlQ==
X-Received: by 2002:aa7:8893:0:b0:690:3a0f:4165 with SMTP id z19-20020aa78893000000b006903a0f4165mr3675217pfe.32.1695850806074;
        Wed, 27 Sep 2023 14:40:06 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b00672ea40b8a9sm12546004pfe.170.2023.09.27.14.40.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 14:40:04 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] bap: Fix freeing value of dbus_message_iter_get_fixed_array
Date:   Wed, 27 Sep 2023 14:39:51 -0700
Message-ID: <20230927214003.1873224-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
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

