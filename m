Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH BlueZ 1/3] monitor: Extract TTY data processing to separate function
Date: Thu, 22 Feb 2018 10:20:53 +0100
Message-Id: <20180222092055.22493-2-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <20180222092055.22493-1-andrzej.kaczmarek@codecoup.pl>
References: <20180222092055.22493-1-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/control.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/monitor/control.c b/monitor/control.c
index 1cd79ca5d..98f414be9 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -1262,23 +1262,8 @@ static bool tty_parse_header(uint8_t *hdr, uint8_t len, struct timeval **tv,
 	return true;
 }
 
-static void tty_callback(int fd, uint32_t events, void *user_data)
+static void process_data(struct control_data *data)
 {
-	struct control_data *data = user_data;
-	ssize_t len;
-
-	if (events & (EPOLLERR | EPOLLHUP)) {
-		mainloop_remove_fd(data->fd);
-		return;
-	}
-
-	len = read(data->fd, data->buf + data->offset,
-					sizeof(data->buf) - data->offset);
-	if (len < 0)
-		return;
-
-	data->offset += len;
-
 	while (data->offset >= sizeof(struct tty_hdr)) {
 		struct tty_hdr *hdr = (struct tty_hdr *) data->buf;
 		uint16_t pktlen, opcode, data_len;
@@ -1318,6 +1303,26 @@ static void tty_callback(int fd, uint32_t events, void *user_data)
 	}
 }
 
+static void tty_callback(int fd, uint32_t events, void *user_data)
+{
+	struct control_data *data = user_data;
+	ssize_t len;
+
+	if (events & (EPOLLERR | EPOLLHUP)) {
+		mainloop_remove_fd(data->fd);
+		return;
+	}
+
+	len = read(data->fd, data->buf + data->offset,
+					sizeof(data->buf) - data->offset);
+	if (len < 0)
+		return;
+
+	data->offset += len;
+
+	process_data(data);
+}
+
 int control_tty(const char *path, unsigned int speed)
 {
 	struct control_data *data;
-- 
2.16.2

