Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E79C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 17:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C44B861074
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 17:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbhJRRa6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbhJRRa4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Oct 2021 13:30:56 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B011C06161C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Oct 2021 10:28:45 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d5so2431896pfu.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Oct 2021 10:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bMZac6HBMIWUpPhHFGa//A7khAdmsR+VAlHEvV+faD0=;
        b=hKDrResEzLHk4GiEKVfjm8cehvzZMuRfkZa6eSMcqcyy/N5ZJkolxWdv445PH7CKJV
         Bs5soyxgVC3egtsE1pj9jgFahFo2xFYVuQxJce5Hgq6AdoBWcrJKEOkos0XbzvpkFlxw
         CANZS4YXszG0x8sIq/0dPLRVYHkY7r2BtaT//8iRoCinyRicYcg8x1FiT1i8U0rmwwI9
         CHv7KRXzmnHbDh/qCgN225gj4NFqt19SMT4VHyq83tszPwrga/V/CoDfUj89vAZsdrK9
         H5irVWyfz74kEdD9zJHJrdtTge0b+NuNaoebFnzz++mIaTqalzccWjrTmQCKovoYzAOI
         koRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bMZac6HBMIWUpPhHFGa//A7khAdmsR+VAlHEvV+faD0=;
        b=7YoARbFDceiEJZSzvwhvjyqtV0btPgxGVZmY8RQLA0RCCFg4HcDyexpPqFn+67IDnR
         3rIwWP74w+yt1/kcC+rcrB5Hywg4EyrokLy1mfL/KddQYYZzkJql4xaHTSrxj+qja+6Y
         kDadpJa2LAmp2StBm/HTvmR7Usb5NfG3KIw5+mib5gvmX9Q0H3EupwQXUov+pzlM1gBP
         RFhp2WpSohcOeSpTKh6BDX6qWi+fpGcnI1avJ5nO6TCBwkYfQPAVBrc9FdUyjZ7NL4eK
         lzT6z1/kZQRAmurvpy5PYlTSSXt8mY60wK+CLDiOPokD+FRiDHOEgtxw62MFXdyhrTrb
         BMgw==
X-Gm-Message-State: AOAM532dRX/GbhmfhT4acWqwY8tbkVHwntH6NwKMKs4SaiWGQM5Vf0Pn
        X9hOGGd1gqYZy5BCZkvry6RelDBK+/qVvQ==
X-Google-Smtp-Source: ABdhPJyShU11uPrF4mBnQqd6ajND3G62aAyIqIIE5KyTXQDoY/PtmZqSlSZb1z94XUFSxSxMlShTjg==
X-Received: by 2002:a63:7055:: with SMTP id a21mr18901870pgn.338.1634578124356;
        Mon, 18 Oct 2021 10:28:44 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:a510:aebd:a4ae:453c])
        by smtp.gmail.com with ESMTPSA id fv9sm51156pjb.26.2021.10.18.10.28.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 10:28:43 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 7/9] mesh: Fix unchecked return value
Date:   Mon, 18 Oct 2021 10:28:31 -0700
Message-Id: <20211018172833.534191-8-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211018172833.534191-1-hj.tedd.an@gmail.com>
References: <20211018172833.534191-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the unchecked return value(CWE-252) issues reported by
the Coverity.
---
 mesh/keyring.c      |  6 ++++--
 mesh/mesh-io-unit.c |  6 ++++--
 mesh/rpl.c          | 22 ++++++++++++++--------
 mesh/util.c         | 11 ++++++++---
 4 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/mesh/keyring.c b/mesh/keyring.c
