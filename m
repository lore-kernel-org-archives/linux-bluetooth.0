Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ v3 08/18] storage: Do not store address type twice
Date: Fri, 25 May 2012 12:47:00 -0300
Message-Id: <1337960830-3506-9-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1337960830-3506-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
 <1337960830-3506-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

"longtermkeys" file already includes address type in its keys. It isn't
necessary to store the address type in its value as well.
---
 src/event.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/event.c b/src/event.c
index e453e13..a1fc016 100644
--- a/src/event.c
+++ b/src/event.c
@@ -385,8 +385,8 @@ static int store_longtermkey(bdaddr_t *local, bdaddr_t *peer,
 	newkey = g_string_new(val);
 	g_free(val);
 
-	g_string_append_printf(newkey, " %d %d %d %d %d ", bdaddr_type,
-					authenticated, master, enc_size, ediv);
+	g_string_append_printf(newkey, " %d %d %d %d ", authenticated, master,
+								enc_size, ediv);
 
 	str = buf2str(rand, 8);
 	if (str == NULL) {
-- 
1.7.7.6

