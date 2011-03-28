Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 1/2] Update Adapter API documentation
Date: Mon, 28 Mar 2011 16:01:38 +0300
Message-Id: <1301317299-18915-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

RequestSession and ReleaseSession description is updated in adapter
API.
---
 doc/adapter-api.txt |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 5272d74..ad63dea 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -31,15 +31,23 @@ Methods		dict GetProperties()
 
 		void RequestSession()
 
-			This method will request a client session that
-			provides operational Bluetooth. A possible mode
-			change must be confirmed by the user via the agent.
+			This method requests a client session that provides
+			operational Bluetooth. A possible mode change must be
+			confirmed by the user via the agent.
+
+			Clients may request multiple sessions. All sessions
+			are released when adapter's mode is changed to off
+			state.
 
 			Possible Errors: org.bluez.Error.Rejected
 
 		void ReleaseSession()
 
-			Release a previous requested session.
+			Release a previously requested session and set adapter
+			to the mode on the moment of session request.
+
+			SetProperty can be used to set adapter's mode after
+			session release.
 
 			Possible Errors: org.bluez.Error.DoesNotExist
 
-- 
1.7.1

