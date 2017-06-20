Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Sathish Narasimman <nsathish41@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] obexd/map: msg dummy implemnt MSE message viewing
Date: Tue, 20 Jun 2017 16:01:42 +0530
Message-Id: <1497954702-31647-1-git-send-email-nsathish41@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Sathish Narasimman <sathish.narasimman@intel.com>

Messages viewing functionality is implemented in the patch. Which
reads the message from MSE using message handle provided by MCE.

> ACL Data RX: Handle 256 flags 0x02 dlen 93
      Channel: 64 len 89 [PSM 3 mode 0] {chan 0}
      RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
         Address: 0x83 cr 1 dlci 0x20
         Control: 0xef poll/final 0
         Length: 85
         FCS: 0xd8
        82 00 55 cb 00 00 00 01 01 00 25 00 30 00 34 00  ..U.......%.0.4.
        30 00 30 00 30 00 30 00 30 00 30 00 30 00 30 00  0.0.0.0.0.0.0.0.
        30 00 30 00 30 00 30 00 30 00 37 00 00 42 00 16  0.0.0.0.0.7..B..
        78 2d 62 74 2f 6d 65 73 73 61 67 65 53 74 61 74  x-bt/messageStat
        75 73 00 c3 00 00 00 01 4c 00 09 17 01 00 18 01  us......L.......
        01 49 00 04 30 d8                                .I..0.
< ACL Data TX: Handle 256 flags 0x00 dlen 11
      Channel: 65 len 7 [PSM 3 mode 0] {chan 0}
      RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
         Address: 0x81 cr 0 dlci 0x20
         Control: 0xef poll/final 0
         Length: 3
         FCS: 0x02
        a0 00 03 02                                      ....
> ACL Data RX: Handle 256 flags 0x02 dlen 82
      Channel: 64 len 78 [PSM 3 mode 0] {chan 0}
      RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
         Address: 0x83 cr 1 dlci 0x20
         Control: 0xff poll/final 1
         Length: 73
         FCS: 0xc4
         Credits: 1
        83 00 49 cb 00 00 00 01 01 00 25 00 30 00 34 00  ..I.......%.0.4.
        30 00 30 00 30 00 30 00 30 00 30 00 30 00 30 00  0.0.0.0.0.0.0.0.
        30 00 30 00 30 00 30 00 30 00 37 00 00 42 00 10  0.0.0.0.0.7..B..
        78 2d 62 74 2f 6d 65 73 73 61 67 65 00 4c 00 0c  x-bt/message.L..
        0a 01 01 14 01 01 15 01 00 c4                    ..........
