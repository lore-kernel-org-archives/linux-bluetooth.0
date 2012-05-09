Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH] eir: Keep parsed eir_data on error
Date: Wed, 9 May 2012 12:21:15 +0300
Message-ID: <1336555275-32638-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Do not discard already parsed eir_data on eir data length error.
Data corruption may occur, but this does not mean that we need
to ignore already parsed valid eir data
---
 src/eir.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/eir.c b/src/eir.c
index 310cd53..f2f6992 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -114,10 +114,9 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data, uint8_t eir_len)
 
 		len += field_len + 1;
 
-		/* Bail out if got incorrect length */
+		/* Do not continue EIR Data parsing if got incorrect length */
 		if (len > eir_len) {
-			eir_data_free(eir);
-			return -EINVAL;
+			return 0;
 		}
 
 		data_len = field_len - 1;
-- 
1.7.0.4

