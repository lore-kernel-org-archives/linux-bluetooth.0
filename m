Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 9/9] shared/hfp_at: Add function to get unquoted string
Date: Tue, 25 Feb 2014 10:23:47 +0100
Message-Id: <1393320227-10931-10-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1393320227-10931-1-git-send-email-marcin.kraglak@tieto.com>
References: <1393320227-10931-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/hfp_at.c | 27 +++++++++++++++++++++++++++
 src/shared/hfp_at.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/src/shared/hfp_at.c b/src/shared/hfp_at.c
index 750133f..50e8614 100644
--- a/src/shared/hfp_at.c
+++ b/src/shared/hfp_at.c
@@ -278,6 +278,33 @@ bool hfp_at_get_string(struct hfp_at *hfp_at, const char *data, char *buf,
 	return true;
 }
 
+bool hfp_at_get_unquoted_string(struct hfp_at *hfp_at, const char *data,
+							char *buf, uint8_t len)
+{
+	int i = 0;
+	char c;
+
+	hfp_at_skip_whitespace(hfp_at, data);
+
+	c = data[hfp_at->offset];
+	if (c == '"' || c == ')' || c == '(')
+		return false;
+
+	while (data[hfp_at->offset] != '\0' && data[hfp_at->offset] != ','
+					&& data[hfp_at->offset] != ')') {
+		if (i < len)
+			buf[i++] = data[hfp_at->offset];
+		hfp_at->offset++;
+	}
+
+	if (i < len)
+		buf[i++] = '\0';
+
+	hfp_at_next_field(hfp_at, data);
+
+	return true;
+}
+
 bool hfp_at_open_container(struct hfp_at *hfp_at, const char *data)
 {
 	hfp_at_skip_whitespace(hfp_at, data);
diff --git a/src/shared/hfp_at.h b/src/shared/hfp_at.h
index 4da381b..76bdb03 100644
--- a/src/shared/hfp_at.h
+++ b/src/shared/hfp_at.h
@@ -47,6 +47,8 @@ bool hfp_at_open_container(struct hfp_at *hfp_at, const char *data);
 bool hfp_at_close_container(struct hfp_at *hfp_at, const char *data);
 bool hfp_at_get_string(struct hfp_at *hfp_at, const char *data, char *buf,
 								uint8_t len);
+bool hfp_at_get_unquoted_string(struct hfp_at *hfp_at, const char *data,
+							char *buf, uint8_t len);
 
 struct hfp_at *hfp_at_new(const struct hfp_at_handler *handlers);
 void hfp_at_free(struct hfp_at *hfp_at);
-- 
1.8.5.3

