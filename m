Return-Path: <SRS0=3wSE=QD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA218C282C0
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Jan 2019 11:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB182148D
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Jan 2019 11:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9j9QDNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfA0L5O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 27 Jan 2019 06:57:14 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:51668 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfA0L5O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 27 Jan 2019 06:57:14 -0500
Received: by mail-wm1-f47.google.com with SMTP id b11so10956742wmj.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Jan 2019 03:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bJbbiLyTPAdUGzzorExjLEBSgx/b1i5Cw67QjpSOeaM=;
        b=q9j9QDNi7hR4uKsEHEocwFhM59vbO/afmFrYa7M9PLHebrr5SthAj0N/6pxvt/K26N
         uobV1pa9n4rGOt8k8zVoCAdFVVO0ifX5iVj56KUwjsG4Ar/z3HcPHn/SI1shguxJuiN7
         qJ49F0EyahsTJH0O7b9rSs2I8G7lLoCmXbaYb81vC8kSu7UWdlycCdvIRt4bUHcK81Cf
         +cI8ifsXQ1yo0JFOePLN9/G+70ESkgUMF9wg2t9dRjfGeVWH73mAUWRECGeQ7Vg/QjmV
         BrPzWxraN4QiaWI87Z/NoKBLrNtWUtoxKJnhePp33VkXd7rFdVhzNsXQrlW3p5oqKvqo
         ezhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bJbbiLyTPAdUGzzorExjLEBSgx/b1i5Cw67QjpSOeaM=;
        b=bstX91+cZog/ORNl4BD+ZDiavLPewRARUThngWJ2qAQyHfyWKh3J17KmCutLMgaxmc
         NROPCFbzfO+I/2sOpfPM4Cxx0FGONgVqexpRxahEzTjT11JZaszk4+XyrPWZbtuDrX31
         6F8y3UEqcgV6LP4sHwVMmf4a587JGjNxPFiL2f4F/UXycLFM8ka7aDs16lZvCU+KcSW2
         Ncu/5UyRCLDCjlcVLD3qSr3dB8VWXyamjZr/9/HRDa6sZqU7xkEtnCC/Jk3WfJqvoso3
         FKvgVyB6x6oJhQBd8Wn0nJ9E/Qabj815/crzNJnNEjYF3dfGLj4ToKk70G+5HSuXIGYi
         2Chw==
X-Gm-Message-State: AJcUukdspaoU8cGAiw6U4OsEWWeg24PdSsKL7aL+AfoVeG99eNZ43bqJ
        XAPEUNJAdrj16NmjkErJYptazlpy
X-Google-Smtp-Source: ALg8bN5062QMywSNUMu6RhDfskwcAwqTDjwwnTCUFA5uBw57aO+6x3A7pAQjo5ii/q0T9Lme2mXxog==
X-Received: by 2002:a1c:494:: with SMTP id 142mr13313378wme.111.1548590232000;
        Sun, 27 Jan 2019 03:57:12 -0800 (PST)
Received: from Buero.fritz.box ([2001:a62:158e:8d01:357b:74c0:62f9:a1b8])
        by smtp.gmail.com with ESMTPSA id 67sm178999281wra.37.2019.01.27.03.57.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 03:57:11 -0800 (PST)
