Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v2 12/15] adaptername: Refactor handle_inotify_cb
Date: Fri, 31 Aug 2012 14:40:08 +0200
Message-ID: <1346416811-23484-13-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1346416811-23484-1-git-send-email-szymon.janc@tieto.com>
References: <1346416811-23484-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Refactor handle_inotify_cb to avoid unaligned memory access.
Instead of reading whole events buffer and cast to event struct when
iterating over it, read data directly to struct inotify_event one
event at time.

This fix following build error on ARM.

  CC     plugins/bluetoothd-adaptername.o
plugins/adaptername.c: In function handle_inotify_cb:
plugins/adaptername.c:244:34: error: cast increases required alignment
	of target type [-Werror=cast-align]
cc1: all warnings being treated as errors
make[1]: *** [plugins/bluetoothd-adaptername.o] Error 1
make: *** [all] Error 2

---
 plugins/adaptername.c |   44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/plugins/adaptername.c b/plugins/adaptername.c
index d3341b5..f5010ea 100644
--- a/plugins/adaptername.c
+++ b/plugins/adaptername.c
@@ -226,35 +226,41 @@ static int adaptername_probe(struct btd_adapter *adapter)
 static gboolean handle_inotify_cb(GIOChannel *channel, GIOCondition cond,
 								gpointer data)
 {
-	char buf[EVENT_BUF_LEN];
+	struct inotify_event event;
+	gsize len;
 	GIOStatus err;
-	gsize len, i;
-	gboolean changed;
+	char name[FILENAME_MAX + 1];
 
-	changed = FALSE;
+	while ((err = g_io_channel_read_chars(channel, (gchar *)&event,
+			sizeof(event), &len, NULL)) != G_IO_STATUS_AGAIN) {
+		if (err != G_IO_STATUS_NORMAL) {
+			error("Error reading inotify event: %d", err);
+			return FALSE;
+		}
 
-	err = g_io_channel_read_chars(channel, buf, EVENT_BUF_LEN, &len, NULL);
-	if (err != G_IO_STATUS_NORMAL) {
-		error("Error reading inotify event: %d\n", err);
-		return FALSE;
-	}
+		if (len != sizeof(event)) {
+			error("Not enough bytes of inotify event read");
+			return FALSE;
+		}
 
-	i = 0;
-	while (i < len) {
-		struct inotify_event *pevent = (struct inotify_event *) &buf[i];
+		if (event.len == 0)
+			continue;
 
-		/* check that it's ours */
-		if (pevent->len && pevent->name != NULL &&
-				strcmp(pevent->name, MACHINE_INFO_FILE) == 0)
-			changed = TRUE;
+		err = g_io_channel_read_chars(channel, name, event.len, &len,
+									NULL);
+		if (err != G_IO_STATUS_NORMAL) {
+			error("Error reading inotify event: %d", err);
+			return FALSE;
+		}
 
-		i += EVENT_SIZE + pevent->len;
-	}
+		if (strcmp(name, MACHINE_INFO_FILE) != 0)
+			continue;
 
-	if (changed != FALSE) {
 		DBG(MACHINE_INFO_DIR MACHINE_INFO_FILE
 				" changed, changing names for adapters");
+
 		manager_foreach_adapter((adapter_cb) adaptername_probe, NULL);
+		break;
 	}
 
 	return TRUE;
-- 
1.7.9.5

