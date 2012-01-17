Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/3] Fix wrong offset in EIR name parsing
Date: Tue, 17 Jan 2012 12:18:00 -0400
Message-Id: <1326817082-6787-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When looking for NUL byte terminators on EIR names, the first two bytes
of the EIR field should be skipped, which correspond to field length and
EIR type.
---
 src/eir.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/eir.c b/src/eir.c
index 1b68949..ff50cf8 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -159,7 +159,8 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len)
 			 * the name */
 			name_len = field_len - 1;
 
-			while (name_len > 0 && eir_data[name_len - 1] == '\0')
+			while (name_len > 0 &&
+					eir_data[2 + name_len - 1] == '\0')
 				name_len--;
 
 			if (!g_utf8_validate((char *) &eir_data[2],
-- 
1.7.0.4

