Return-Path: <cyrus@holtmann.org>
From: <james.steele@accenture.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <james.steele@accenture.com>
Subject: [PATCH hcidump] Fix for parsing of SSP debug mode command.
Date: Mon, 19 Mar 2012 16:56:07 +0000
Message-ID: <81C9FA9C1C2E9E45A9AC3EDD1858BC4323E01ACF@048-CH1MPN1-101.048d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: James Steele <james.steele@accenture.com>

---
 lib/hci.h    |    2 +-
 parser/hci.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/hci.h b/lib/hci.h
index b68dbc2..1765655 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -1419,7 +1419,7 @@ typedef struct {
 #define WRITE_REMOTE_AMP_ASSOC_RP_SIZE 2

 /* Testing commands */
-#define OGF_TESTING_CMD                0x3e
+#define OGF_TESTING_CMD                0x06

 #define OCF_READ_LOOPBACK_MODE                 0x0001

diff --git a/parser/hci.c b/parser/hci.c
index e459e9e..7b7682a 100644
--- a/parser/hci.c
+++ b/parser/hci.c
@@ -373,7 +373,7 @@ static char *cmd_testing_str[CMD_TESTING_NUM + 1] = {
        "Read Loopback Mode",
        "Write Loopback Mode",
        "Enable Device Under Test mode",
-       "Unknown",
+       "Write Simple Pairing Debug Mode",
 };

 #define CMD_LE_NUM 31
--
1.7.0.4


________________________________
Subject to local law, communications with Accenture and its affiliates including telephone calls and emails (including content), may be monitored by our systems for the purposes of security and the assessment of internal compliance with Accenture policy.
______________________________________________________________________________________

www.accenture.com

