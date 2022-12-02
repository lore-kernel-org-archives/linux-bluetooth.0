Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1170EC4321E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Dec 2022 00:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiLBAvE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 19:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiLBAvB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 19:51:01 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45557BBBFD
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 16:50:59 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id g10so3236741plo.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Dec 2022 16:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrUIIPrBTmjyCzYKfPEzVfSCr2e2mHMZ7ZkF84d/32s=;
        b=Ujb+NSoY5BmQHub7Ul+CCbZBTL8PyLpuAEitM/lwbgSGEJX9SbVSpMtYizeT8BqWOA
         PY32pZdTifh313p013ANLCpwckP8USWxUAR5mIa6KpkeUOiXR6335kehih9YyHHi/sD7
         /CznPbjkaSqzLHQwWuAmO4315ORv7V077AsSCDlnwSvWjzgdu5m8dZb7xF40ve50E6GX
         FvM0uL9L+1oQD/Fuf9StOjoSlXReesGVdcFTHwCaz2/wO6s60mJiPVOqzFqggbpnLEsV
         voM8Hp5JDiSUDYb6QH0KxKwFTymOhBkjj2KC1bouOZYV+RiO+1ZOQK/p7BYXjHxjm5wu
         yQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrUIIPrBTmjyCzYKfPEzVfSCr2e2mHMZ7ZkF84d/32s=;
        b=TVPGYEXpwaZism4eOlbaTwKgG082r+Ev6nBgrGTpOTBHQ5vDbVDkKtGLtLTNB6nEdx
         KX0u1AC7w66xNi6UCocgfR2IHXvVa/QvDmAr1Qsf5N6VDiLwslTT5P4rNd85jwJmjd7V
         8BLMVskzUuXKkvF5iZvt+QvncZBw/GlYShKDymYQLUXcM2N12Hcvv3o7KodL0qTUbfyD
         ZzwkeMz2QRFplJAJqrw7rCbmOMXooJRWeR0ewqEQxure9c6a7ap/PDxmA3qUn8HEsbCO
         OJ+oq/XkbtwV7VsAIuWAo3O2sBMK/FQ4G8oilMygu5mFVRP9rad7TypBOy4l1KehRSJk
         AFEQ==
X-Gm-Message-State: ANoB5pl7XNii4k6qOyXfSmXEFpq1ZDJ/AjnkVT4XRHlEU0I4Nc3mFMVD
        89EBfFb3mSigZ8aWKQYi9cdj9Kkt1eSxJQ==
X-Google-Smtp-Source: AA0mqf6QcLcmbjJpsn7263x2GZ+EaoevRhruIrl1aL9iQaQfZ9gO0ezzN4IwIyFiCbhUlS00NKbhdQ==
X-Received: by 2002:a17:903:3052:b0:189:651c:f023 with SMTP id u18-20020a170903305200b00189651cf023mr35061201pla.78.1669942258288;
        Thu, 01 Dec 2022 16:50:58 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902684e00b0018971fba556sm4246005pln.139.2022.12.01.16.50.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:50:57 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/8] media: Fix crash when transport configuration changes
Date:   Thu,  1 Dec 2022 16:50:48 -0800
Message-Id: <20221202005051.2401504-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221202005051.2401504-1-luiz.dentz@gmail.com>
References: <20221202005051.2401504-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case of BAP the same transport may be reconfigured multiple times
which means it would appears multiple times on endpoint->transports
leading to a crash when disconnecting as the code would attempt to
destroy the same object multiple times.
---
 profiles/audio/media.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index c9328ab9bd6e..6947cf96392e 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1057,6 +1057,8 @@ static int pac_config(struct bt_bap_stream *stream, struct iovec *cfg,
 
 		path = media_transport_get_path(transport);
 		bt_bap_stream_set_user_data(stream, (void *)path);
+		endpoint->transports = g_slist_append(endpoint->transports,
+								transport);
 	}
 
 	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
@@ -1064,7 +1066,7 @@ static int pac_config(struct bt_bap_stream *stream, struct iovec *cfg,
 						"SetConfiguration");
 	if (msg == NULL) {
 		error("Couldn't allocate D-Bus message");
-		media_transport_destroy(transport);
+		endpoint_remove_transport(endpoint, transport);
 		return FALSE;
 	}
 
@@ -1073,8 +1075,6 @@ static int pac_config(struct bt_bap_stream *stream, struct iovec *cfg,
 	data->cb = cb;
 	data->user_data = user_data;
 
-	endpoint->transports = g_slist_append(endpoint->transports, transport);
-
 	dbus_message_iter_init_append(msg, &iter);
 
 	path = media_transport_get_path(transport);
-- 
2.37.3

