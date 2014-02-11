Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/6] shared: Add support for disonnect handler to mainloop based IO handling
Date: Tue, 11 Feb 2014 17:49:02 +0100
Message-Id: <1392137346-26272-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1392137346-26272-1-git-send-email-szymon.janc@tieto.com>
References: <1392137346-26272-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/io-mainloop.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/src/shared/io-mainloop.c b/src/shared/io-mainloop.c
index 981ab17..14ab128 100644
--- a/src/shared/io-mainloop.c
+++ b/src/shared/io-mainloop.c
@@ -42,6 +42,9 @@ struct io {
 	io_callback_func_t write_callback;
 	io_destroy_func_t write_destroy;
 	void *write_data;
+	io_callback_func_t disconnect_callback;
+	io_destroy_func_t disconnect_destroy;
+	void *disconnect_data;
 };
 
 static struct io *io_ref(struct io *io)
@@ -75,6 +78,9 @@ static void io_cleanup(void *user_data)
 	if (io->read_destroy)
 		io->read_destroy(io->read_data);
 
+	if (io->disconnect_destroy)
+		io->disconnect_destroy(io->disconnect_data);
+
 	if (io->close_on_destroy)
 		close(io->fd);
 
@@ -122,6 +128,21 @@ static void io_callback(int fd, uint32_t events, void *user_data)
 			mainloop_modify_fd(io->fd, io->events);
 		}
 	}
+
+	if ((events & EPOLLRDHUP) && io->disconnect_callback) {
+		if (!io->disconnect_callback(io, io->disconnect_data)) {
+			if (io->disconnect_destroy)
+				io->disconnect_destroy(io->disconnect_data);
+
+			io->disconnect_callback = NULL;
+			io->disconnect_destroy = NULL;
+			io->disconnect_data = NULL;
+
+			io->events &= ~EPOLLRDHUP;
+
+			mainloop_modify_fd(io->fd, io->events);
+		}
+	}
 }
 
 struct io *io_new(int fd)
@@ -246,5 +267,30 @@ bool io_set_write_handler(struct io *io, io_callback_func_t callback,
 bool io_set_disconnect_handler(struct io *io, io_callback_func_t callback,
 				void *user_data, io_destroy_func_t destroy)
 {
-	return false;
+	uint32_t events;
+
+	if (!io || io->fd < 0)
+		return false;
+
+	if (io->disconnect_destroy)
+		io->disconnect_destroy(io->disconnect_data);
+
+	if (callback)
+		events = io->events | EPOLLRDHUP;
+	else
+		events = io->events & ~EPOLLRDHUP;
+
+	io->disconnect_callback = callback;
+	io->disconnect_destroy = destroy;
+	io->disconnect_data = user_data;
+
+	if (events == io->events)
+		return true;
+
+	if (mainloop_modify_fd(io->fd, events) < 0)
+		return false;
+
+	io->events = events;
+
+	return true;
 }
-- 
1.8.5.3

