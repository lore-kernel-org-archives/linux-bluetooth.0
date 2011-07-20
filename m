Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH obexd 1/6] Support for semicolon escaping
Date: Wed, 20 Jul 2011 09:11:42 +0200
Message-Id: <1311145907-3874-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to specification of vcard 2.1, semicolon is only character
which is escaped with a backslash character (in vcard's property field
content). This patch provides "escape_semicolon" function which handles
this issue.
---
 plugins/vcard.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/plugins/vcard.c b/plugins/vcard.c
index b997fc4..4f61368 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -149,6 +149,20 @@ static void get_escaped_fields(char **fields, ...)
 	*fields = g_string_free(line, FALSE);
 }
 
+static void escape_semicolon(char *dest, const char *src, int len_max, int len)
+{
+	int i, j;
+
+	for (i = 0, j = 0; i < len && j < len_max - 1; i++, j++) {
+		if (src[i] == ';')
+			dest[j++] = '\\';
+
+		dest[j] = src[i];
+	}
+
+	dest[j] = 0;
+}
+
 static void vcard_printf_begin(GString *vcards, uint8_t format)
 {
 	vcard_printf(vcards, "BEGIN:VCARD");
-- 
1.6.3.3

