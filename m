Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/9] shared/hfp_at: Add function for getting number
Date: Tue, 25 Feb 2014 10:23:43 +0100
Message-Id: <1393320227-10931-6-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1393320227-10931-1-git-send-email-marcin.kraglak@tieto.com>
References: <1393320227-10931-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will fetch decimal value from AT command.
---
 src/shared/hfp_at.c | 40 ++++++++++++++++++++++++++++++++++++++++
 src/shared/hfp_at.h |  2 ++
 2 files changed, 42 insertions(+)

diff --git a/src/shared/hfp_at.c b/src/shared/hfp_at.c
index eff0a38..623dab3 100644
--- a/src/shared/hfp_at.c
+++ b/src/shared/hfp_at.c
@@ -206,6 +206,46 @@ bool hfp_at_process_data(struct hfp_at *hfp_at, const char *data,
 		return hfp_at_process_basic(hfp_at, data, user_data);
 }
 
+static void hfp_at_next_field(struct hfp_at *hfp_at, const char *data)
+{
+	if (data[hfp_at->offset] == ',')
+		hfp_at->offset++;
+}
+
+static void hfp_at_skip_whitespace(struct hfp_at *hfp_at, const char *data)
+{
+	while (data[hfp_at->offset] == ' ')
+		hfp_at->offset++;
+}
+
+bool hfp_at_get_number(struct hfp_at *hfp_at, const char *data, int *val)
+{
+	int temp = 0;
+	int i;
+
+	hfp_at_skip_whitespace(hfp_at, data);
+
+	i = hfp_at->offset;
+
+	while (data[i] >= '0' && data[i] <= '9') {
+		temp *= 10;
+		temp += data[i++] - '0';
+	}
+
+	if (i == hfp_at->offset)
+		return false;
+
+	if (val)
+		*val = temp;
+
+	hfp_at->offset = i;
+
+	hfp_at_skip_whitespace(hfp_at, data);
+	hfp_at_next_field(hfp_at, data);
+
+	return true;
+}
+
 struct hfp_at *hfp_at_new(const struct hfp_at_handler *handlers)
 {
 	struct hfp_at *hfp_at;
diff --git a/src/shared/hfp_at.h b/src/shared/hfp_at.h
index 0b628b5..2e2a757 100644
--- a/src/shared/hfp_at.h
+++ b/src/shared/hfp_at.h
@@ -42,5 +42,7 @@ struct hfp_at_handler {
 bool hfp_at_process_data(struct hfp_at *hfp_at, const char *data,
 							void *user_data);
 
+bool hfp_at_get_number(struct hfp_at *hfp_at, const char *data, int *val);
+
 struct hfp_at *hfp_at_new(const struct hfp_at_handler *handlers);
 void hfp_at_free(struct hfp_at *hfp_at);
-- 
1.8.5.3

