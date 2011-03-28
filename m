Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 1/2] Update Adapter API documentation
Date: Mon, 28 Mar 2011 17:21:56 +0300
Message-Id: <1301322117-22724-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1301322117-22724-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1301322117-22724-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

RequestSession and ReleaseSession description is updated in adapter
API.
---
 doc/adapter-api.txt |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 5272d74..f34d58f 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -31,15 +31,25 @@ Methods		dict GetProperties()
 
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
+			Release a previously requested session. It sets
+			adapter to the mode in use on the moment of session
+			request.
+
+			SetProperty method call changes adapter's mode
+			persistently, such that session release will not
+			modify it.
 
 			Possible Errors: org.bluez.Error.DoesNotExist
 
-- 
1.7.1

