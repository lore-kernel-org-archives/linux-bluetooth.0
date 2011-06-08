Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<ulrik.lauren@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] Remove unused enum from sap.h
Date: Wed, 8 Jun 2011 12:21:56 +0200
Message-ID: <1307528517-6956-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a leftover from sap code upstreaming process.
---
 sap/sap.h |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/sap/sap.h b/sap/sap.h
index 7c4a815..1dbb235 100644
--- a/sap/sap.h
+++ b/sap/sap.h
@@ -84,17 +84,6 @@ struct sap_message {
 	struct sap_parameter param[0];
 } __attribute__((packed));
 
-enum {
-	ICC_READER_UNSPECIFIED_ERROR, /* No further information available */
-	ICC_READER_NOT_PRESENT,       /* Card Reader removed or not present */
-	ICC_READER_BUSY,              /* Card Reader in use */
-	ICC_READER_CARD_POWERED_ON,   /* Card in reader and is powered on */
-	ICC_READER_DEACTIVATED,       /* Card Reader deactivated */
-	ICC_READER_CARD_POWERED_OFF,  /* Card in reader, but powered off */
-	ICC_READER_NO_CARD,           /* No card in reader */
-	ICC_READER_LAST
-};
-
 #define SAP_BUF_SIZE		512
 #define SAP_MSG_HEADER_SIZE	4
 
-- 
on behalf of ST-Ericsson

