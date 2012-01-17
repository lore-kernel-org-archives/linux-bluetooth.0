Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/3] Fix g_strndup() call for EIR name
Date: Tue, 17 Jan 2012 12:18:01 -0400
Message-Id: <1326817082-6787-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1326817082-6787-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1326817082-6787-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use the actual string length (without the trailing NUL terminator) for
g_strndup(), because it allocates and inserts a trailing NUL byte.
---
 src/eir.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/src/eir.c b/src/eir.c
index ff50cf8..96aa763 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -169,8 +169,7 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len)
 
 			g_free(eir->name);
 
-			eir->name = g_strndup((char *) &eir_data[2],
-								field_len - 1);
+			eir->name = g_strndup((char *) &eir_data[2], name_len);
 			eir->name_complete = eir_data[1] == EIR_NAME_COMPLETE;
 			break;
 		}
-- 
1.7.0.4