< ACL Data TX: Handle 256 flags 0x00 dlen 305
      Channel: 65 len 301 [PSM 3 mode 0] {chan 0}
      RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
         Address: 0x81 cr 0 dlci 0x20
         Control: 0xef poll/final 0
         Length: 10241
         FCS: 0x02
        90 01 28 48 01 25 42 45 47 49 4e 3a 42 4d 53 47  ..(H.%BEGIN:BMSG
        0d 0a 56 45 52 53 49 4f 4e 3a 31 2e 30 0d 0a 53  ..VERSION:1.0..S
        54 41 54 55 53 3a 52 45 41 44 0d 0a 54 59 50 45  TATUS:READ..TYPE
        3a 53 4d 53 5f 47 53 4d 0d 0a 46 4f 4c 44 45 52  :SMS_GSM..FOLDER
        3a 74 65 6c 65 63 6f 6d 2f 6d 73 67 2f 49 4e 42  :telecom/msg/INB
        4f 58 0d 0a 42 45 47 49 4e 3a 56 43 41 52 44 0d  OX..BEGIN:VCARD.
        0a 56 45 52 53 49 4f 4e 3a 33 2e 30 0d 0a 46 4e  .VERSION:3.0..FN
        3a 0d 0a 4e 3a 0d 0a 54 45 4c 3a 31 32 31 0d 0a  :..N:..TEL:121..
        45 4e 44 3a 56 43 41 52 44 0d 0a 42 45 47 49 4e  END:VCARD..BEGIN
        3a 42 45 4e 56 0d 0a 42 45 47 49 4e 3a 42 42 4f  :BENV..BEGIN:BBO
        44 59 0d 0a 43 48 41 52 53 45 54 3a 55 54 46 2d  DY..CHARSET:UTF-
        38 0d 0a 4c 45 4e 47 54 48 3a 37 35 0d 0a 42 45  8..LENGTH:75..BE
        47 49 4e 3a 4d 53 47 0d 0a 54 68 69 73 20 69 73  GIN:MSG..This is
        20 6e 6f 74 20 61 20 76 61 6c 69 64 20 6b 65 79   not a valid key
        77 6f 72 64 2c 20 70 6c 65 61 73 65 20 73 65 6e  word, please sen
        64 20 48 45 4c 50 20 74 6f 20 31 32 31 2e 0d 0a  d HELP to 121...
        45 4e 44 3a 4d 53 47 0d 0a 45 4e 44 3a 42 42 4f  END:MSG..END:BBO
        44 59 0d 0a 45 4e 44 3a 42 45 4e 56 0d 0a 45 4e  DY..END:BENV..EN
        44 3a 42 4d 53 47 0d 0a 02                       D:BMSG...
---
 obexd/plugins/messages-dummy.c | 54 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/obexd/plugins/messages-dummy.c b/obexd/plugins/messages-dummy.c
index 3eca9ef..9d9bcac 100644
--- a/obexd/plugins/messages-dummy.c
+++ b/obexd/plugins/messages-dummy.c
@@ -69,6 +69,15 @@ struct message_listing_data {
 	void *user_data;
 };
 
+struct message_view_data {
+	struct session *session;
+	const char *handle;
+	char *path;
+	FILE *fp;
+	messages_get_message_cb callback;
+	void *user_data;
+};
+
 /* NOTE: Neither IrOBEX nor MAP specs says that folder listing needs to
  * be sorted (in IrOBEX examples it is not). However existing implementations
  * seem to follow the fig. 3-2 from MAP specification v1.0, and I've seen a
@@ -433,6 +442,24 @@ static const GMarkupParser max_msg_parser = {
         NULL
 };
 
+static gboolean get_messages(void *d)
+{
+	struct message_view_data *mvd = d;
+	/* 1024 is the maximum size of the line which is calculated to be more
+	 * sufficient*/
+	char buffer[1024];
+
+	while (fgets(buffer, 1024, mvd->fp))
+		mvd->callback(mvd->session, -EAGAIN, 0, buffer , mvd->user_data);
+
+	mvd->callback(mvd->session, 0, 0, NULL , mvd->user_data);
+
+	g_free(mvd->path);
+	fclose(mvd->fp);
+
+	return FALSE;
+}
+
 static gboolean get_messages_listing(void *d)
 {
 
@@ -518,7 +545,26 @@ int messages_get_message(void *session, const char *handle,
 					messages_get_message_cb callback,
 					void *user_data)
 {
-	return -ENOSYS;
+	struct session *s =  session;
+	struct message_view_data *mvd;
+
+	mvd = g_new0(struct message_view_data, 1);
+	mvd->session = s;
+	mvd->handle = handle;
+	mvd->callback = callback;
+	mvd->user_data = user_data;
+
+	mvd->path = g_build_filename(s->cwd_absolute, handle, NULL);
+	mvd->fp = fopen(mvd->path, "r");
+	if (mvd->fp == NULL) {
+		int err = -errno;
+		DBG("fopen(): %d, %s", -err, strerror(-err));
+		g_free(mvd->path);
+		return -ENOENT;
+	}
+
+	g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, get_messages, mvd, g_free);
+	return 0;
 }
 
 int messages_update_inbox(void *session, messages_status_cb callback,
@@ -530,7 +576,11 @@ int messages_update_inbox(void *session, messages_status_cb callback,
 int messages_set_read(void *session, const char *handle, uint8_t value,
 				messages_status_cb callback, void *user_data)
 {
-	return -ENOSYS;
+	struct session *s = session;
+
+	callback(s, 0, user_data);
+
+	return 0;
 }
 
 int messages_set_delete(void *session, const char *handle, uint8_t value,
-- 
2.7.4

