Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] shared/shell: Make bt_shell_hexdump use util_hexdump
Date: Mon,  5 Feb 2018 10:48:16 -0200
Message-Id: <20180205124818.23566-2-luiz.dentz@gmail.com>
In-Reply-To: <20180205124818.23566-1-luiz.dentz@gmail.com>
References: <20180205124818.23566-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/shell.c | 43 ++++++-------------------------------------
 1 file changed, 6 insertions(+), 37 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index f724c9881..69f303b51 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -386,45 +386,14 @@ void bt_shell_printf(const char *fmt, ...)
 	}
 }
 
-void bt_shell_hexdump(const unsigned char *buf, size_t len)
+static void print_string(const char *str, void *user_data)
 {
-	static const char hexdigits[] = "0123456789abcdef";
-	char str[68];
-	size_t i;
-
-	if (!len)
-		return;
-
-	str[0] = ' ';
-
-	for (i = 0; i < len; i++) {
-		str[((i % 16) * 3) + 1] = ' ';
-		str[((i % 16) * 3) + 2] = hexdigits[buf[i] >> 4];
-		str[((i % 16) * 3) + 3] = hexdigits[buf[i] & 0xf];
-		str[(i % 16) + 51] = isprint(buf[i]) ? buf[i] : '.';
-
-		if ((i + 1) % 16 == 0) {
-			str[49] = ' ';
-			str[50] = ' ';
-			str[67] = '\0';
-			bt_shell_printf("%s\n", str);
-			str[0] = ' ';
-		}
-	}
+	bt_shell_printf("%s\n", str);
+}
 
-	if (i % 16 > 0) {
-		size_t j;
-		for (j = (i % 16); j < 16; j++) {
-			str[(j * 3) + 1] = ' ';
-			str[(j * 3) + 2] = ' ';
-			str[(j * 3) + 3] = ' ';
-			str[j + 51] = ' ';
-		}
-		str[49] = ' ';
-		str[50] = ' ';
-		str[67] = '\0';
-		bt_shell_printf("%s\n", str);
-	}
+void bt_shell_hexdump(const unsigned char *buf, size_t len)
+{
+	util_hexdump(' ', buf, len, print_string, NULL);
 }
 
 void bt_shell_prompt_input(const char *label, const char *msg,
-- 
2.14.3

