Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 2/3] eir: Fix incorrect eir_length() parsing
Date: Mon, 16 Apr 2012 18:31:37 +0530
Message-id: <1334581298-11877-3-git-send-email-s.syam@samsung.com>
In-reply-to: <1334581298-11877-1-git-send-email-s.syam@samsung.com>
References: <1334581298-11877-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Issue:
The COD value displayed via dbus during inquiry is wrong.
This is because of the incorrect return length of the eir_length(),
which leads to appending the COD at wrong location.

Analysis:
After appending the COD at the end of the eir data, we can see
there are some '00' present in the eir field length in the eir file.
XX:XX:XX:XX:XX:XX 07095359414D5043020A040B0312111F110C110E110311
0000000000000000000000040D000142

Fix:
Corrected the length calculation in eir_length(), which is determining,
which position the COD should append
---
 src/eir.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/eir.c b/src/eir.c
index 7b7b705..d622b08 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -379,9 +379,9 @@ size_t eir_append_data(uint8_t *eir, size_t eir_len, uint8_t type,
 size_t eir_length(uint8_t *eir, size_t maxlen)
 {
 	uint8_t field_len;
-	size_t parsed, length;
+	size_t parsed = 0, length = 0;
 
-	for (parsed = 0, length = 0; parsed < maxlen - 1; parsed += field_len) {
+	while (parsed < maxlen - 1) {
 		field_len = eir[0];
 
 		if (field_len == 0)
-- 
1.7.4.1

