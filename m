Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/9] shared/hfp_at: Add function to close container
Date: Tue, 25 Feb 2014 10:23:45 +0100
Message-Id: <1393320227-10931-8-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1393320227-10931-1-git-send-email-marcin.kraglak@tieto.com>
References: <1393320227-10931-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will look for ")" parenthesis and skip it if found.
---
 src/shared/hfp_at.c | 13 +++++++++++++
 src/shared/hfp_at.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/src/shared/hfp_at.c b/src/shared/hfp_at.c
index 3bf1fd6..2db40b2 100644
--- a/src/shared/hfp_at.c
+++ b/src/shared/hfp_at.c
@@ -259,6 +259,19 @@ bool hfp_at_open_container(struct hfp_at *hfp_at, const char *data)
 	return true;
 }
 
+bool hfp_at_close_container(struct hfp_at *hfp_at, const char *data)
+{
+	hfp_at_skip_whitespace(hfp_at, data);
+
+	/* The list shall be followed by a right parenthesis (")" V250 5.7.3.1*/
+	if (data[hfp_at->offset] != ')')
+		return false;
+
+	hfp_at->offset++;
+
+	return true;
+}
+
 struct hfp_at *hfp_at_new(const struct hfp_at_handler *handlers)
 {
 	struct hfp_at *hfp_at;
diff --git a/src/shared/hfp_at.h b/src/shared/hfp_at.h
index d5dcf9d..e709acb 100644
--- a/src/shared/hfp_at.h
+++ b/src/shared/hfp_at.h
@@ -44,6 +44,7 @@ bool hfp_at_process_data(struct hfp_at *hfp_at, const char *data,
 
 bool hfp_at_get_number(struct hfp_at *hfp_at, const char *data, int *val);
 bool hfp_at_open_container(struct hfp_at *hfp_at, const char *data);
+bool hfp_at_close_container(struct hfp_at *hfp_at, const char *data);
 
 struct hfp_at *hfp_at_new(const struct hfp_at_handler *handlers);
 void hfp_at_free(struct hfp_at *hfp_at);
-- 
1.8.5.3

