Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/7] tools/hciattach: Fix not checking the size given to strcat
Date: Wed, 12 Aug 2015 18:07:11 +0300
Message-Id: <1439392033-11822-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1439392033-11822-1-git-send-email-luiz.dentz@gmail.com>
References: <1439392033-11822-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

strcat will attempt to append the 2 strings but it assumes the
destination is big enough to hold the result.
---
 tools/hciattach.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/hciattach.c b/tools/hciattach.c
index 4dc5be5..59a76a7 100644
--- a/tools/hciattach.c
+++ b/tools/hciattach.c
@@ -1358,6 +1358,12 @@ int main(int argc, char *argv[])
 			dev[0] = 0;
 			if (!strchr(opt, '/'))
 				strcpy(dev, "/dev/");
+
+			if (strlen(opt) > PATH_MAX - (strlen(dev) + 1)) {
+				fprintf(stderr, "Invalid serial device\n");
+				exit(1);
+			}
+
 			strcat(dev, opt);
 			break;
 
-- 
2.4.3

