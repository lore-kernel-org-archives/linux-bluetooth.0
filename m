Return-Path: <SRS0=+RU5=DC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E90DC4727C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 22:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C11A421D7F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 22:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgIYWi6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Sep 2020 18:38:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:46381 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbgIYWi6 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Sep 2020 18:38:58 -0400
IronPort-SDR: PICiGapcTwCMKU5p3xYDNSK++NpHs224UvMfvCoK0cWQDRVx7JmykW/R4xHcnEFKrTOUQs18M3
 dqmk9H89Sl0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="159004744"
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400"; 
   d="scan'208";a="159004744"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 15:38:56 -0700
IronPort-SDR: pXDdhVueHrbWPsLNpAs3OLVi7rstTNE0DJRGVO0SB/0+ArOacY+ziGX+9/GwP+gr3rCoigPcwy
 A7YxcFgZCmFQ==
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400"; 
   d="scan'208";a="456036452"
Received: from guptapri-mobl1.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.254.88.249])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 15:38:56 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] shared/io-ell: Add reference count to io structure
Date:   Fri, 25 Sep 2020 15:38:49 -0700
Message-Id: <20200925223849.76623-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds reference count to io wrapper structure.
Also, correctly handles IO destroy case by unsetting
read/write/disconnect halers and freeing the corresponding
resources.
---
 src/shared/io-ell.c | 193 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 155 insertions(+), 38 deletions(-)

diff --git a/src/shared/io-ell.c b/src/shared/io-ell.c
index 485c613e0..dee9a95c9 100644
--- a/src/shared/io-ell.c
+++ b/src/shared/io-ell.c
@@ -20,48 +20,96 @@
 
 #include "src/shared/io.h"
 
+struct io_watch {
+	struct io *io;
+	io_callback_func_t cb;
+	io_destroy_func_t destroy;
+	void *user_data;
+};
+
 struct io {
+	int ref_count;
 	struct l_io *l_io;
-	io_callback_func_t read_cb;
-	io_destroy_func_t read_destroy;
-	void *read_data;
-	io_callback_func_t write_cb;
-	io_destroy_func_t write_destroy;
-	void *write_data;
+	struct io_watch *read_watch;
+	struct io_watch *write_watch;
+	struct io_watch *disc_watch;
 };
 
-static bool read_callback(struct l_io *l_io, void *user_data)
+static struct io *io_ref(struct io *io)
 {
-	struct io *io = user_data;
-	bool result = false;
+	if (!io)
+		return NULL;
+
+	__sync_fetch_and_add(&io->ref_count, 1);
+
+	return io;
+}
 
+static void io_unref(struct io *io)
+{
 	if (!io)
-		return false;
+		return;
 
-	if (io->read_cb)
-		result = io->read_cb(io, io->read_data);
+	if (__sync_sub_and_fetch(&io->ref_count, 1))
+		return;
 
-	if (io->read_destroy)
-		io->read_destroy(io->read_data);
+	l_free(io);
+}
 
-	return result;
+static void watch_destroy(void *user_data)
+{
+	struct io_watch *watch = user_data;
+	struct io *io;
+
+	if (!watch)
+		return;
+
+	io = watch->io;
+
+	if (watch == io->read_watch)
+		io->read_watch = NULL;
+	else if (watch == io->write_watch)
+		io->write_watch = NULL;
+	else if (watch == io->disc_watch)
+		io->disc_watch = NULL;
+
+	if (watch->destroy)
+		watch->destroy(watch->user_data);
+
+	io_unref(watch->io);
+	l_free(watch);
 }
 
-static bool write_callback(struct l_io *l_io, void *user_data)
+static struct io_watch *watch_new(struct io *io, io_callback_func_t cb,
+				void *user_data, io_destroy_func_t destroy)
 {
-	struct io *io = user_data;
-	bool result = false;
+	struct io_watch *watch;
 
-	if (!io)
+	watch = l_new(struct io_watch, 1);
+	watch->io = io_ref(io);
+	watch->cb = cb;
+	watch->user_data = user_data;
+	watch->destroy = destroy;
+
+	return watch;
+}
+
+static bool watch_callback(struct l_io *l_io, void *user_data)
+{
+	struct io_watch *watch = user_data;
+
+	if (!watch->cb)
 		return false;
 
-	if (io->write_cb)
-		result = io->write_cb(io, io->write_data);
+	return watch->cb(watch->io, watch->user_data);
+}
 
