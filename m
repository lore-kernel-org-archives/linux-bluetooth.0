Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 13/19] android/avrcp-lib: Add SetBrowsed structs
Date: Fri,  3 Oct 2014 15:32:53 +0300
Message-Id: <1412339579-8292-14-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
References: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index e113c96..57c491a 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -205,6 +205,18 @@ struct set_addressed_rsp {
 	uint8_t status;
 } __attribute__ ((packed));
 
+struct set_browsed_req {
+	uint16_t id;
+} __attribute__ ((packed));
+
+struct set_browsed_rsp {
+	uint8_t status;
+	uint16_t counter;
+	uint16_t charset;
+	uint32_t items;
+	uint8_t depth;
+} __attribute__ ((packed));
+
 struct avrcp_control_handler {
 	uint8_t id;
 	uint8_t code;
@@ -2442,9 +2454,10 @@ static gboolean set_browsed_rsp(struct avctp *conn, uint8_t *operands,
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->player;
 	struct avrcp_browsing_header *pdu;
+	struct set_browsed_rsp *rsp;
 	uint16_t counter = 0;
 	uint32_t items = 0;
-	uint8_t depth = 0, count;
+	uint8_t count;
 	char **folders, *path = NULL;
 	int err;
 	size_t i;
@@ -2464,20 +2477,21 @@ static gboolean set_browsed_rsp(struct avctp *conn, uint8_t *operands,
 	if (err < 0)
 		goto done;
 
-	if (pdu->params_len < 10) {
+	if (pdu->params_len < sizeof(*rsp)) {
 		err = -EPROTO;
 		goto done;
 	}
 
-	counter = get_be16(&pdu->params[1]);
-	items = get_be32(&pdu->params[3]);
-	depth = pdu->params[9];
+	rsp = (void *) pdu->params;
+
+	counter = get_be16(&rsp->counter);
+	items = get_be32(&rsp->items);
 
-	folders = g_new0(char *, depth + 2);
+	folders = g_new0(char *, rsp->depth + 2);
 	folders[0] = g_strdup("/Filesystem");
 
-	for (i = 10, count = 1; count - 1 < depth && i < pdu->params_len;
-								count++) {
+	for (i = sizeof(*rsp), count = 1; count - 1 < rsp->depth &&
+						i < pdu->params_len; count++) {
 		uint8_t len;
 
 		len = pdu->params[i++];
-- 
1.9.3

