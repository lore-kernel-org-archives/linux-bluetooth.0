Return-Path: <cyrus@holtmann.org>
From: Suraj Sumangala <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <Jothikumar.Mothilal@Atheros.com>,
	Suraj Sumangala <suraj@atheros.com>
Subject: [RFC] BlueZ D-Bus Sim Access Profile Server API description
Date: Mon, 13 Sep 2010 16:13:04 +0530
Message-ID: <1284374584-12282-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Below is the Sim Access Profile server role API discription.
Please let me know your comments.

Regards
Suraj
---
 Makefile.am     |    2 +-
 doc/sap-api.txt |  216 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 217 insertions(+), 1 deletions(-)
 create mode 100644 doc/sap-api.txt

diff --git a/Makefile.am b/Makefile.am
index a8829d9..52537bc 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -350,7 +350,7 @@ EXTRA_DIST += doc/manager-api.txt \
 		doc/service-api.txt doc/agent-api.txt doc/attribute-api.txt \
 		doc/serial-api.txt doc/network-api.txt \
 		doc/input-api.txt doc/audio-api.txt doc/control-api.txt \
-		doc/hfp-api.txt doc/assigned-numbers.txt
+		doc/hfp-api.txt doc/assigned-numbers.txt doc/sap-api.txt
 
 AM_YFLAGS = -d
 
diff --git a/doc/sap-api.txt b/doc/sap-api.txt
new file mode 100644
index 0000000..9a684fa
--- /dev/null
+++ b/doc/sap-api.txt
@@ -0,0 +1,216 @@
+BlueZ D-Bus Sim Access Profile API description
+**********************************************
+
+Copyright (C) 2009-2010  Atheros Communication Ltd
+
+
+Sim Access Server hierarchy
+===========================
+
+Service	org.bluez
+Interface	org.bluez.SAPServer
+Object path	[variable prefix]/{hci0,hci1,...}
+
+This interface is available for devices which can function as the
+Server role of the Sim Access profiles.
+It is intended to be used with external stacks / handlers of the Sim Access
+protocol.
+
+
+Methods	void RegisterAgent(object agent)
+
+			This registers the Sim Access server agent.
+			This also registers the profile with the service
+			databse and start waiting for an RFCOMM connection
+			on the SAP server channel.
+
+			The object path defines the path the of the agent.
+
+			If an application disconnects from the bus all
+			of its registered agents will be removed.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.AlreadyExists
+					 org.bluez.Error.Failed
+
+		void UnregisterAgent(object agent)
+
+			This unregisters the agent that has been previously
+			registered. The object path parameter must match the
+			same value that has been used on registration.
+
+			Possible errors: org.bluez.Error.DoesNotExist
+					 org.bluez.Error.InvalidArguments
+					 org.bluez.Error.Failed
+
+		void Response(string command, string result, object response)
+
+			This sends a SAP response packet to a SAP sequest.
+
+			The command parameter specifies the SAP command for
+			which response is being sent.
+
+			The result parameter specifies the ResultCode for the
+			operation.
+
+			The object response specifies the response packet to
+			be sent if any.
+
+			Below mentioned are the parameters and possible value.
+
+			command     	  result	    	response
+			----------------------------------------------------
+
+			Connect		  OkSuccess		NA
+					  ConnectFailed
+				  	  OkOngoingCall
+
+			APDU		  OkSuccess		array{uint8}
+					  NoReason
+					  CardNotAccessible
+					  CardPoweredOff
+					  CardRemoved
+
+			APDU7816	  OkSuccess		array{uint8}
+					  NoReason
+					  CardNotAccessible
+					  CardPoweredOff
+					  CardRemoved
+
+			ATR		  OkSuccess		array{uint8}
+					  NoReason
+					  CardPoweredOff
+					  CardRemoved
+					  DataNotAvailable
+
+			SimPowerOn	  OkSuccess		NA
+					  NoReason
+					  CardNotAccessible
+					  CardRemoved
+					  CardPoweredOn
+
+			SimPowerOff	  OkSuccess		NA
+					  NoReason
+					  CardPoweredOff
+					  CardRemoved
+
+			Reset		  OkSuccess		NA
+					  NoReason
+					  CardNotAccessible
+					  CardPoweredOff
+					  CardRemoved
+
+			CardReaderStatus  OkSuccess		uint8
+					  NoReason
+					  DataNotAvailable
+
+			TransportProtocol OkSuccess		NA
+					  NotSupported
+
+			Disconnect	  NA	 		NA
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.Failed
+
+		void Disconnect(string type)
+
+			This initiates a SAP disconnection from SAP server.
+
+			The type parameter specifies the type of disconnection.
+
+			"Graceful"  -> lets the SAP client initiate a
+			garceful disconnection.
+
+			"Immediate" -> disconnects the connection
+			immediately from the server.
+
+		void SetProperty(string name, variant value)
+
+			Changes the value of the specified property. Only
+			properties that are listed a read-write are changeable.
+			On success this will emit a PropertyChanged signal.
+
+			Possible Errors: org.bluez.Error.DoesNotExist
+					 org.bluez.Error.InvalidArguments
+
+		dict GetProperties()
+
+			Returns all properties for the interface. See the
+			properties section for available properties.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+
+Signals		PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+Properties	string SimStatus [readwrite]
+
+			Specifies the availability of the SIM.
+
+			The possible value are
+
+			"UnknownError"
+			"CardReset"
+			"CardNotAccesible"
+			"CardRemoved"
+			"CardInsterted"
+			"CardRecovered"
+
+		uint16 MaxMessageSize [readwrite]
+
+			The maximum possible message size supported by
+			SAP server.
+
+		uint16 MinMessageSize [readwrite]
+
+			The minimum possible message size supported by
+			SAP server.
+
+		uint16 MessageSize [readonly]
+
+			The negotiated message size for the current connection.
+			This is valid only when there is an active
+			SAP connection.
+
+Sim Access Server Agent hierarchy
+=================================
+
+Service         unique name
+Interface       org.bluez.SAPServerAgent
+Object path     freely definable
+
+Methods		Request(string command, object param)
+
+			This method gets called whenever a SAP request is received
+			from SAP client. This will help deliver the
+			SAP request to the Agent.
+
+			The command parameter specifies the SAP request type
+			received.
+
+			The param parameter specifies the command parameter
+			packet received from SAP client.
+
+			Below mentioned is the parameters and possible value.
+
+			command     	  	parameter
+			----------------------------------------------------
+
+			Connect		  	NA
+			APDU		  	array{uint8}
+			APDU7816	  	array{uint8}
+			ATR		  	NA
+			SimPowerOn	  	NA
+			SimPowerOff	  	NA
+			Reset		  	NA
+			CardReaderStatus  	NA
+			TransportProtocol 	uint8
+			Disconnect		NA
+
+		void Release()
+
+			This method gets called whenever the service daemon
+			unregisters the agent or whenever the Adapter where
+			the SimAccessServerAgent registers itself is removed.
-- 
1.7.0.4

