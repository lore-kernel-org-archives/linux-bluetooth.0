Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH] Changes in HDP API.
Date: Wed,  4 Aug 2010 09:49:12 +0200
Message-Id: <1280908152-3743-2-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1280908152-3743-1-git-send-email-santoscadenas@gmail.com>
References: <1280908152-3743-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now the connection is made directly to a device and bluetoothd daemon
guess the PSM connection and the MDEPID based on the data get from the
SDP record.
---
 doc/health-api.txt |   33 +++++++++++++--------------------
 1 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/doc/health-api.txt b/doc/health-api.txt
index f469df3..aa462bd 100644
--- a/doc/health-api.txt
+++ b/doc/health-api.txt
@@ -47,12 +47,12 @@ Methods:
 --------------------------------------------------------------------------------
 
 Service		org.bluez
-Interface	org.bluez.HealthApplication
-Object path	[variable prefix]/health_app_ZZZZ
+Interface	org.bluez.HealthDevice
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
 
 Methods:
 
-	void Echo(object service)
+	void Echo(object application)
 
 		Sends an echo petition to the remote service. Returns True if
 		response matches with the buffer sent. If some error is detected
@@ -61,7 +61,7 @@ Methods:
 		Possible errors: org.bluez.Error.InvalidArguments
 				org.bluez.Error.OutOfRange
 
-	object CreateChannel(object service, string type)
+	object CreateChannel(object application, string type)
 
 		Creates a new data channel with the indicated config to the
 		remote Service.
@@ -74,18 +74,12 @@ Methods:
 		Possible errors: org.bluez.Error.InvalidArguments
 				org.bluez.Error.HealthError
 
-	void DestroyChannel(object channel)
+	void DestroyChannel(object application)
 
 		Destroys the data channel object.
 
 		Possible errors: org.bluez.Error.InvalidArguments
-				orb.bluez.Error.NotFound
-
---------------------------------------------------------------------------------
-
-Service		org.bluez
-Interface	org.bluez.HealthService
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/hdp_YYYY
+				org.bluez.Error.NotFound
 
 --------------------------------------------------------------------------------
 
@@ -142,18 +136,17 @@ Methods:
 		to unregister the agent, because when this method gets called it
 		has already been unregistered.
 
-	void ServiceDiscovered(object service)
+	void DeviceDiscovered(object device)
 
 		This method is called when a device containing an HDP
-		application is paired or when the method Update of the
-		HealthManager is called and new HealthServices are discovered.
-		The method will be called once for each HealthService.
+		application is paired and is suitable for connect with the
+		application that registered this agent.
 
-	void ServiceRemoved(object service)
+	void DeviceRemoved(object device)
 
-		This is called if during an Update some HealthServices
-		have disappeared. The method is called once for each removed
-		HealthService.
+		This method is called if a device that was suitable for
+		connecting with the application becomes not suitable for
+		connecting with the application.
 
 	void ChannelConnected(object channel)
 
-- 
1.7.0.4

