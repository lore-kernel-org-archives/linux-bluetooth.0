Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B3CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 17:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0B9D6108E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 17:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbhJRRa7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbhJRRa5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Oct 2021 13:30:57 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C8FC061745
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Oct 2021 10:28:45 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id s1so9926794plg.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Oct 2021 10:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=il+5MXJHi06XKAsguhIoTzyIIoTFUOdDa4x0oU/Hk44=;
        b=GuNtyz9uIpcmnsKxitUG8iG+hyCLvmTDJ4DScS0j/rvx0t1Do851QH00uFQ9kNXaLm
         5I1bryIi1GZVkmFnrUtVg4XwdqHQd+yHmTcVbZidwvYtX1f/wWUTrgIBD88sahO6xQQq
         OuRX1De+5omhGVfCeSvIe9StKsZaMZv9n+AuQw+AAK3UmeLJq/4Xsg6yxZAbpHqZ4hlD
         Lhq14/5CRtrZuTBSiAzB/ZoOtYLMHh4nRccV/3fQJynROlS39sVMfnU/FzwptXduoTaz
         9Sp+JXLlViy3UiRbt4b34CXu0MezC4BB6IX0uRKHyXhDbDsyzh5t4zj8tiWzLXC94/op
         Axkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=il+5MXJHi06XKAsguhIoTzyIIoTFUOdDa4x0oU/Hk44=;
        b=31bBmo7Gmyd82OlmT7VS6jGIzV6qA4/tY3SrTCw1Bg41CK57c2/pNAAX1DMd9eJ/KK
         AIRXttjR8cxEEVj+Lohnt3ieFAnXy1EJMMqLUTOPCfrx4GtnciyxefpxwtnNW649iu0J
         p4a8PgBfYyJucw7rWxPuUOfBHzVCl6vbeUqA6FnQ+txADIXO/Cq8Wgxy9fVk8nWTOiGv
         zDk2gNp7DFNmJtBAzCK6Hn4RohVkIYPT7OArmCyufMu5KNN+b8Z4FPDEKY0eHAFhTqmE
         aP0kmbyk2bVSzSY7KBhb8Tw5C5bfo1m4lkLrc9W7q5+aNnGtPLu12Scs+WEiGG55donF
         Y9Zw==
X-Gm-Message-State: AOAM532iIKK+kAvbjn3c7rTeelBTCRVtgpSjFOI/57HuSXsEnVJ2hIJ3
        gq04iZdWqmv9cFM2o4zhFnoyhvq1JqwHAg==
X-Google-Smtp-Source: ABdhPJygUQG4JwUO/x8JpB43I9ezUv9/KqbKS0b1rAZXBTuaFhPLlOQlL04P+7fGQgGmehsm7bJnPw==
X-Received: by 2002:a17:90b:3850:: with SMTP id nl16mr209435pjb.127.1634578124905;
        Mon, 18 Oct 2021 10:28:44 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:a510:aebd:a4ae:453c])
        by smtp.gmail.com with ESMTPSA id fv9sm51156pjb.26.2021.10.18.10.28.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 10:28:44 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 8/9] obexd: Fix unchecked return value
Date:   Mon, 18 Oct 2021 10:28:32 -0700
Message-Id: <20211018172833.534191-9-hj.tedd.an@gmail.com>
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
 obexd/client/transfer.c | 12 +++++++++---
 obexd/plugins/pcsuite.c |  4 +++-
 obexd/src/main.c        |  4 +++-
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/obexd/client/transfer.c b/obexd/client/transfer.c
index 744d8f106..dccce03b4 100644
--- a/obexd/client/transfer.c
+++ b/obexd/client/transfer.c
@@ -420,8 +420,11 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 
 	if (transfer->op == G_OBEX_OP_GET &&
 				transfer->status != TRANSFER_STATUS_COMPLETE &&
-				transfer->filename)
-		remove(transfer->filename);
+				transfer->filename) {
+		if (remove(transfer->filename) < 0)
+			error("remove(%s): %s(%d)", transfer->filename,
+							strerror(errno), errno);
+	}
 
 	if (transfer->fd > 0)
 		close(transfer->fd);
@@ -521,7 +524,10 @@ static gboolean transfer_open(struct obc_transfer *transfer, int flags,
 	}
 
 	if (transfer->filename == NULL) {
-		remove(filename); /* remove always only if NULL was given */
+		/* remove always only if NULL was given */
+		if (remove(filename) < 0)
+			error("remove(%s): %s(%d)", filename, strerror(errno),
+									errno);
 		g_free(filename);
 	} else {
 		g_free(transfer->filename);
diff --git a/obexd/plugins/pcsuite.c b/obexd/plugins/pcsuite.c
index b2232ea09..f5a9d9ae8 100644
--- a/obexd/plugins/pcsuite.c
+++ b/obexd/plugins/pcsuite.c
@@ -219,7 +219,9 @@ static void pcsuite_disconnect(struct obex_session *os, void *user_data)
 		close(pcsuite->fd);
 
 	if (pcsuite->lock_file) {
-		remove(pcsuite->lock_file);
+		if (remove(pcsuite->lock_file) < 0)
+			error("remove(%s): %s(%d)", pcsuite->lock_file,
+							strerror(errno), errno);
 		g_free(pcsuite->lock_file);
 	}
 
diff --git a/obexd/src/main.c b/obexd/src/main.c
index 04284c9e1..d950883f0 100644
--- a/obexd/src/main.c
+++ b/obexd/src/main.c
@@ -270,7 +270,9 @@ int main(int argc, char *argv[])
 	if (option_root == NULL) {
 		option_root = g_build_filename(g_get_user_cache_dir(), "obexd",
 									NULL);
-		g_mkdir_with_parents(option_root, 0700);
+		if (g_mkdir_with_parents(option_root, 0700) < 0)
+			error("Failed to create dir(%d): %s", errno,
+								option_root);
 	}
 
 	if (option_root[0] != '/') {
-- 
2.25.1

