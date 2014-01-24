Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [RFC BlueZ 2/2] monitor: Add support for printing bluetoothd messages
Date: Fri, 24 Jan 2014 19:41:52 -0200
Message-Id: <1390599712-1609-3-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1390599712-1609-1-git-send-email-vcgomes@gmail.com>
References: <1390599712-1609-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In many cases when debugging bluetoothd behaviour, it is useful
to associate bluetooth debug outputs with HCI/MGMT commands and
events.
---
 monitor/journal.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 1 deletion(-)

diff --git a/monitor/journal.c b/monitor/journal.c
index ecc7dac..1b04f02 100644
--- a/monitor/journal.c
+++ b/monitor/journal.c
@@ -22,12 +22,105 @@
  */
 
 #include <errno.h>
+#include <stdio.h>
 
 #include <systemd/sd-journal.h>
 
+#include "mainloop.h"
 #include "journal.h"
 
+static sd_journal *journal;
+
+static void journal_destroy(void *user_data)
+{
+	sd_journal *j = user_data;
+	sd_journal_close(j);
+}
+
+static void journal_event(int fd, uint32_t events, void *user_data)
+{
+	sd_journal *j = user_data;
+	const void *d;
+	const char *msg;
+	size_t l;
+	int err, prefix = strlen("MESSAGE=");
+
+	err = sd_journal_process(j);
+	if (err < 0) {
+		printf("Could not process journal: %s (%d)\n",
+				strerror(-err), err);
+		goto failed;
+	}
+
+	err = sd_journal_next(j);
+	if (err == 0) {
+		/* No more events in the journal, let's wait. */
+		return;
+	} else if (err < 0) {
+		printf("Failed to iterate to the next entry: %s (%d)\n",
+				strerror(-err), err);
+		goto failed;
+	}
+
+	err = sd_journal_get_data(j, "MESSAGE", &d, &l);
+	if (err < 0) {
+		printf("Could not get journal messages: %s (%d)",
+				strerror(-err), err);
+		goto failed;
+	}
+
+	msg = d;
+
+	/* TODO: better formatting, perhaps colors. */
+	/* msg is prefixed with 'MESSAGE=', remove it. */
+	printf("# %.*s\n", (int) l - prefix, msg + prefix);
+
+	return;
+
+failed:
+	mainloop_remove_fd(fd);
+}
+
 int journal_monitor(void)
 {
-	return -ENOSYS;
+	int err, events, fd;
+
+	err = sd_journal_open(&journal, SD_JOURNAL_SYSTEM |
+					SD_JOURNAL_RUNTIME_ONLY |
+					SD_JOURNAL_LOCAL_ONLY);
+	if (err < 0)
+		goto failed;
+
+	err = sd_journal_add_match(journal, "_SYSTEMD_UNIT=bluetooth.service", 0);
+	if (err < 0)
+		goto failed;
+
+	err = sd_journal_add_disjunction(journal);
+	if (err < 0)
+		goto failed;
+
+	err = sd_journal_seek_tail(journal);
+	if (err < 0)
+		goto failed;
+
+	fd = sd_journal_get_fd(journal);
+	if (fd < 0) {
+		err = fd;
+		goto failed;
+	}
+
+	events = sd_journal_get_events(journal);
+	if (events < 0) {
+		err = events;
+		goto failed;
+	}
+
+	return mainloop_add_fd(fd, events, journal_event, journal,
+				journal_destroy);
+
+failed:
+	printf("Failed to listen for journal messages: %s (%d)\n",
+			strerror(-err), err);
+	journal_destroy(journal);
+	return err;
 }
-- 
1.8.5.3

