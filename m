Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] client: Fix typo
Date: Fri,  5 Sep 2014 15:49:10 +0300
Message-Id: <1409921352-28485-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1409921352-28485-1-git-send-email-luiz.dentz@gmail.com>
References: <1409921352-28485-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 client/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/main.c b/client/main.c
index ae8aa92..ea80ee7 100644
--- a/client/main.c
+++ b/client/main.c
@@ -166,7 +166,7 @@ static void print_iter(const char *label, const char *name,
 
 	switch (dbus_message_iter_get_arg_type(iter)) {
 	case DBUS_TYPE_INVALID:
-		rl_printf("%s%s is inavlid\n", label, name);
+		rl_printf("%s%s is invalid\n", label, name);
 		break;
 	case DBUS_TYPE_STRING:
 	case DBUS_TYPE_OBJECT_PATH:
-- 
1.9.3

