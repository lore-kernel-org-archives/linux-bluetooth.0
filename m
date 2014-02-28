Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 2/6] android/client: Add AVRCP get_element_attr_rsp support
Date: Fri, 28 Feb 2014 20:58:44 +0200
Message-Id: <1393613928-22264-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1393613928-22264-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1393613928-22264-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-rc.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/android/client/if-rc.c b/android/client/if-rc.c
index 7da26e6..5625e56 100644
--- a/android/client/if-rc.c
+++ b/android/client/if-rc.c
@@ -36,6 +36,16 @@ SINTMAP(btrc_play_status_t, -1, "(unknown)")
 	DELEMENT(BTRC_PLAYSTATE_ERROR),
 ENDMAP
 
+SINTMAP(btrc_media_attr_t, -1, "(unknown)")
+	DELEMENT(BTRC_MEDIA_ATTR_TITLE),
+	DELEMENT(BTRC_MEDIA_ATTR_ARTIST),
+	DELEMENT(BTRC_MEDIA_ATTR_ALBUM),
+	DELEMENT(BTRC_MEDIA_ATTR_TRACK_NUM),
+	DELEMENT(BTRC_MEDIA_ATTR_NUM_TRACKS),
+	DELEMENT(BTRC_MEDIA_ATTR_GENRE),
+	DELEMENT(BTRC_MEDIA_ATTR_PLAYING_TIME),
+ENDMAP
+
 static btrc_callbacks_t rc_cbacks = {
 	.size = sizeof(rc_cbacks),
 };
@@ -89,6 +99,41 @@ static void get_play_status_rsp_p(int argc, const char **argv)
 	EXEC(if_rc->get_play_status_rsp, play_status, song_len, song_pos);
 }
 
+/* get_element_attr_rsp */
+
+static void get_element_attr_rsp_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+	if (argc == 4) {
+		*user = TYPE_ENUM(btrc_media_attr_t);
+		*enum_func = enum_defines;
+	}
+}
+
+static void get_element_attr_rsp_p(int argc, const char **argv)
+{
+	uint8_t num_attr;
+	btrc_element_attr_val_t attrs;
+
+	RETURN_IF_NULL(if_rc);
+
+	if (argc <= 2) {
+		haltest_error("No number of attributes specified");
+		return;
+	}
+
+	if (argc <= 4) {
+		haltest_error("No attr id and value specified");
+		return;
+	}
+
+	num_attr = (uint8_t) atoi(argv[2]);
+	attrs.attr_id = str2btrc_media_attr_t(argv[3]);
+	strcpy((char *)attrs.text, argv[4]);
+
+	EXEC(if_rc->get_element_attr_rsp, num_attr, &attrs);
+}
+
 /* cleanup */
 
 static void cleanup_p(int argc, const char **argv)
@@ -103,6 +148,7 @@ static struct method methods[] = {
 	STD_METHOD(init),
 	STD_METHODCH(get_play_status_rsp,
 					"<play_status> <song_len> <song_pos>"),
+	STD_METHODCH(get_element_attr_rsp, "<num_attr> <attrs_id> <value>"),
 	STD_METHOD(cleanup),
 	END_METHOD
 };
-- 
1.8.3.2

