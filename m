Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/8] shared/util: Add strdelimit and strsuffix
Date: Wed, 21 Feb 2018 16:14:55 +0200
Message-Id: <20180221141456.6656-7-luiz.dentz@gmail.com>
In-Reply-To: <20180221141456.6656-1-luiz.dentz@gmail.com>
References: <20180221141456.6656-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/util.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 src/shared/util.h |  3 +++
 2 files changed, 48 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index f6f265e56..986e2b22d 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -980,3 +980,48 @@ const char *bt_appear_to_str(uint16_t appearance)
 
 	return str;
 }
+
+char *strdelimit(char *str, char *del, char c)
+{
+	char *dup;
+
+	if (!str)
+		return NULL;
+
+	dup = strdup(str);
+	if (dup[0] == '\0')
+		return dup;
+
+	while (del[0] != '\0') {
+		char *rep = dup;
+
+		while ((rep = strchr(rep, del[0])))
+			rep[0] = c;
+
+		del++;
+	}
+
+	return dup;
+}
+
+int strsuffix(const char *str, const char *suffix)
+{
+	int len;
+	int suffix_len;
+
+	if (!str || !suffix)
+		return false;
+
+	if (str[0] == '\0' && suffix[0] != '\0')
+		return false;
+
+	if (suffix[0] == '\0' && str[0] != '\0')
+		return false;
+
+	len = strlen(str);
+	suffix_len = strlen(suffix);
+	if (len < suffix_len)
+		return false;
+
+	return strncmp(str + len - suffix_len, suffix, suffix_len);
+}
diff --git a/src/shared/util.h b/src/shared/util.h
index 3f5f6dfb5..604dc3be4 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -92,6 +92,9 @@ do {						\
 #define newa(t, n) ((t*) alloca(sizeof(t)*(n)))
 #define malloc0(n) (calloc((n), 1))
 
+char *strdelimit(char *str, char *del, char c);
+int strsuffix(const char *str, const char *suffix);
+
 void *btd_malloc(size_t size);
 
 typedef void (*util_debug_func_t)(const char *str, void *user_data);
-- 
2.14.3

