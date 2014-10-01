Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, d.kasatkin@samsung.com,
	bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH] obexd/src/main: Fix coding style and improves readability
Date: Wed, 01 Oct 2014 19:18:29 +0530
Message-id: <1412171309-16184-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 obexd/src/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/obexd/src/main.c b/obexd/src/main.c
index 80645f8..0040c1e 100644
--- a/obexd/src/main.c
+++ b/obexd/src/main.c
@@ -199,7 +199,8 @@ const char *obex_option_capability(void)
 	return option_capability;
 }
 
-static gboolean is_dir(const char *dir) {
+static gboolean is_dir(const char *dir)
+{
 	struct stat st;
 
 	if (stat(dir, &st) < 0) {
@@ -290,8 +291,9 @@ int main(int argc, char *argv[])
 	}
 
 	if (option_root[0] != '/') {
-		char *old_root = option_root, *home = getenv("HOME");
+		const char *home = getenv("HOME");
 		if (home) {
+			char *old_root = option_root;
 			option_root = g_strdup_printf("%s/%s", home, old_root);
 			g_free(old_root);
 		}
-- 
1.9.1

