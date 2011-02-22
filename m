Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH v2 6/7] Move attr_data_from_string() to utils.c
Date: Tue, 22 Feb 2011 16:12:03 -0300
Message-Id: <1298401924-20094-6-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1298401924-20094-1-git-send-email-sheldon.demario@openbossa.org>
References: <1298401924-20094-1-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1298328606-7993-1-git-send-email-sheldon.demario@openbossa.org>
References: <1298328606-7993-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

The attr_data_from_string() function will be used in interactive and
usual gatttool so this function was moved to common file utils.c.
---
 attrib/gatttool.c |   23 ++---------------------
 attrib/gatttool.h |    1 +
 attrib/utils.c    |   19 +++++++++++++++++++
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 7478043..d7887c6 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -313,25 +313,6 @@ static gboolean characteristics_read(gpointer user_data)
 	return FALSE;
 }
 
-static size_t attr_data_from_string(const char *str, uint8_t **data)
-{
-	char tmp[3];
-	size_t size, i;
-
-	size = strlen(str) / 2;
-	*data = g_try_malloc0(size);
-	if (*data == NULL)
-		return 0;
-
-	tmp[2] = '\0';
-	for (i = 0; i < size; i++) {
-		memcpy(tmp, str + (i * 2), 2);
-		(*data)[i] = (uint8_t) strtol(tmp, NULL, 16);
-	}
-
-	return size;
-}
-
 static void mainloop_quit(gpointer user_data)
 {
 	uint8_t *value = user_data;
@@ -356,7 +337,7 @@ static gboolean characteristics_write(gpointer user_data)
 		goto error;
 	}
 
-	len = attr_data_from_string(opt_value, &value);
+	len = gatt_attr_data_from_string(opt_value, &value);
 	if (len == 0) {
 		g_printerr("Invalid value\n");
 		goto error;
@@ -408,7 +389,7 @@ static gboolean characteristics_write_req(gpointer user_data)
 		goto error;
 	}
 
-	len = attr_data_from_string(opt_value, &value);
+	len = gatt_attr_data_from_string(opt_value, &value);
 	if (len == 0) {
 		g_printerr("Invalid value\n");
 		goto error;
diff --git a/attrib/gatttool.h b/attrib/gatttool.h
index 7eae18d..2fd4a46 100644
--- a/attrib/gatttool.h
+++ b/attrib/gatttool.h
@@ -25,3 +25,4 @@ int interactive(gchar *dst, gboolean le);
 GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
 			const gchar *sec_level, int psm, int mtu,
 			BtIOConnect connect_cb);
+size_t gatt_attr_data_from_string(const char *str, uint8_t **data);
diff --git a/attrib/utils.c b/attrib/utils.c
index 4d0000d..8d1ca74 100644
--- a/attrib/utils.c
+++ b/attrib/utils.c
@@ -104,3 +104,22 @@ GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
 
 	return chan;
 }
+
+size_t gatt_attr_data_from_string(const char *str, uint8_t **data)
+{
+	char tmp[3];
+	size_t size, i;
+
+	size = strlen(str) / 2;
+	*data = g_try_malloc0(size);
+	if (*data == NULL)
+		return 0;
+
+	tmp[2] = '\0';
+	for (i = 0; i < size; i++) {
+		memcpy(tmp, str + (i * 2), 2);
+		(*data)[i] = (uint8_t) strtol(tmp, NULL, 16);
+	}
+
+	return size;
+}
-- 
1.7.1

