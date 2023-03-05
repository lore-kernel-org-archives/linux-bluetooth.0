Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651D5C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Mar 2023 17:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjCERGc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Mar 2023 12:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjCERGb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Mar 2023 12:06:31 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F27A5F1
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Mar 2023 09:06:29 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id da10so29515189edb.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Mar 2023 09:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b376BcmY8KNmZgL5zpNc/POWdTvwm0NJfZvaKwsdKN0=;
        b=Ri5zj+N3Pkl4IEKn1I2vgYwrnyNhxyOmDKgvk+LyCniwh9Sf3aMh0LoMlMXuw+xX7n
         lVxnsPyJik3kanAExPddM4qOzMERFPmAa/hjpwMkusOOzTQnl0Mruwrr4I11p+2rYC+H
         y1prlBQTtZ6cKLvt/Gk1G4l0T+RwYFsOCczzmvfzuesqgOo6gS/XkjnK+Rv3Ep3xgjyM
         AFyH+cQFgXrPiOVD5WQFn2qoXvyWzmoD0SLFdH+Viop4bk8f149KfwftFQbBt7Mxxgfl
         Wak8J5xWacUEK0WRRIIrtoUa9nV4xqg2gFl5fo3omw5PlJuFCtzH2SONEvHDNj3Spumc
         z6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b376BcmY8KNmZgL5zpNc/POWdTvwm0NJfZvaKwsdKN0=;
        b=pzJUdT7NlFe0e3zB2sNOtj4jCt6HXYrp3sfiijvdObWnwY+3Wj6Bu8o2ue8KrTIS8G
         Wc6M6c1U66LRFcdlhMSLxqcO/dlfWr5KpsClmHhgfdyubVaefJa5bQ+8A5aPmx4OkI21
         95wdhAIbQS2jUiJmd3aDUj8VLVHZCYkAoUdQT5baUs/+mBumoe/MgrNhuJIpU6AyLk+A
         z/2vQgYrzMNmlXlm74MdKhe+wzwXD+Qb3ATFTaMDAv3tZEJMkrG1SswTsT9TFNax14pL
         ygpIxZjKLqiFzUi9dsfDU7BQpchBiv40eOpGkTrKcNerRyT7NegOGNplfCfHg590ndce
         FAyQ==
X-Gm-Message-State: AO0yUKV/Qn+NxRU0+NYp2uvNPUn+aQccOGTQ3Gi3UHPF7kh4TswsCpOk
        WDd0tZK3oQ1b8kUp8a5V8CTpHeY2hH78PA==
X-Google-Smtp-Source: AK7set/N/Mbq5Nc2f7D4FgofrySxDFnul1f9ESfrdZhCfka5X4M0H8772vjwKzCN/ThUSgsW05yOBA==
X-Received: by 2002:aa7:d60b:0:b0:4bd:94b9:b8a8 with SMTP id c11-20020aa7d60b000000b004bd94b9b8a8mr7207309edr.26.1678035987941;
        Sun, 05 Mar 2023 09:06:27 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:1c1c:178b:22ae:1142:5121:aced])
        by smtp.gmail.com with ESMTPSA id p7-20020a50cd87000000b004aef147add6sm3910057edi.47.2023.03.05.09.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 09:06:27 -0800 (PST)
From:   Fushan Wen <qydwhotmail@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Fushan Wen <qydwhotmail@gmail.com>
Subject: [PATCH BlueZ] Fix missing required properties in MPRIS
Date:   Mon,  6 Mar 2023 01:05:51 +0800
Message-Id: <20230305170551.2572-1-qydwhotmail@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

"SupportedUriSchemes" and "SupportedMimeTypes" are requried properties
in org.mpris.MediaPlayer2. Some MPRIS clients will ignore an MPRIS
interface if the two properties do not exist.

This helps fix https://bugs.kde.org/show_bug.cgi?id=466288
---
 tools/mpris-proxy.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
index e5fc91f..a69b872 100644
--- a/tools/mpris-proxy.c
+++ b/tools/mpris-proxy.c
@@ -1401,6 +1401,18 @@ static gboolean get_tracklist(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean get_emptylist(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	DBusMessageIter array_iter;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+			DBUS_TYPE_STRING_AS_STRING, &array_iter);
+	dbus_message_iter_close_container(iter, &array_iter);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable mpris_properties[] = {
 	{ "CanQuit", "b", get_disable, NULL, NULL },
 	{ "Fullscreen", "b", get_disable, NULL, NULL },
@@ -1408,6 +1420,8 @@ static const GDBusPropertyTable mpris_properties[] = {
 	{ "CanRaise", "b", get_disable, NULL, NULL },
 	{ "HasTrackList", "b", get_tracklist, NULL, NULL },
 	{ "Identity", "s", get_name, NULL, NULL },
+	{ "SupportedUriSchemes", "as", get_emptylist, NULL, NULL },
+	{ "SupportedMimeTypes", "as", get_emptylist, NULL, NULL },
 	{ }
 };
 
-- 
2.39.2

