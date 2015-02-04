Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 7/9] client/display: Add rl_hexdump
Date: Wed,  4 Feb 2015 17:33:17 +0200
Message-Id: <1423063999-15734-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1423063999-15734-1-git-send-email-luiz.dentz@gmail.com>
References: <1423063999-15734-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 client/display.c | 41 +++++++++++++++++++++++++++++++++++++++++
 client/display.h |  1 +
 2 files changed, 42 insertions(+)

diff --git a/client/display.c b/client/display.c
index 0f212b6..619973c 100644
--- a/client/display.c
+++ b/client/display.c
@@ -62,3 +62,44 @@ void rl_printf(const char *fmt, ...)
 		free(saved_line);
 	}
 }
+
+void rl_hexdump(const unsigned char *buf, size_t len)
+{
+	static const char hexdigits[] = "0123456789abcdef";
+	char str[68];
+	size_t i;
+
+	if (!len)
+		return;
+
+	str[0] = ' ';
+
+	for (i = 0; i < len; i++) {
+		str[((i % 16) * 3) + 1] = ' ';
+		str[((i % 16) * 3) + 2] = hexdigits[buf[i] >> 4];
+		str[((i % 16) * 3) + 3] = hexdigits[buf[i] & 0xf];
+		str[(i % 16) + 51] = isprint(buf[i]) ? buf[i] : '.';
+
+		if ((i + 1) % 16 == 0) {
+			str[49] = ' ';
+			str[50] = ' ';
+			str[67] = '\0';
+			rl_printf("%s\n", str);
+			str[0] = ' ';
+		}
+	}
+
+	if (i % 16 > 0) {
+		size_t j;
+		for (j = (i % 16); j < 16; j++) {
+			str[(j * 3) + 1] = ' ';
+			str[(j * 3) + 2] = ' ';
+			str[(j * 3) + 3] = ' ';
+			str[j + 51] = ' ';
+		}
+		str[49] = ' ';
+		str[50] = ' ';
+		str[67] = '\0';
+		rl_printf("%s\n", str);
+	}
+}
diff --git a/client/display.h b/client/display.h
index 91a0be9..88dbbd0 100644
--- a/client/display.h
+++ b/client/display.h
@@ -30,3 +30,4 @@
 #define COLOR_BOLDWHITE	"\x1B[1;37m"
 
 void rl_printf(const char *fmt, ...) __attribute__((format(printf, 1, 2)));
+void rl_hexdump(const unsigned char *buf, size_t len);
-- 
2.1.0

