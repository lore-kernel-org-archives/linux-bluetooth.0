Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 1/7] Fix invalid memory access when EIR field length is zero
Date: Wed, 10 Nov 2010 13:51:21 -0400
Message-Id: <1289411487-6113-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

---
 src/adapter.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 31014e5..2f79e1c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2970,21 +2970,20 @@ static char **get_eir_uuids(uint8_t *eir_data, size_t *uuid_count)
 	size_t uuid16_count = 0;
 	size_t uuid32_count = 0;
 	size_t uuid128_count = 0;
-	uint8_t *uuid16;
-	uint8_t *uuid32;
-	uint8_t *uuid128;
+	uint8_t *uuid16 = 0;
+	uint8_t *uuid32 = 0;
+	uint8_t *uuid128 = 0;
 	uuid_t service;
 	unsigned int i;
 
 	while (len < EIR_DATA_LENGTH - 1) {
-		uint8_t type = eir_data[1];
 		uint8_t field_len = eir_data[0];
 
 		/* Check for the end of EIR */
 		if (field_len == 0)
 			break;
 
-		switch (type) {
+		switch (eir_data[1]) {
 		case EIR_UUID16_SOME:
 		case EIR_UUID16_ALL:
 			uuid16_count = field_len / 2;
-- 
1.7.0.4

