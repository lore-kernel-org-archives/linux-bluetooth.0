Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH obexd 1/7] phonebook-dummy: Fix use of uninitialized count variable
Date: Wed, 13 Jun 2012 22:49:17 +0200
Message-Id: <1339620563-25161-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If opendir() call fails count would be passed to callback
uninitialized.
---
 plugins/phonebook-dummy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/phonebook-dummy.c b/plugins/phonebook-dummy.c
index 035ec35..6b9d040 100644
--- a/plugins/phonebook-dummy.c
+++ b/plugins/phonebook-dummy.c
@@ -218,7 +218,7 @@ static gboolean read_dir(void *user_data)
 	struct dummy_data *dummy = user_data;
 	GString *buffer;
 	DIR *dp;
-	uint16_t count, max, offset;
+	uint16_t count = 0, max, offset;
 
 	buffer = g_string_new("");
 
-- 
1.7.10.4


