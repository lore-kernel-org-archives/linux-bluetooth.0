Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH v2 1/7] Fix invalid memory access when EIR field length is zero
Date: Thu, 11 Nov 2010 15:51:55 -0300
Message-Id: <1289501521-21825-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

---
 src/adapter.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b1aabbd..8b742b7 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2977,14 +2977,13 @@ static char **get_eir_uuids(uint8_t *eir_data, size_t *uuid_count)
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
1.7.3.2

