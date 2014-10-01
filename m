Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH] obexd/src/main: Fix memory leak on obex server
Date: Wed, 01 Oct 2014 12:01:43 +0530
Message-id: <1412145103-4824-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Freeing the variables at appropriate place.
---
 obexd/src/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/obexd/src/main.c b/obexd/src/main.c
index 80645f8..7a1ab98 100644
--- a/obexd/src/main.c
+++ b/obexd/src/main.c
@@ -293,8 +293,9 @@ int main(int argc, char *argv[])
 		char *old_root = option_root, *home = getenv("HOME");
 		if (home) {
 			option_root = g_strdup_printf("%s/%s", home, old_root);
-			g_free(old_root);
+			g_free(home);
 		}
+		g_free(old_root);
 	}
 
 	if (option_capability == NULL)
-- 
1.9.1

