Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: =?UTF-8?q?=5BRFC=206/6=5D=20doc=3A=20Update=20Health=20to=20BlueZ=205?=
Date: Thu, 18 Oct 2012 19:03:51 -0300
Message-Id: <1350597831-28380-7-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1350597831-28380-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1350597831-28380-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Adapt to the new DBus.Properties and cleanup the format used in this
documentation to be similar to the other profiles.
---
 doc/health-api.txt | 198 ++++++++++++++++++++++++++---------------------------
 1 file changed, 98 insertions(+), 100 deletions(-)

diff --git a/doc/health-api.txt b/doc/health-api.txt
index 7a000cb..728280a 100644
--- a/doc/health-api.txt
+++ b/doc/health-api.txt
@@ -5,162 +5,160 @@ BlueZ D-Bus Health API description
 	José Antonio Santos-Cadenas <santoscadenas@gmail.com>
 	Elvis Pfützenreuter <epx@signove.com>
 
-Health Device Profile hierarchy
-===============================
+HealthManager hierarchy
+=======================
 
 Service		org.bluez
 Interface	org.bluez.HealthManager
 Object path	/org/bluez/
 
-Methods:
+Methods		object CreateApplication(dict config)
 
-	object	CreateApplication(dict config)
+			Returns the path of the new registered application.
+			Application will be closed by the call or implicitly
+			when the programs leaves the bus.
 
-		Returns the path of the new registered application.
+			config:
+				uint16 DataType:
 
-		Dict is defined as below:
-		{
-			"DataType": uint16, (mandatory)
-			"Role" : ("Source" or "Sink"), (mandatory)
-			"Description" : string, (optional)
-			"ChannelType" : ("Reliable" or "Streaming")
-						(just for Sources, optional)
-		}
+					Mandatory
 
-		Application will be closed by the call or implicitly when the
-		programs leaves the bus.
+				string Role:
 
-		Possible errors: org.bluez.Error.InvalidArguments
+					Mandatory. Possible values: "Source",
+									"Sink"
 
-	void	DestroyApplication(object application)
+				string Description:
 
-		Closes the HDP application identified by the object path. Also
-		application will be closed if the process that started it leaves
-		the bus. Only the creator of the application will be able to
-		destroy it.
+					Optional
 
-		Possible errors: org.bluez.Error.InvalidArguments
-				org.bluez.Error.NotFound
-				org.bluez.Error.NotAllowed
+				ChannelType:
 
---------------------------------------------------------------------------------
+					Optional, just for sources. Possible
+					values: "Reliable", "Streaming"
 
-Service		org.bluez
-Interface	org.bluez.HealthDevice
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+			Possible Errors: org.bluez.Error.InvalidArguments
+
+		void DestroyApplication(object application)
 
-Methods:
+			Closes the HDP application identified by the object
+			path. Also application will be closed if the process
+			that started it leaves the bus. Only the creator of the
+			application will be able to destroy it.
 
-	dict GetProperties()
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.NotFound
+					 org.bluez.Error.NotAllowed
 
-		Returns all properties for the interface. See the properties
-		section for available properties.
+HealthDevice hierarchy
+======================
 
-		Posible errors: org.bluez.Error.NotAllowed
+Service		org.bluez
+Interface	org.bluez.HealthDevice
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
 
-	Boolean Echo()
+Methods		dict GetProperties()
 
-		Sends an echo petition to the remote service. Returns True if
-		response matches with the buffer sent. If some error is detected
-		False value is returned.
+			Returns all properties for the interface. See the
+			properties section for available properties.
 
-		Possible errors: org.bluez.Error.InvalidArguments
-				org.bluez.Error.OutOfRange
+			Posible errors: org.bluez.Error.NotAllowed
 
-	object CreateChannel(object application, string configuration)
+		boolean Echo()
 
-		Creates a new data channel.
-		The configuration should indicate the channel quality of
-		service using one of this values "Reliable", "Streaming", "Any".
+			Sends an echo petition to the remote service. Returns
+			True if response matches with the buffer sent. If some
+			error is detected False value is returned.
 
-		Returns the object path that identifies the data channel that
-		is already connected.
+			Possible errors: org.bluez.Error.InvalidArguments
+			org.bluez.Error.OutOfRange
 
-		Possible errors: org.bluez.Error.InvalidArguments
-				org.bluez.Error.HealthError
+		object CreateChannel(object application, string configuration)
 
