Return-Path: <SRS0=18cS=PX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C01DC43444
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jan 2019 14:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A0620656
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jan 2019 14:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2jjWjf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbfAOOMi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:12:38 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:43496 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730008AbfAOOMi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Jan 2019 09:12:38 -0500
Received: by mail-qt1-f173.google.com with SMTP id i7so3016749qtj.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jan 2019 06:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Hcgc2TnKILwgJXFnljthixSWKSrB7d8XKXwMinppcTM=;
        b=j2jjWjf+SPTdojREdPGkiQBtMCKmIKP9WFwMTf2CeXsw4sc6GmB0XAdpzaOzWzDZiZ
         CHjJPc+eLofK1kv3uuf3ZByIVNN8UMYVGA3KHC2n6tySaz27RfQelkwqpFp/x9bT4+A8
         u2m2Q9HYgyXcCBeebSawfkq2hLpVVnxjvXmLczDuc1MB7y0ehUirWCPVLsGQDdjRy/UR
         P3f2cxJV21Mjx1Dhe6qwpklr4xvbUE7KGxnYhy4kWA2jAGaZWubOW8OD9eLBW5Ve0LbC
         cTBA5s/Ha23nQE878ob1PlsHOZJDJFwRY4IXg/U4iYS0HQkzBpRHtDxxSrnc1Ji5rmQQ
         5Xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Hcgc2TnKILwgJXFnljthixSWKSrB7d8XKXwMinppcTM=;
        b=Sd33j7x9gskYub75cn+k36PW+tyJ14PwQXjm24QYRh56Oxjk2nv5OXI81OJEyqVMXN
         fYWE74VxOrZr1aEsFPNM5CMyCKmlKbIBiNL8vaDhtWUD/wNpwyNn4jDq/cf+uKIk8Z+S
         6Hs3YWngw7C3m6ichbwuGChLC0X1RfnivSdkypoma3366lv3muTdjLX6hAtFehjwM9AU
         hoow/dEiL6sNNmtZbZZLlpoXoWAYiGi3yaq2VULfzihxqXO6ANl9do9hAbChJwxBYUx4
         RqMmcDpV2rj9+Y8+pVoZv550s/G+0DDYdZxB+Xgvf7ZJt2TPMmrt7j1mAtjMw3nc9liB
         WXsA==
X-Gm-Message-State: AJcUukcqJYEWZ11pWl7PhnETmgPusmzBUG6RV+ydYfd4dw00acSwbF2z
        kHVsGnhz+hHcqQc5hxMt0pzLGWG4F30=
X-Google-Smtp-Source: ALg8bN6VAbu29PethfrY4p3YgimAwyGdcTpQtGeYyGREzPHPhV3II+Wu6fFlaN5Tt6lupwu0LpgBig==
X-Received: by 2002:aed:3fa8:: with SMTP id s37mr2988430qth.208.1547561557405;
        Tue, 15 Jan 2019 06:12:37 -0800 (PST)
Received: from localhost.localdomain ([186.206.5.228])
        by smtp.gmail.com with ESMTPSA id l95sm10572580qkh.37.2019.01.15.06.12.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 06:12:36 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 8/8] a2dp: Add implementation of MediaEndpoint.Device
Date:   Tue, 15 Jan 2019 11:10:23 -0300
Message-Id: <20190115141023.353-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190115141023.353-1-luiz.dentz@gmail.com>
References: <20190115141023.353-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the implementation of MediaEndpoint.Device property so the
clints don't need to guess what device the endpoint belongs.
---
 profiles/audio/a2dp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 6975682c9..ff384cd23 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1718,6 +1718,19 @@ static gboolean get_capabilities(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean get_device(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct a2dp_remote_sep *sep = data;
+	const char *path;
+
+	path = device_get_path(sep->chan->device);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable sep_properties[] = {
 	{ "UUID", "s", get_uuid, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
@@ -1725,6 +1738,8 @@ static const GDBusPropertyTable sep_properties[] = {
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "Capabilities", "ay", get_capabilities, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Device", "o", get_device, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ }
 };
 
-- 
2.17.2

