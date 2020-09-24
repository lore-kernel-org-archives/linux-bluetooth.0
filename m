Return-Path: <SRS0=nJSa=DB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976C3C4727D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Sep 2020 18:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A28A2311B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Sep 2020 18:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgIXSUN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Sep 2020 14:20:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:62030 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbgIXSUM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Sep 2020 14:20:12 -0400
IronPort-SDR: tz83bI2GBWY1wsziebgSSRoA9Fa16cnAIqX10ref14N4rBmpiEOyMpYkZFYs5Hn1C4O8OtQ3Ie
 6hURWhpiOmrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="179388563"
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; 
   d="scan'208";a="179388563"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 11:20:11 -0700
IronPort-SDR: lcugOTTOcgyb2KqkBSHyFGzGf5bk22rJresY+K5jXCKkCQ5wffybItd/zo5zx+Weh++KU1f6OR
 JfjG8WoDI3iw==
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; 
   d="scan'208";a="291325245"
Received: from ypan13-mobl1.ccr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.254.97.189])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 11:20:11 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] shared/io-ell: Fix ELL io wrapper
Date:   Thu, 24 Sep 2020 11:20:02 -0700
Message-Id: <20200924182002.22978-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This modifies the internal io structure inside io-ell to retain
correct user data associated with write and read handlers and
to return these data with the corresponding callbacks.
---
 src/shared/io-ell.c | 54 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/src/shared/io-ell.c b/src/shared/io-ell.c
index c4a115478..485c613e0 100644
--- a/src/shared/io-ell.c
+++ b/src/shared/io-ell.c
@@ -22,8 +22,48 @@
 
 struct io {
 	struct l_io *l_io;
+	io_callback_func_t read_cb;
+	io_destroy_func_t read_destroy;
+	void *read_data;
+	io_callback_func_t write_cb;
+	io_destroy_func_t write_destroy;
+	void *write_data;
 };
 
+static bool read_callback(struct l_io *l_io, void *user_data)
+{
+	struct io *io = user_data;
+	bool result = false;
+
+	if (!io)
+		return false;
+
+	if (io->read_cb)
+		result = io->read_cb(io, io->read_data);
+
+	if (io->read_destroy)
+		io->read_destroy(io->read_data);
+
+	return result;
+}
+
+static bool write_callback(struct l_io *l_io, void *user_data)
+{
+	struct io *io = user_data;
+	bool result = false;
+
+	if (!io)
+		return false;
+
+	if (io->write_cb)
+		result = io->write_cb(io, io->write_data);
+
+	if (io->write_destroy)
+		io->write_destroy(io->write_data);
+
+	return result;
+}
+
 struct io *io_new(int fd)
 {
 	struct io *io;
@@ -80,8 +120,11 @@ bool io_set_read_handler(struct io *io, io_callback_func_t callback,
 	if (!io || !io->l_io)
 		return false;
 
-	return l_io_set_read_handler(io->l_io, (l_io_read_cb_t) callback,
-							user_data, destroy);
+	io->read_cb = callback;
+	io->read_data = user_data;
+	io->read_destroy = destroy;
+
+	return l_io_set_read_handler(io->l_io, read_callback, io, NULL);
 }
 
 bool io_set_write_handler(struct io *io, io_callback_func_t callback,
@@ -90,8 +133,11 @@ bool io_set_write_handler(struct io *io, io_callback_func_t callback,
 	if (!io || !io->l_io)
 		return false;
 
-	return l_io_set_write_handler(io->l_io, (l_io_write_cb_t) callback,
-							user_data, destroy);
+	io->write_cb = callback;
+	io->write_data = user_data;
+	io->write_destroy = destroy;
+
+	return l_io_set_write_handler(io->l_io, write_callback, io, NULL);
 }
 
 bool io_set_disconnect_handler(struct io *io, io_callback_func_t callback,
-- 
2.26.2

