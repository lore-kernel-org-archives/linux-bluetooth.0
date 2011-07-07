Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ v3 9/9] Add support for btiotest to returning the key size
Date: Thu,  7 Jul 2011 19:03:30 -0300
Message-Id: <1310076210-15565-9-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1310076210-15565-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1310076210-15565-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/btiotest.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/test/btiotest.c b/test/btiotest.c
index c4d8f4f..fdf2234 100644
--- a/test/btiotest.c
+++ b/test/btiotest.c
@@ -135,6 +135,19 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 			printf("imtu=%u, omtu=%u\n", imtu, omtu);
 	}
 
+	if (data->type == BT_IO_L2CAP) {
+		uint8_t key_size;
+
+		if (!bt_io_get(io, data->type, &err,
+					BT_IO_OPT_KEY_SIZE, &key_size,
+					BT_IO_OPT_INVALID)) {
+			printf("Unable to get L2CAP Key size: %s\n",
+								err->message);
+			g_clear_error(&err);
+		} else
+			printf("key_size=%u\n", key_size);
+	}
+
 	if (data->disconn == 0) {
 		g_io_channel_shutdown(io, TRUE, NULL);
 		printf("Disconnected\n");
-- 
1.7.6

