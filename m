Return-Path: <cyrus@holtmann.org>
From: Sunil Kumar Behera <sunil.behera@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sunil Kumar Behera <sunil.behera@samsung.com>
Subject: [PATCH obexd] PBAP: Fix possible invalid memory access
Date: Tue, 10 Jan 2012 12:43:25 +0530
Message-id: <1326179605-3380-1-git-send-email-sunil.behera@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Issue: As reported by static code analyzer (Coverity), if
buffer is NULL and aparams is not NULL, then buffer gets
dereferenced in string_read function.
Fix: Application parameter is allocated only if maxlistcount
is zero during phonebooksize request and buffer is allocated
in case of pull phonebook request, hence modify logic to avoid
application parameter check, as it is tightly coupled with
maxlistcount.
---
 plugins/pbap.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index 0f07c46..eb2bc9c 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -996,11 +996,12 @@ static ssize_t vobject_pull_read(void *object, void *buf, size_t count)
 	DBG("buffer %p maxlistcount %d", obj->buffer,
 						pbap->params->maxlistcount);
 
-	if (!obj->buffer && !obj->aparams)
-		return -EAGAIN;
+	if (!obj->buffer) {
+		if (pbap->params->maxlistcount == 0)
+			return -ENOSTR;
 
-	if (pbap->params->maxlistcount == 0)
-		return -ENOSTR;
+		return -EAGAIN;
+	}
 
 	len = string_read(obj->buffer, buf, count);
 	if (len == 0 && !obj->lastpart) {
-- 
1.7.4.1

