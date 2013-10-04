Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 02/14] obexd/bluetooth: Make dict_append_entry function static
Date: Fri, 4 Oct 2013 11:05:26 +0200
Message-ID: <1380877538-22614-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1380877538-22614-1-git-send-email-szymon.janc@tieto.com>
References: <1380877538-22614-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix following build error:

  CC     obexd/plugins/obexd-bluetooth.o
obexd/plugins/bluetooth.c:242:6: error: no previous declaration for
     ‘dict_append_entry’ [-Werror=missing-declarations]
---
 obexd/plugins/bluetooth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
index 7f8a26d..143d0c2 100644
--- a/obexd/plugins/bluetooth.c
+++ b/obexd/plugins/bluetooth.c
@@ -239,7 +239,7 @@ static void append_variant(DBusMessageIter *iter, int type, void *val)
 }
 
 
-void dict_append_entry(DBusMessageIter *dict,
+static void dict_append_entry(DBusMessageIter *dict,
 			const char *key, int type, void *val)
 {
 	DBusMessageIter entry;
-- 
1.8.4