index 4b901643c..51621777d 100644
--- a/mesh/keyring.c
+++ b/mesh/keyring.c
@@ -50,7 +50,8 @@ static int open_key_file(struct mesh_node *node, const char *key_dir,
 
 	if (flags & O_CREAT) {
 		snprintf(fname, PATH_MAX, "%s%s", node_path, key_dir);
-		mkdir(fname, 0755);
+		if (mkdir(fname, 0755) != 0)
+			l_error("Failed to create dir(%d): %s", errno, fname);
 	}
 
 	snprintf(fname, PATH_MAX, "%s%s/%3.3x", node_path, key_dir, idx);
@@ -206,7 +207,8 @@ bool keyring_put_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 
 	snprintf(key_file, PATH_MAX, "%s%s", node_path, dev_key_dir);
 
-	mkdir(key_file, 0755);
+	if (mkdir(key_file, 0755) != 0)
+		l_error("Failed to create dir(%d): %s", errno, key_file);
 
 	for (i = 0; i < count; i++) {
 		snprintf(key_file, PATH_MAX, "%s%s/%4.4x", node_path,
diff --git a/mesh/mesh-io-unit.c b/mesh/mesh-io-unit.c
index c5aae6741..f4b615ac8 100644
--- a/mesh/mesh-io-unit.c
+++ b/mesh/mesh-io-unit.c
@@ -133,7 +133,8 @@ static bool incoming(struct l_io *sio, void *user_data)
 
 		buf[0] = 0;
 		memcpy(buf + 1, pvt->unique_name, size + 1);
-		send(pvt->fd, buf, size + 2, MSG_DONTWAIT);
+		if (send(pvt->fd, buf, size + 2, MSG_DONTWAIT) < 0)
+			l_error("Failed to send(%d)", errno);
 	}
 
 	return true;
@@ -304,7 +305,8 @@ static bool simple_match(const void *a, const void *b)
 static void send_pkt(struct mesh_io_private *pvt, struct tx_pkt *tx,
 							uint16_t interval)
 {
-	send(pvt->fd, tx->pkt, tx->len, MSG_DONTWAIT);
+	if (send(pvt->fd, tx->pkt, tx->len, MSG_DONTWAIT) < 0)
+		l_error("Failed to send(%d)", errno);
 
 	if (tx->delete) {
 		l_queue_remove_if(pvt->tx_pkts, simple_match, tx);
diff --git a/mesh/rpl.c b/mesh/rpl.c
index c53c6fbfd..9a99afe7b 100644
--- a/mesh/rpl.c
+++ b/mesh/rpl.c
@@ -18,6 +18,7 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <dirent.h>
+#include <errno.h>
 
 #include <sys/stat.h>
 
@@ -54,9 +55,10 @@ bool rpl_put_entry(struct mesh_node *node, uint16_t src, uint32_t iv_index,
 								iv_index);
 	dir = opendir(src_file);
 
-	if (!dir)
-		mkdir(src_file, 0755);
-	else
+	if (!dir) {
+		if (mkdir(src_file, 0755) != 0)
+			l_error("Failed to create dir: %s", src_file);
+	} else
 		closedir(dir);
 
 	snprintf(src_file, PATH_MAX, "%s%s/%8.8x/%4.4x", node_path, rpl_dir,
@@ -78,8 +80,8 @@ bool rpl_put_entry(struct mesh_node *node, uint16_t src, uint32_t iv_index,
 	iv_index--;
 	snprintf(src_file, PATH_MAX, "%s%s/%8.8x/%4.4x", node_path, rpl_dir,
 								iv_index, src);
-	remove(src_file);
-
+	if (remove(src_file) < 0)
+		l_error("Failed to remove(%d): %s", errno, src_file);
 
 	return result;
 }
@@ -110,7 +112,9 @@ void rpl_del_entry(struct mesh_node *node, uint16_t src)
 		if (entry->d_type == DT_DIR && entry->d_name[0] != '.') {
 			snprintf(rpl_path, PATH_MAX, "%s%s/%s/%4.4x",
 					node_path, rpl_dir, entry->d_name, src);
-			remove(rpl_path);
+			if (remove(rpl_path) < 0)
+				l_error("Failed to remove(%d): %s", errno,
+								rpl_path);
 		}
 	}
 
@@ -251,7 +255,8 @@ void rpl_update(struct mesh_node *node, uint32_t cur)
 
 	/* Make sure path exists */
 	snprintf(path, PATH_MAX, "%s%s", node_path, rpl_dir);
-	mkdir(path, 0755);
+	if (mkdir(path, 0755) != 0)
+		l_error("Failed to create dir(%d): %s", errno, path);
 
 	dir = opendir(path);
 	if (!dir)
@@ -288,6 +293,7 @@ bool rpl_init(const char *node_path)
 		return false;
 
 	snprintf(path, PATH_MAX, "%s%s", node_path, rpl_dir);
-	mkdir(path, 0755);
+	if (mkdir(path, 0755) != 0)
+		l_error("Failed to create dir(%d): %s", errno, path);
 	return true;
 }
diff --git a/mesh/util.c b/mesh/util.c
index 308e7d998..d505e7a0c 100644
--- a/mesh/util.c
+++ b/mesh/util.c
@@ -14,6 +14,7 @@
 
 #define _GNU_SOURCE
 #include <dirent.h>
+#include <errno.h>
 #include <ftw.h>
 #include <unistd.h>
 #include <stdio.h>
@@ -117,12 +118,14 @@ int create_dir(const char *dir_name)
 		}
 
 		strncat(dir, prev + 1, next - prev);
-		mkdir(dir, 0755);
+		if (mkdir(dir, 0755) != 0)
+			l_error("Failed to create dir(%d): %s", errno, dir);
 
 		prev = next;
 	}
 
-	mkdir(dir_name, 0755);
+	if (mkdir(dir_name, 0755) != 0)
+		l_error("Failed to create dir(%d): %s", errno, dir_name);
 
 	return 0;
 }
@@ -138,7 +141,9 @@ static int del_fobject(const char *fpath, const struct stat *sb, int typeflag,
 
 	case FTW_SL:
 	default:
-		remove(fpath);
+		if (remove(fpath) < 0)
+			l_error("Failed to remove(%d): %s", errno, fpath);
+
 		l_debug("RM %s", fpath);
 		break;
 	}
-- 
2.25.1

