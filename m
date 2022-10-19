Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C848C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Oct 2022 20:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiJSUam (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Oct 2022 16:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiJSUak (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Oct 2022 16:30:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6144C444BB
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 13:30:39 -0700 (PDT)
Received: from localhost.localdomain (67.227.121.78.rev.sfr.net [78.121.227.67])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: fdanis)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9AAC16602389
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 21:30:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666211437;
        bh=BD0+Xz3x6Ck+fAomkH/0kyYXP3MRRilkrVi0MRLwbi0=;
        h=From:To:Subject:Date:From;
        b=dmpbTVOwSpMpbvEKUeoDaLWpY6cGr0m9ByXXuuqGrn92JOlpy5QpMYpm3Da8uHDfI
         wTxxQ/SrrAJwSwKTDJYzNa85z1sSwWb5FdXa0ZWhq3LyfhKEH9tcAXgDFqCyGhRM81
         7lu4bfCoxmkOoOLl/BCviNbGtC7FDwj9oQ5+IZyVh1d06Lwwmr6QGlx4JjsunBLzwZ
         eMckt1r7vYOUBpV5abRddcaW0QlNVJMNY2I39lMg2+QBQfwUSZqQqDTpB+6pJwwG8q
         6mnRjNx9B4PhoY/Y2om7KpLwhf1Omf613bMzlmnWEAIWQtsaa5TWczEHZSt/KQAuad
         Js+20CApeYbqg==
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/util: Increase debug trace buffer size
Date:   Wed, 19 Oct 2022 22:30:28 +0200
Message-Id: <20221019203028.57090-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Most of the debug traces are longer than 78 characters, increase the buffer
to not lost trace's end
---
 src/shared/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/util.c b/src/shared/util.c
index e1e56459a..0a0308cb0 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -65,7 +65,7 @@ void *util_memdup(const void *src, size_t size)
 void util_debug_va(util_debug_func_t function, void *user_data,
 				const char *format, va_list va)
 {
-	char str[78];
+	char str[MAX_INPUT];
 
 	if (!function || !format)
 		return;
-- 
2.25.1