From:   Christian Zimmermann <zimmermach@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Christian Zimmermann <zimmermach@gmail.com>
Subject: [PATCH BlueZ 1/2] Renamed Bluez4 config read functions
Date:   Sun, 27 Jan 2019 12:56:45 +0100
Message-Id: <20190127115646.5814-2-zimmermach@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190127115646.5814-1-zimmermach@gmail.com>
References: <20190127115646.5814-1-zimmermach@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 src/adapter.c |  8 ++++----
 src/storage.c | 36 ++++++++----------------------------
 src/storage.h | 10 ++++++----
 3 files changed, 18 insertions(+), 36 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b8a6bb6e2..f7c24fe62 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5654,21 +5654,21 @@ static void convert_config(struct btd_adapter *adapter, const char *filename,
 	ba2str(&adapter->bdaddr, address);
 	snprintf(config_path, PATH_MAX, STORAGEDIR "/%s/config", address);
 
-	if (read_pairable_timeout(address, &timeout) == 0)
+	if (bluez4_read_pairable_timeout(config_path, &timeout) == 0)
 		g_key_file_set_integer(key_file, "General",
 						"PairableTimeout", timeout);
 
-	if (read_discoverable_timeout(address, &timeout) == 0)
+	if (bluez4_read_discoverable_timeout(config_path, &timeout) == 0)
 		g_key_file_set_integer(key_file, "General",
 						"DiscoverableTimeout", timeout);
 
-	if (read_on_mode(address, str, sizeof(str)) == 0) {
+	if (bluez4_read_on_mode(config_path, str, sizeof(str)) == 0) {
 		mode = get_mode(str);
 		g_key_file_set_boolean(key_file, "General", "Discoverable",
 					mode == MODE_DISCOVERABLE);
 	}
 
-	if (read_local_name(&adapter->bdaddr, str) == 0)
+	if (bluez4_read_local_name(config_path, str) == 0)
 		g_key_file_set_string(key_file, "General", "Alias", str);
 
 	create_file(filename, S_IRUSR | S_IWUSR);
diff --git a/src/storage.c b/src/storage.c
index 8cbb5b270..779ca2bc8 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -56,22 +56,9 @@ struct match {
 	char *pattern;
 };
 
-static inline int create_filename(char *buf, size_t size,
-				const bdaddr_t *bdaddr, const char *name)
+int bluez4_read_discoverable_timeout(const char *filename, int *timeout)
 {
-	char addr[18];
-
-	ba2str(bdaddr, addr);
-
-	return create_name(buf, size, STORAGEDIR, addr, name);
-}
-
-int read_discoverable_timeout(const char *src, int *timeout)
-{
-	char filename[PATH_MAX], *str;
-
-	create_name(filename, PATH_MAX, STORAGEDIR, src, "config");
-
+	char *str;
 	str = textfile_get(filename, "discovto");
 	if (!str)
 		return -ENOENT;
@@ -86,12 +73,9 @@ int read_discoverable_timeout(const char *src, int *timeout)
 	return 0;
 }
 
-int read_pairable_timeout(const char *src, int *timeout)
+int bluez4_read_pairable_timeout(const char *filename, int *timeout)
 {
-	char filename[PATH_MAX], *str;
-
-	create_name(filename, PATH_MAX, STORAGEDIR, src, "config");
-
+	char *str;
 	str = textfile_get(filename, "pairto");
 	if (!str)
 		return -ENOENT;
@@ -106,11 +90,9 @@ int read_pairable_timeout(const char *src, int *timeout)
 	return 0;
 }
 
-int read_on_mode(const char *src, char *mode, int length)
+int bluez4_read_on_mode(const char *filename, char *mode, int length)
 {
-	char filename[PATH_MAX], *str;
-
-	create_name(filename, PATH_MAX, STORAGEDIR, src, "config");
+	char *str;
 
 	str = textfile_get(filename, "onmode");
 	if (!str)
@@ -124,13 +106,11 @@ int read_on_mode(const char *src, char *mode, int length)
 	return 0;
 }
 
-int read_local_name(const bdaddr_t *bdaddr, char *name)
+int bluez4_read_local_name(const char *filename, char *name)
 {
-	char filename[PATH_MAX], *str;
+	char *str;
 	int len;
 
-	create_filename(filename, PATH_MAX, bdaddr, "config");
-
 	str = textfile_get(filename, "name");
 	if (!str)
 		return -ENOENT;
diff --git a/src/storage.h b/src/storage.h
index 1c0ad57ec..d84cc86db 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -21,9 +21,11 @@
  *
  */
 
-int read_discoverable_timeout(const char *src, int *timeout);
-int read_pairable_timeout(const char *src, int *timeout);
-int read_on_mode(const char *src, char *mode, int length);
-int read_local_name(const bdaddr_t *bdaddr, char *name);
+#include "lib/sdp.h"
+
+int bluez4_read_discoverable_timeout(const char *filename, int *timeout);
+int bluez4_read_pairable_timeout(const char *filename, int *timeout);
+int bluez4_read_on_mode(const char *filename, char *mode, int length);
+int bluez4_read_local_name(const char *filename, char *name);
 sdp_record_t *record_from_string(const char *str);
 sdp_record_t *find_record_in_list(sdp_list_t *recs, const char *uuid);
-- 
2.11.0

