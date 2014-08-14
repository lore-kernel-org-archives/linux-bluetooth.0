Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v3 1/3] shared/io-mainloop: Increment the ref count inside io_callback.
Date: Wed, 13 Aug 2014 19:27:54 -0700
Message-Id: <1407983276-22573-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1407983276-22573-1-git-send-email-armansito@chromium.org>
References: <1407983276-22573-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Incrementing the reference count before invoking the event handlers and
decrementing it thereafter allows io_destroy to be safely called from within
the event callbacks. This patch achieves that.
---
 src/shared/io-mainloop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/shared/io-mainloop.c b/src/shared/io-mainloop.c
index 3e33d88..1563ce5 100644
--- a/src/shared/io-mainloop.c
+++ b/src/shared/io-mainloop.c
@@ -92,12 +92,15 @@ static void io_callback(int fd, uint32_t events, void *user_data)
 {
 	struct io *io = user_data;
 
+	io_ref(io);
+
 	if ((events & (EPOLLRDHUP | EPOLLHUP | EPOLLERR))) {
 		io->read_callback = NULL;
 		io->write_callback = NULL;
 
 		if (!io->disconnect_callback) {
 			mainloop_remove_fd(io->fd);
+			io_unref(io);
 			return;
 		}
 
@@ -144,6 +147,8 @@ static void io_callback(int fd, uint32_t events, void *user_data)
 			mainloop_modify_fd(io->fd, io->events);
 		}
 	}
+
+	io_unref(io);
 }
 
 struct io *io_new(int fd)
-- 
2.1.0.rc2.206.gedb03e5

