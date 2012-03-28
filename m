Return-Path: <cyrus@holtmann.org>
From: <james.steele@accenture.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <james.steele@accenture.com>
Subject: [PATCH v3 1/3] lib: Correct the HCI Testing OGF value
Date: Wed, 28 Mar 2012 14:31:26 +0000
Message-ID: <81C9FA9C1C2E9E45A9AC3EDD1858BC4323E11458@048-CH1MPN1-101.048d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch corrects the Testing OGF to match the value in the Bluetooth
specification, bringing it in line with the other defined OGF values.
---
 lib/hci.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/hci.h b/lib/hci.h
index 887a860..5fab92d 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -1428,7 +1428,7 @@ typedef struct {
 #define WRITE_REMOTE_AMP_ASSOC_RP_SIZE 2

 /* Testing commands */
-#define OGF_TESTING_CMD                0x3e
+#define OGF_TESTING_CMD                0x06

 #define OCF_READ_LOOPBACK_MODE                 0x0001

--
1.7.0.4




________________________________
Subject to local law, communications with Accenture and its affiliates including telephone calls and emails (including content), may be monitored by our systems for the purposes of security and the assessment of internal compliance with Accenture policy.
______________________________________________________________________________________

www.accenture.com

