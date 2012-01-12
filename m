Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH] Fix EIR name parsing
Date: Thu, 12 Jan 2012 14:33:37 -0400
Message-Id: <1326393217-13111-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some vendors put a NUL byte terminator on EIR name field. If that is the
case, use -1 as string length so g_utf8_validade() can parse it
properly.
---
 src/eir.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/src/eir.c b/src/eir.c
index e4554e8..3826f55 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -119,6 +119,7 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len)
 
 	while (len < eir_len - 1) {
 		uint8_t field_len = eir_data[0];
+		ssize_t name_len;
 
 		/* Check for the end of EIR */
 		if (field_len == 0)
@@ -154,8 +155,16 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len)
 
 		case EIR_NAME_SHORT:
 		case EIR_NAME_COMPLETE:
+			/* Some vendors put a NUL byte terminator. If that is
+			 * the case, use -1 as string length so
+			 * g_utf8_validade() can parse it properly. */
+			if (eir_data[field_len] == '\0')
+				name_len = -1;
+			else
+				name_len = field_len - 1;
+
 			if (!g_utf8_validate((char *) &eir_data[2],
-							field_len - 1, NULL))
+								name_len, NULL))
 				break;
 
 			g_free(eir->name);
-- 
1.7.0.4

