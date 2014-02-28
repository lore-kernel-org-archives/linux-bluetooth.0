Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 3/6] android/client: Add AVRCP set_volume support
Date: Fri, 28 Feb 2014 20:58:45 +0200
Message-Id: <1393613928-22264-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1393613928-22264-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1393613928-22264-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-rc.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/android/client/if-rc.c b/android/client/if-rc.c
index 5625e56..5aab8e0 100644
--- a/android/client/if-rc.c
+++ b/android/client/if-rc.c
@@ -134,6 +134,29 @@ static void get_element_attr_rsp_p(int argc, const char **argv)
 	EXEC(if_rc->get_element_attr_rsp, num_attr, &attrs);
 }
 
+/* set_volume */
+
+static void set_volume_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+}
+
+static void set_volume_p(int argc, const char **argv)
+{
+	uint8_t volume;
+
+	RETURN_IF_NULL(if_rc);
+
+	if (argc <= 2) {
+		haltest_error("No volume specified");
+		return;
+	}
+
+	volume = (uint8_t) atoi(argv[2]);
+
+	EXEC(if_rc->set_volume, volume);
+}
+
 /* cleanup */
 
 static void cleanup_p(int argc, const char **argv)
@@ -149,6 +172,7 @@ static struct method methods[] = {
 	STD_METHODCH(get_play_status_rsp,
 					"<play_status> <song_len> <song_pos>"),
 	STD_METHODCH(get_element_attr_rsp, "<num_attr> <attrs_id> <value>"),
+	STD_METHODCH(set_volume, "<volume>"),
 	STD_METHOD(cleanup),
 	END_METHOD
 };
-- 
1.8.3.2

