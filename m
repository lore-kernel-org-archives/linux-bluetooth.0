Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 2/5] Add constraint on pulled path
Date: Mon,  4 Jul 2011 23:51:38 +0200
Message-Id: <1309816301-18377-2-git-send-email-bulislaw@linux.com>
In-Reply-To: <1309816301-18377-1-git-send-email-bulislaw@linux.com>
References: <1309816301-18377-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

EDS backend supports only phonebook (/telecom/pb.vcf).
---
 plugins/phonebook-ebook.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index f223965..dc78d17 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -513,6 +513,13 @@ void *phonebook_pull(const char *name, const struct apparam_field *params,
 {
 	struct query_context *data;
 
+	if (g_strcmp0("/telecom/pb.vcf", name) != 0) {
+		if (err)
+			*err = -ENOENT;
+
+		return NULL;
+	}
+
 	data = g_new0(struct query_context, 1);
 	data->contacts_cb = cb;
 	data->params = params;
-- 
1.7.5.3

