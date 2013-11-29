Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Fix eir parsing function.
Date: Fri, 29 Nov 2013 10:00:49 +0200
Message-Id: <1385712049-24635-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Currently eir_parse always return 0 but it is checked throughout the
code (in android/bluetooth code as well in src/adapteri, etc) for
return value (err < 0) which never happens. Return -1 if there is
nothing to parse. Send as RFC as I do not know how current code supposed
to be working.
---
 src/eir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/eir.c b/src/eir.c
index 084884e..f7450c9 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -138,7 +138,7 @@ int eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
 
 	/* No EIR data to parse */
 	if (eir_data == NULL)
-		return 0;
+		return -1;
 
 	while (len < eir_len - 1) {
 		uint8_t field_len = eir_data[0];
-- 
1.8.3.2

