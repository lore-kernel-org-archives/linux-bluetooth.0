Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/9] shared/hfp_at: Add function to open container
Date: Tue, 25 Feb 2014 10:23:44 +0100
Message-Id: <1393320227-10931-7-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1393320227-10931-1-git-send-email-marcin.kraglak@tieto.com>
References: <1393320227-10931-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will look for "(" parenthesis and skip it if found.
---
 src/shared/hfp_at.c | 13 +++++++++++++
 src/shared/hfp_at.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/src/shared/hfp_at.c b/src/shared/hfp_at.c
index 623dab3..3bf1fd6 100644
--- a/src/shared/hfp_at.c
+++ b/src/shared/hfp_at.c
@@ -246,6 +246,19 @@ bool hfp_at_get_number(struct hfp_at *hfp_at, const char *data, int *val)
 	return true;
 }
 
+bool hfp_at_open_container(struct hfp_at *hfp_at, const char *data)
+{
+	hfp_at_skip_whitespace(hfp_at, data);
+
+	/* The list shall be preceded by a left parenthesis "(") */
+	if (data[hfp_at->offset] != '(')
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
index 2e2a757..d5dcf9d 100644
--- a/src/shared/hfp_at.h
+++ b/src/shared/hfp_at.h
@@ -43,6 +43,7 @@ bool hfp_at_process_data(struct hfp_at *hfp_at, const char *data,
 							void *user_data);
 
 bool hfp_at_get_number(struct hfp_at *hfp_at, const char *data, int *val);
+bool hfp_at_open_container(struct hfp_at *hfp_at, const char *data);
 
 struct hfp_at *hfp_at_new(const struct hfp_at_handler *handlers);
 void hfp_at_free(struct hfp_at *hfp_at);
-- 
1.8.5.3

