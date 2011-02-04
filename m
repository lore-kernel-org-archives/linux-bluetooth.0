Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH] Fix refcount in btd_adapter_any_request_path()
Date: Fri,  4 Feb 2011 00:05:31 -0400
Message-Id: <1296792331-467-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

adapter_any_refcount was not being incremented when a pointer to
allocated buffer was returned.
---
 src/adapter.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 08098a5..3e609c1 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3428,11 +3428,10 @@ const char *adapter_any_get_path(void)
 
 const char *btd_adapter_any_request_path(void)
 {
-	if (adapter_any_refcount > 0)
+	if (adapter_any_refcount++ > 0)
 		return adapter_any_path;
 
 	adapter_any_path = g_strdup_printf("%s/any", manager_get_base_path());
-	adapter_any_refcount++;
 
 	return adapter_any_path;
 }
-- 
1.7.0.4

