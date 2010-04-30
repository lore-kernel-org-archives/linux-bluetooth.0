Return-Path: <cyrus@holtmann.org>
From: Elvis Pfutzenreuter <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH] Health Device Profile API
Date: Thu, 29 Apr 2010 22:44:12 -0300
Message-Id: <1272591852-4961-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Initial Health API proposal. Includes Adapter, Device and HealthAgent API
description. Proposed API can address Health source and sink roles.

Adapter methods exported on Health interface allow HealthAgent
registration. Device methods exported on Health interface allow
applications to actively created MCAP data channels and get informations
of the services exported by the endpoints.

HealthAgent allows applications to receive multiple data streams encoded
on IEEE 11073-20601 Personal Health Data Exchange Protocol.
---
 doc/health-api.txt |  141 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 141 insertions(+), 0 deletions(-)
 create mode 100644 doc/health-api.txt

diff --git a/doc/health-api.txt b/doc/health-api.txt
new file mode 100644
index 0000000..9be3d6c
--- /dev/null
+++ b/doc/health-api.txt
@@ -0,0 +1,141 @@
+BlueZ D-Bus Health API description
+*********************************
+
+Copyright (C) 2010 Elvis Pfützenreuter <epx@signove.com>
+
+Health Adapter hierarchy
+===============
+
+Service		org.bluez
+Interface	org.bluez.Health
+Object path	[variable prefix]/{hci0,hci1,...}
+
+This object hierarchy intend to be used by applications which want to enable
+a Health source or sink end point. The most common usage scenario is the sink
+role. Multi-channel protocol internals are hidden from the application interface.
+
+FD passing concept is used to allow applications to handle data channels.
+
+Methods:
+	uint32 RegisterRole(dict options, object path)
+
+		Register an HDP role to the adapter and assign the health agent
+		that shall be responsible by address data channel connections.
+		Returns an identification for the HDP context.
+
+		Records and channels are automatically closed when the agent
+		leaves the bus. Mandatory and optional options are described
+		below:
+			Optional parameters(dinamically assigned when not
+			informed):
+			uint16 CPSM: control channel
+			uint16 DPSM: data channel
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
+	UnregisterRole(uint32 id)
+
+		Removes an HDP role and kills all connections related to it.
+
+Health Agent hierarchy
+===============
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
+	void NewMDLConnection(filedescriptor fd, dict properties)
+
+		This method gets called when a new data channel connection
+		is established. It addresses host and remote initiated
+		connections.
+
+		Properties:
+			uint8 LocalMDEPId:
+			uint8 RemoteMDEPId:
+			uint16 MDLId:
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
+Health Device hierarchy
+===============
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
+	void Connect(uint8 local_mdepid, uint8 remote_mdepid, uint16 mdlid)
+
+		Method used by applications that need to actively create
+		a data channel connection. When the remote connects back
+		in the data channel PSM, the connection is reported to
+		the registered HealthAgent.
+
+		mdlid greater than zero, means that the host is attempt
+		to reestablish a previous session. Zero means that new
+		session shall be established.
+
+		If the reconnection is not possible, a new connection
+		will be created (automatic fallback). The MDL ID may
+		change; the application needs to check it when receiving
+		Agent connection data.
+
+	void Disconnect(uint16  mdlid)
+
+		Closes the give data channel but keeps the MDL ID valid for
+		future reconnections.
+
+	void DeleteConnection(uint16 mdlid)
+
+		Closes the MDL connection and invalidates the MDL ID
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
+				string Description: optional  description
+
+		array{MDLs}: array of valid data channels. Mandatory
+			MDLs attributes are:
+			uint16 MDLId: Data channel identification
+			uint8 LocalMDEPId: Local data channel identification
+			uint8 RemoteMDEPId: Remote data channel identification
+
+		boolean Connected: true when the MCAP control channel is
+					established
-- 
1.7.0.4