-	void DestroyChannel(object channel)
+			Creates a new data channel.  The configuration should
+			indicate the channel quality of service using one of
+			this values "Reliable", "Streaming", "Any".
 
-		Destroys the data channel object. Only the creator of the
-		channel or the creator of the HealthApplication that received
-		the data channel will be able to destroy it.
+			Returns the object path that identifies the data
+			channel that is already connected.
 
-		Possible errors: org.bluez.Error.InvalidArguments
-				org.bluez.Error.NotFound
-				org.bluez.Error.NotAllowed
+			Possible errors: org.bluez.Error.InvalidArguments
+			org.bluez.Error.HealthError
 
-Signals:
+		void DestroyChannel(object channel)
 
-	void ChannelConnected(object channel)
+			Destroys the data channel object. Only the creator of
+			the channel or the creator of the HealthApplication
+			that received the data channel will be able to destroy
+			it.
 
-		This signal is launched when a new data channel is created or
-		when a known data channel is reconnected.
+			Possible errors: org.bluez.Error.InvalidArguments
+			org.bluez.Error.NotFound org.bluez.Error.NotAllowed
 
-	void ChannelDeleted(object channel)
+Signals		void ChannelConnected(object channel)
 
-		This signal is launched when a data channel is deleted.
+			This signal is launched when a new data channel is
+			created or when a known data channel is reconnected.
 
-		After this signal the data channel path will not be valid and
-		its path can be reused for future data channels.
+		void ChannelDeleted(object channel)
 
-	void PropertyChanged(string name, variant value)
+			This signal is launched when a data channel is deleted.
 
-		This signal indicates a changed value of the given property.
+			After this signal the data channel path will not be
+			valid and its path can be reused for future data
+			channels.
 
-Properties:
+		void PropertyChanged(string name, variant value)
 
-	object MainChannel [readonly]
+			This signal indicates a changed value of the given
+			property.
 
-		The first reliable channel opened. It is needed by upper
-		applications in order to send specific protocol data units. The
-		first reliable can change after a reconnection.
+Properties	object MainChannel [readonly]
 
---------------------------------------------------------------------------------
+			The first reliable channel opened. It is needed by
+			upper applications in order to send specific protocol
+			data units. The first reliable can change after a
+			reconnection.
+
+HealthChannel hierarchy
+=======================
 
 Service		org.bluez
 Interface	org.bluez.HealthChannel
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/chanZZZ
 
 Only the process that created the data channel or the creator of the
-HealthApplication that received it will be able to call this methods.
-
-Methods:
-
-	dict GetProperties()
-
-		Returns all properties for the interface. See the properties
-		section for available properties.
-
-		Possible errors: org.bluez.Error.NotAllowed
-
-	fd Acquire()
+HealthApplication that received it will be able to call these methods.
 
-		Returns the file descriptor for this data channel. If the data
-		channel is not connected it will also reconnect.
+Methods		fd Acquire()
 
-		Possible errors: org.bluez.Error.NotConnected
-				org.bluez.Error.NotAllowed
+			Returns the file descriptor for this data channel. If
+			the data channel is not connected it will also
+			reconnect.
 
-	void Release()
+			Possible Errors: org.bluez.Error.NotConnected
+					 org.bluez.Error.NotAllowed
 
-		Releases the fd. Application should also need to close() it.
+		void Release()
 
-		Possible errors: org.bluez.Error.NotAcquired
-				org.bluez.Error.NotAllowed
+			Releases the fd. Application should also need to
+			close() it.
 
-Properties:
+			Possible Errors: org.bluez.Error.NotAcquired
+					 org.bluez.Error.NotAllowed
 
-	string Type [readonly]
+Properties	string Type [readonly]
 
-		The quality of service of the data channel. ("Reliable" or
-		"Streaming")
+			The quality of service of the data channel. ("Reliable"
+			or "Streaming")
 
-	object Device [readonly]
+		object Device [readonly]
 
-		Identifies the Remote Device that is connected with. Maps with
-		a HealthDevice object.
+			Identifies the Remote Device that is connected with.
+			Maps with a HealthDevice object.
 
-	object Application [readonly]
+		object Application [readonly]
 
-		Identifies the HealthApplication to which this channel is
-		related to (which indirectly defines its role and data type).
+			Identifies the HealthApplication to which this channel
+			is related to (which indirectly defines its role and
+			data type).
-- 
1.7.12.3

