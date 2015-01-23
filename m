Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 3/3] doc/mgmt-api: Update error code for Pair Device
Date: Fri, 23 Jan 2015 12:54:35 +0100
Message-Id: <1422014075-6897-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1422014075-6897-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1422014075-6897-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Reject error code is used when given transport is not available.
E.g. User wants to do LE pair but LE support is not enabled. Similar
with BREDR
---
 doc/mgmt-api.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index e1a5e69..51a8d3e 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1023,7 +1023,8 @@ Pair Device Command
 	This command generates a Command Complete event on success
 	or failure.
 
-	Possible errors:	Connect Failed
+	Possible errors:	Rejected
+				Connect Failed
 				Busy
 				Invalid Parameters
 				Not Powered
-- 
1.8.4

