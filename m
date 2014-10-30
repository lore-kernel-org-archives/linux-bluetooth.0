Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] health: Keep struct element indentions consist
Date: Thu, 30 Oct 2014 16:32:41 +0100
Message-Id: <1414683161-4496-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Indentions should be tabbed to keep consist with other structs.
---
 profiles/health/mcap.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/profiles/health/mcap.h b/profiles/health/mcap.h
index 548d672..69873ca 100644
--- a/profiles/health/mcap.h
+++ b/profiles/health/mcap.h
@@ -124,12 +124,12 @@ typedef struct {
 } __attribute__ ((packed)) mcap_md_sync_rsp;
 
 typedef struct {
-        uint8_t         op;
-	uint8_t         rc;
-	uint8_t         btclock;
-        uint16_t        sltime;
-	uint16_t        timestnr;
-	uint16_t        timestna;
+	uint8_t		op;
+	uint8_t		rc;
+	uint8_t		btclock;
+	uint16_t	sltime;
+	uint16_t	timestnr;
+	uint16_t	timestna;
 } __attribute__ ((packed)) mcap_md_sync_cap_rsp;
 
 typedef struct {
-- 
1.9.3

