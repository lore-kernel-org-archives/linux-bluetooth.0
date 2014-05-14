Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/2] lib: Update indexes in mgmt string translation arrays
Date: Wed, 14 May 2014 15:18:01 +0200
Message-ID: <1400073481-7099-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1400073481-7099-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1400073481-7099-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/mgmt.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index ab45735..9bdd341 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -561,7 +561,7 @@ static const char *mgmt_op[] = {
 	"Confirm Name",
 	"Block Device",
 	"Unblock Device",
-	"Set Device ID",
+	"Set Device ID",		/* 0x0028 */
 	"Set Advertising",
 	"Set BR/EDR",
 	"Set Static Address",
@@ -569,7 +569,7 @@ static const char *mgmt_op[] = {
 	"Set Secure Connections",
 	"Set Debug Keys",
 	"Set Privacy",
-	"Load Identity Resolving Keys",
+	"Load Identity Resolving Keys",	/* 0x0030 */
 };
 
 static const char *mgmt_ev[] = {
@@ -597,7 +597,7 @@ static const char *mgmt_ev[] = {
 	"Device Unblocked",
 	"Device Unpaired",
 	"Passkey Notify",
-	"New Identity Resolving Key",
+	"New Identity Resolving Key",	/* 0x0018 */
 	"New Signature Resolving Key",
 };
 
@@ -610,7 +610,7 @@ static const char *mgmt_status[] = {
 	"Authentication Failed",
 	"Not Paired",
 	"No Resources",
-	"Timeout",
+	"Timeout",			/* 0x08 */
 	"Already Connected",
 	"Busy",
 	"Rejected",
@@ -618,7 +618,7 @@ static const char *mgmt_status[] = {
 	"Invalid Parameters",
 	"Disconnected",
 	"Not Powered",
-	"Cancelled",
+	"Cancelled",			/* 0x10 */
 	"Invalid Index",
 	"Blocked through rfkill",
 };
-- 
1.9.3

