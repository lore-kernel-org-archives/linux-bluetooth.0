Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 4/4] doc/mgmt-api: Update error codes for Pair Device Command
Date: Wed, 11 Feb 2015 12:32:12 +0100
Message-Id: <1423654332-32424-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1423654332-32424-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1423654332-32424-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds two error codes for Pair device command.

Reject error code which is used when requested transport is not enabled.
E.g. User wants to do LE pair but LE support is not enabled. Similar
with BREDR

Not Supported error code which is used if controller is not capable with
requested transport
---
 doc/mgmt-api.txt | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index a51e913..bef9990 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1023,7 +1023,14 @@ Pair Device Command
 	This command generates a Command Complete event on success
 	or failure.
 
-	Possible errors:	Connect Failed
+	Reject status is used when requested transport is not enabled.
+
+	Not Supported status is used if controller is not capable with
+	requested transport.
+
+	Possible errors:	Rejected
+				Not Supported
+				Connect Failed
 				Busy
 				Invalid Parameters
 				Not Powered
-- 
1.8.4

