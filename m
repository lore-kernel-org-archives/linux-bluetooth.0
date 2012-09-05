Return-Path: <cyrus@holtmann.org>
From: Anton Weber <ant@antweb.me>
To: linux-bluetooth@vger.kernel.org
Cc: Anton Weber <ant@antweb.me>
Subject: [PATCH BlueZ v3 3/6] replay: Add emulation support
Date: Wed,  5 Sep 2012 16:14:19 +0200
Message-Id: <1346854462-12396-3-git-send-email-ant@antweb.me>
In-Reply-To: <1346854462-12396-1-git-send-email-ant@antweb.me>
References: <1344533773-12914-1-git-send-email-ant@antweb.me>
 <1346854462-12396-1-git-send-email-ant@antweb.me>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Integrate emulator so it can process selected packets instead of
replaying them from the sequence. The behaviour is controlled
through the action attribute in hciseq_attr.

If set to HCISEQ_ACTION_EMULATE, hcireplay will use the emulator
to process the packet automatically instead of replaying it.
HCISEQ_ACTION_REPLAY keeps the previous behaviour and replays the
packet using the dump file.
---
 Makefile.tools        |    1 +
 tools/replay/hciseq.h |    1 +
 tools/replay/main.c   |   52 ++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 6767300..8b3c8d8 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -76,6 +76,7 @@ tools_replay_btreplay_SOURCES = tools/replay/main.h tools/replay/main.c \
 					monitor/btsnoop.h monitor/btsnoop.c \
 					monitor/control.h monitor/control.c \
 					monitor/mainloop.h monitor/mainloop.c \
+					emulator/btdev.h emulator/btdev.c \
 					lib/hci.h
 
 tools_replay_btreplay_LDADD = lib/libbluetooth-private.la
diff --git a/tools/replay/hciseq.h b/tools/replay/hciseq.h
index f9fe7c8..1454147 100644
--- a/tools/replay/hciseq.h
+++ b/tools/replay/hciseq.h
@@ -43,6 +43,7 @@ struct frame {
 
 enum hciseq_action {
 	HCISEQ_ACTION_REPLAY = 0,
+	HCISEQ_ACTION_EMULATE = 1
 };
 
 struct hciseq_list {
diff --git a/tools/replay/main.c b/tools/replay/main.c
index e026d98..dc281b0 100644
--- a/tools/replay/main.c
+++ b/tools/replay/main.c
@@ -43,6 +43,7 @@
 #include "time.h"
 #include "lib/bluetooth.h"
 #include "lib/hci.h"
+#include "emulator/btdev.h"
 #include "monitor/bt.h"
 #include "monitor/btsnoop.h"
 #include "monitor/control.h"
@@ -69,6 +70,8 @@ static int timing = TIMING_NONE;
 static double factor = 1;
 static bool verbose = false;
 
+static struct btdev *btdev;
+
 static inline int read_n(int fd, char *buf, int len)
 {
 	int t = 0, w;
@@ -250,6 +253,34 @@ static int recv_frm(int fd, struct frame *frm)
 	return n;
 }
 
+static void btdev_send(const void *data, uint16_t len, void *user_data)
+{
+	struct frame frm;
+	static void* tmpdata = NULL;
+
+	/* copy data so we respect 'const' qualifier */
+	if(tmpdata == NULL)
+		tmpdata = malloc(HCI_MAX_FRAME_SIZE);
+
+	memcpy(tmpdata, data, len);
+
+	frm.data = tmpdata;
+	frm.len = len;
+	frm.data_len = len;
+	frm.in = 1;
+	printf("[Emulator ] ");
+	dump_frame(&frm);
+	send_frm(&frm);
+}
+
+static void btdev_recv(struct frame *frm)
+{
+	frm->in = 0;
+	printf("[Emulator ] ");
+	dump_frame(frm);
+	btdev_receive_h4(btdev, frm->data, frm->data_len);
+}
+
 static bool check_match(struct frame *l, struct frame *r, char *msg)
 {
 	uint8_t type_l = ((const uint8_t *) l->data)[0];
@@ -332,11 +363,16 @@ static bool process_in()
 	match = check_match(dumpseq.current->frame, &frm, msg);
 
 	/* process packet if match */
-	if (match)
+	if (match) {
 		printf("[%4d/%4d] ", pos, dumpseq.len);
-	else
-		printf("[ Unknown ] %s\n            ", msg);
 
+		if (dumpseq.current->attr->action == HCISEQ_ACTION_EMULATE) {
+			btdev_recv(&frm);
+			return true;
+		}
+	} else {
+		printf("[ Unknown ] %s\n            ", msg);
+	}
 	dump_frame(&frm);
 
 	return match;
@@ -346,6 +382,11 @@ static bool process_out()
 {
 	uint8_t pkt_type;
 
+	/* emulator sends response automatically */
+	if (dumpseq.current->attr->action == HCISEQ_ACTION_EMULATE) {
+		return 1;
+	}
+
 	pkt_type = ((const uint8_t *) dumpseq.current->frame->data)[0];
 
 	switch (pkt_type) {
@@ -531,6 +572,10 @@ int main(int argc, char *argv[])
 	dumpseq.current = dumpseq.frames;
 	calc_rel_ts(&dumpseq);
 
+	/* init emulator */
+	btdev = btdev_create(0);
+	btdev_set_send_handler(btdev, btdev_send, NULL);
+
 	gettimeofday(&start, NULL);
 
 	/*
@@ -548,6 +593,7 @@ int main(int argc, char *argv[])
 	process();
 
 	vhci_close();
+	btdev_destroy(btdev);
 	delete_list();
 	printf("Terminating\n");
 
-- 
1.7.9.5

