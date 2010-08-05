Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH] Changes in HDP API.
Date: Thu,  5 Aug 2010 15:49:43 +0200
Message-Id: <1281016183-4547-1-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <201008051129.38119.santoscadenas@gmail.com>
References: <201008051129.38119.santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now the connection is made directly to a device and bluetoothd daemon
guess the PSM connection and the MDEPID based on the data get from the
SDP record.
---
 doc/health-api.txt |  105 ++++++++++++++++++++--------------------------------
 1 files changed, 40 insertions(+), 65 deletions(-)

diff --git a/doc/health-api.txt b/doc/health-api.txt
index f469df3..89df8bd 100644
--- a/doc/health-api.txt
+++ b/doc/health-api.txt
@@ -14,12 +14,9 @@ Object path	/org/bluez/
 
 Methods:
 
-	object	CreateApplication(dict config, object agent)
+	object	CreateApplication(dict config)
 
-		Returns the path of the new registered application. The agent
-		parameter is the path of the object with the callbacks to
-		notify events (see org.bluez.HealthAgent at the end
-		of this document).
+		Returns the path of the new registered application.
 
 		Dict is defined as bellow:
 		{
@@ -39,32 +36,33 @@ Methods:
 
 		Closes the HDP application identified by the object path. Also
 		application will be closed if the process that started it leaves
-		the bus.
+		the bus. Only the creator of the application will be able to
+		destroy it.
 
 		Possible errors: org.bluez.Error.InvalidArguments
 				org.bluez.Error.NotFound
+				org.bluez.Error.NotAllowed
 
 --------------------------------------------------------------------------------
 
 Service		org.bluez
-Interface	org.bluez.HealthApplication
-Object path	[variable prefix]/health_app_ZZZZ
+Interface	org.bluez.HealthDevice
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
 
 Methods:
 
-	void Echo(object service)
+	Boolean Echo()
 
 		Sends an echo petition to the remote service. Returns True if
 		response matches with the buffer sent. If some error is detected
-		False value is returned and the associated MCL is closed.
+		False value is returned.
 
 		Possible errors: org.bluez.Error.InvalidArguments
 				org.bluez.Error.OutOfRange
 
-	object CreateChannel(object service, string type)
+	object CreateChannel(object application, string configuration)
 
-		Creates a new data channel with the indicated config to the
-		remote Service.
+		Creates a new data channel.
 		The configuration should indicate the channel quality of
 		service using one of this values "Reliable", "Streaming", "Any".
 
@@ -76,16 +74,27 @@ Methods:
 
 	void DestroyChannel(object channel)
 
-		Destroys the data channel object.
+		Destroys the data channel object. Only the creator of the
+		channel or the creator of the HealtApplication that received the
+		data channel will be able to destroy it
 
 		Possible errors: org.bluez.Error.InvalidArguments
-				orb.bluez.Error.NotFound
+				org.bluez.Error.NotFound
+				org.bluez.Error.NotAllowed
 
---------------------------------------------------------------------------------
+Signals:
 
-Service		org.bluez
-Interface	org.bluez.HealthService
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/hdp_YYYY
+	void ChannelConnected(object channel)
+
+		This signal is launched when a new data channel is created or
+		when a known data channel is reconnected.
+
+	void ChannelDeleted(object channel)
+
+		This signal is launched when a data channel is deleted.
+
+		After this signal the data channel path will not be valid and
+		its path can be reused for future data channels.
 
 --------------------------------------------------------------------------------
 
@@ -94,6 +103,9 @@ Interface	org.bluez.HealthChannel
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/
 							hdp_YYYY/channel_ZZ
 
+Only the process that created the data channel or the creator of the
+HealthApplication that received it will be able to call this methods.
+
 Methods:
 
 	dict GetProperties()
@@ -101,17 +113,23 @@ Methods:
 		Returns all properties for the interface. See the properties
 		section for available properties.
 
+		Posible errors: org.bluez.Error.NotAllowed
+
 	fd Acquire()
 
 		Returns the file descriptor for this data channel. If the data
 		channel is not connected it will also reconnect.
 
 		Possible errors: org.bluez.Error.NotConnected
+				org.bluez.Error.NotAllowed
 
 	void Release()
 
 		Releases the fd. Application should also need to close() it.
 
+		Possible errors: org.bluez.Error.NotAcquired
+				org.bluez.Error.NotAllowed
+
 Properties:
 
 	string Type (read only)
@@ -119,50 +137,7 @@ Properties:
 		The quality of service of the data channel. ("Reliable" or
 		"Streaming")
 
-	object Service (read only)
-
-		Identifies the Remote Service that is connected with. Maps with
-		a HealthService object.
-
-HealthAgent hierarchy
-=====================
-
-(this object is implemented by the HDP user in order to receive notifications)
-
-Service		unique name
-Interface	org.bluez.HealthAgent
-Object path	freely definable
-
-Methods:
-
-	void Release()
-
-		This method gets called when the service daemon unregisters the
-		agent. An agent can use it to do cleanup tasks. There is no need
-		to unregister the agent, because when this method gets called it
-		has already been unregistered.
-
-	void ServiceDiscovered(object service)
-
-		This method is called when a device containing an HDP
-		application is paired or when the method Update of the
-		HealthManager is called and new HealthServices are discovered.
-		The method will be called once for each HealthService.
-
-	void ServiceRemoved(object service)
-
-		This is called if during an Update some HealthServices
-		have disappeared. The method is called once for each removed
-		HealthService.
-
-	void ChannelConnected(object channel)
-
-		This method is called when a new data channel is created or when
-		a known data channel is reconnected.
-
-	void ChannelDeleted(object channel)
-
-		This method is called when a data channel is deleted.
+	object Device (read only)
 
-		After this call the data channel path will not be valid and can
-		be reused for future creation of data channels.
+		Identifies the Remote Device that is connected with. Maps with
+		a HealthDevice object.
-- 
1.7.0.4

