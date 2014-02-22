Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH v2 2/7] shared: Minor code style fixes in GLib based IO
Date: Sat, 22 Feb 2014 22:09:20 +0100
Message-Id: <1393103365-19908-2-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1393103365-19908-1-git-send-email-szymon.janc@gmail.com>
References: <1393103365-19908-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/io-glib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
index 5490fc0..76f5a44 100644
--- a/src/shared/io-glib.c
+++ b/src/shared/io-glib.c
@@ -195,6 +195,7 @@ bool io_set_read_handler(struct io *io, io_callback_func_t callback,
 
 	io->read_destroy = destroy;
 	io->read_data = user_data;
+
 done:
 	io->read_callback = callback;
 
@@ -256,6 +257,7 @@ bool io_set_write_handler(struct io *io, io_callback_func_t callback,
 
 	io->write_destroy = destroy;
 	io->write_data = user_data;
+
 done:
 	io->write_callback = callback;
 
-- 
1.9.0

