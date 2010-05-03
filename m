Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH] Health Device Profile API
Date: Mon,  3 May 2010 20:22:38 -0300
Message-Id: <1272928958-8073-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Elvis Pfutzenreuter <epx@signove.com>

Initial Health API proposal. Includes Adapter, Device and HealthAgent API
description. Proposed API can address Health source and sink roles.

Adapter methods exported on Health interface allow HealthAgent
registration. Device methods exported on Health interface allow
applications to actively created MCAP data channels and get informations
of the services exported by the endpoints.

HealthAgent allows applications to receive multiple data streams encoded
on IEEE 11073-20601 Personal Health Data Exchange Protocol.

v2 changes: added HealthData connection object interface
	    assumes at most one HDP set of roles per application
---
 doc/health-api.txt |  187 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 187 insertions(+), 0 deletions(-)
 create mode 100644 doc/health-api.txt

diff --git a/doc/health-api.txt b/doc/health-api.txt
new file mode 100644
index 0000000..49c043d
--- /dev/null
+++ b/doc/health-api.txt
@@ -0,0 +1,187 @@
+BlueZ D-Bus Health API description
+*********************************
+
+Copyright (C) 2010 Elvis Pfutzenreuter <epx@signove.com>
+
+Health Adapter hierarchy
+========================
+
+Service		org.bluez
+Interface	org.bluez.Health
+Object path	[variable prefix]/{hci0,hci1,...}
+
+This object hierarchy intend to be used by applications which want to enable
+a Health source or sink end point. The most common usage scenario is the sink
+role. Multi-channel protocol internals are hidden from the application interface.
+
+Methods:
+	void RegisterRole(dict options, object path)
+
+		Register an HDP role to the adapter and assign the health agent
+		that shall be responsible by address data channel connections.
+
+		Records and channels are automatically closed when the agent
+		leaves the bus. Mandatory and optional options are described
+		below:
+			Optional parameters (dinamically assigned when not
+			informed):
+			uint16 CPSM: control channel PSM
+			uint16 DPSM: data channel PSM
+
+			Mandatory parameters:
+			array{dict EndPoint} EndPoints: Array of end points.
+				Possible EndPoint properties:
+				uint8 MDEPId: Mandatory MCAP Data End Point
+					Identification
+				uint16 DataType: Mandatory Endpoint data type
+				string Role: "source" or "sink"
+				string Description: Optional description
+
+	UnregisterRole()
+
+		Removes an HDP role and kills all connections related to it.
+
+
+Health Agent hierarchy
+======================
+
+Service		unique name
+Interface	org.bluez.HealthAgent
+Object path	freely definable
+
+Agent responsible by address data channels connections. Either active or
+passive connections are notified. FD passing mechanism is used to allows
+the HealthAgent to access directly the data encoded on IEEE 11073-20601
+Personal Health Data Exchange Protocol.
+
+Methods:
+	void NewDataConnection(dict properties)
+
+		This method gets called when a new data channel connection
+		is established. It addresses host and remote initiated
+		connections.
+
+		Properties:
+			string device_path: the Health Device object path
+			string connection_path: the HealthData object path
+			boolean Passive: Device initiated connection
+			boolean Reconnection: Previous established data
+				channel reestablished
+
+	void Release()
+
+		This method gets called whenever the service daemon unregisters
+		the agent or whenever the Adapter where the HealthAgent
+		registers itself is removed.
+
+
+Health Device hierarchy
+=======================
+
+Service		org.bluez
+Interface	org.bluez.Health
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+The methods described below can be used by applications that need
+to manage data channel connections or get properties of service
+exported by the remote device.
+
+Methods:
+
+	string Connect(dict parameters)
+
+		Method used by applications that need to actively create
+		a data channel connection. When the remote connects back
+		in the data channel PSM, the connection is reported to
+		the registered HealthAgent.
+
+		Returns an HDP Connection object path. The same path
+		will be received again via Agent, when connection is
+		established.
+
+		If the reconnection is not possible, a new connection
+		will be created (automatic fallback). The MDL ID may
+		change; the application needs to check HealthData object
+		MDLId property when connection is notified via Agent.
+
+		Mandatory parameters:
+			uint8 local_mdepid: local MDEP ID (*)
+			uint8 remote_mdepid: remote MDEP ID
+		Optional parameters:
+			uint16 mdlid: MDL ID, if trying reconnection
+
+		(*) Was defined by application when it called RegisterRole().
+
+	dict GetProperties()
+
+		Returns the device properties.
+
+Signals:
+
+	PropertiesChanged()
+
+Properties:
+		array{MDEPs}: array of remote data end points. Attributes of
+			a MDEP entry are:
+				uint8 MDEPId
+				uint16 DataType
+				string Role: "source" or "sink"
+				string Description: optional description
+
+		array{MDLs}: array of open data channels. Mandatory
+			MDLs attributes are:
+			uint16 MDLId: Data channel identification
+			string path: HealthData object path
+
+		boolean Connected: true when the MCAP control channel is
+					established
+
+
+Health Device Data Connection hierarchy
+=======================================
+
+Service		org.bluez
+Interface	org.bluez.HealthData
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/YYYYYYYYYYY
+
+A HealthData object can be created either by active connection of by
+receiving a connection via HealthAgent.
+
+FD passing concept is used to allow applications to handle data channels.
+
+A HealthData object exists only while the data connection is up. If the
+connection is broken, the object is removed. The application may
+(and should) handle this situation, by trying a reconnection.
+If the connection was not deleted, the MDL ID outlives the respective
+HealthData object. (Another sign of connection breakage is file
+descriptor closure.)
+
+The methods described below can be used by applications to manage
+a single data channel or get its properties.
+
+Methods:
+
+	filedescriptor GetFD()
+
+		Obtains the raw filedescriptor for this data channel
+		(most likely a L2CAP socket.)
+
+	void Disconnect()
+
+		Closes this data channel and destroys the object,
+		but keeps the MDL ID valid for future reconnections.
+
+	void DeleteConnection()
+
+		Closes this data channel, destroys the object
+		 and invalidates the MDL ID.
+
+	dict GetProperties()
+
+		Returns the device properties.
+
+Properties:
+		uint8 LocalMDEPId: Local data channel identification
+		uint8 RemoteMDEPId: Remote data channel identification
+		uint16 MDLId: data channel ID
+		uint16 MTU: L2CAP channel message MTU
-- 
1.7.0.4

