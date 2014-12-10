Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  2/3] parser/hci: Fix ERROR CODES as per core_v4.2
Date: Wed, 10 Dec 2014 17:16:47 +0530
Message-id: <1418212008-8594-3-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1418212008-8594-1-git-send-email-gowtham.ab@samsung.com>
References: <1418212008-8594-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Modified the error codes as per core V4.2, Vol 2, Part D.
---
 tools/parser/hci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/parser/hci.c b/tools/parser/hci.c
index cd52cb5..33df542 100644
--- a/tools/parser/hci.c
+++ b/tools/parser/hci.c
@@ -446,9 +446,9 @@ static char *error_code_str[ERROR_CODE_NUM + 1] = {
 	"SCO Offset Rejected",
 	"SCO Interval Rejected",
 	"SCO Air Mode Rejected",
-	"Invalid LMP Parameters",
+	"Invalid LMP Parameters / Invalid LL Parameters",
 	"Unspecified Error",
-	"Unsupported LMP Parameter Value",
+	"Unsupported LMP Parameter Value / Unsupported LL Parameter Value",
 	"Role Change Not Allowed",
 	"LMP Response Timeout",
 	"LMP Error Transaction Collision",
@@ -475,7 +475,7 @@ static char *error_code_str[ERROR_CODE_NUM + 1] = {
 	"Host Busy - Pairing",
 	"Connection Rejected due to No Suitable Channel Found",
 	"Controller Busy",
-	"Unacceptable Connection Interval",
+	"Unacceptable Connection Parameters",
 	"Directed Advertising Timeout",
 	"Connection Terminated Due to MIC Failure",
 	"Connection Failed to be Established",
-- 
1.9.1

