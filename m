Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 3/3] eir: Fix incorrect eir_has_data_type() parsing
Date: Mon, 16 Apr 2012 18:31:38 +0530
Message-id: <1334581298-11877-4-git-send-email-s.syam@samsung.com>
In-reply-to: <1334581298-11877-1-git-send-email-s.syam@samsung.com>
References: <1334581298-11877-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Updating the "parsed" variable twice inside the for loop, leads to
incorrect parsing.
---
 src/eir.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/eir.c b/src/eir.c
index d622b08..cdf3e8f 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -343,9 +343,9 @@ void eir_create(const char *name, int8_t tx_power, uint16_t did_vendor,
 gboolean eir_has_data_type(uint8_t *data, size_t len, uint8_t type)
 {
 	uint8_t field_len;
-	size_t parsed;
+	size_t parsed = 0;
 
-	for (parsed = 0; parsed < len - 1; parsed += field_len) {
+	while (parsed < len - 1) {
 		field_len = data[0];
 
 		if (field_len == 0)
-- 
1.7.4.1