-	if (io->write_destroy)
-		io->write_destroy(io->write_data);
+static void disc_callback(struct l_io *l_io, void *user_data)
+{
+	struct io_watch *watch = user_data;
 
-	return result;
+	if (watch->cb)
+		watch->cb(watch->io, watch->user_data);
 }
 
 struct io *io_new(int fd)
@@ -84,7 +132,7 @@ struct io *io_new(int fd)
 
 	io->l_io = l_io;
 
-	return io;
+	return io_ref(io);
 }
 
 void io_destroy(struct io *io)
@@ -92,10 +140,22 @@ void io_destroy(struct io *io)
 	if (!io)
 		return;
 
-	if (io->l_io)
-		l_io_destroy(io->l_io);
+	l_io_set_read_handler(io->l_io, NULL, NULL, NULL);
+	watch_destroy(io->read_watch);
+	io->read_watch = NULL;
 
-	l_free(io);
+	l_io_set_write_handler(io->l_io, NULL, NULL, NULL);
+	watch_destroy(io->write_watch);
+	io->write_watch = NULL;
+
+	l_io_set_disconnect_handler(io->l_io, NULL, NULL, NULL);
+	watch_destroy(io->disc_watch);
+	io->disc_watch = NULL;
+
+	l_io_destroy(io->l_io);
+	io->l_io = NULL;
+
+	io_unref(io);
 }
 
 int io_get_fd(struct io *io)
@@ -117,37 +177,94 @@ bool io_set_close_on_destroy(struct io *io, bool do_close)
 bool io_set_read_handler(struct io *io, io_callback_func_t callback,
 				void *user_data, io_destroy_func_t destroy)
 {
+	bool result;
+
 	if (!io || !io->l_io)
 		return false;
 
-	io->read_cb = callback;
-	io->read_data = user_data;
-	io->read_destroy = destroy;
+	if (io->read_watch) {
+		l_io_set_read_handler(io->l_io, NULL, NULL, NULL);
 
-	return l_io_set_read_handler(io->l_io, read_callback, io, NULL);
+		if (!callback) {
+			watch_destroy(io->read_watch);
+			io->read_watch = NULL;
+			return true;
+		}
+	}
+
+	io->read_watch = watch_new(io, callback, user_data, destroy);
+
+	result = l_io_set_read_handler(io->l_io, watch_callback, io->read_watch,
+								watch_destroy);
+
+	if (!result) {
+		watch_destroy(io->read_watch);
+		io->read_watch = NULL;
+	}
+
+	return result;
 }
 
 bool io_set_write_handler(struct io *io, io_callback_func_t callback,
 				void *user_data, io_destroy_func_t destroy)
 {
+	bool result;
+
 	if (!io || !io->l_io)
 		return false;
 
-	io->write_cb = callback;
-	io->write_data = user_data;
-	io->write_destroy = destroy;
+	if (io->write_watch) {
+		l_io_set_write_handler(io->l_io, NULL, NULL, NULL);
 
-	return l_io_set_write_handler(io->l_io, write_callback, io, NULL);
+		if (!callback) {
+			watch_destroy(io->write_watch);
+			io->write_watch = NULL;
+			return true;
+		}
+	}
+
+	io->write_watch = watch_new(io, callback, user_data, destroy);
+
+	result = l_io_set_write_handler(io->l_io, watch_callback,
+						io->write_watch, watch_destroy);
+
+	if (!result) {
+		watch_destroy(io->write_watch);
+		io->write_watch = NULL;
+	}
+
+	return result;
 }
 
 bool io_set_disconnect_handler(struct io *io, io_callback_func_t callback,
 				void *user_data, io_destroy_func_t destroy)
 {
+	bool result;
+
 	if (!io || !io->l_io)
 		return false;
 
-	return l_io_set_disconnect_handler(io->l_io, (void *) callback,
-							user_data, destroy);
+	if (io->disc_watch) {
+		l_io_set_disconnect_handler(io->l_io, NULL, NULL, NULL);
+
+		if (!callback) {
+			watch_destroy(io->disc_watch);
+			io->disc_watch = NULL;
+			return true;
+		}
+	}
+
+	io->disc_watch = watch_new(io, callback, user_data, destroy);
+
+	result = l_io_set_disconnect_handler(io->l_io, disc_callback,
+						io->disc_watch, watch_destroy);
+
+	if (!result) {
+		watch_destroy(io->disc_watch);
+		io->disc_watch = NULL;
+	}
+
+	return result;
 }
 
 ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt)
-- 
2.26.2

