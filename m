Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Inga Stotland <inga.stotland@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/1] Add initial doc describing Bluetooth Mesh API
Date: Tue,  6 Feb 2018 00:24:55 -0800
Message-Id: <20180206082455.3424-2-inga.stotland@intel.com>
In-Reply-To: <20180206082455.3424-1-inga.stotland@intel.com>
References: <20180206082455.3424-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mesh-api.txt | 273 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 273 insertions(+)
 create mode 100644 doc/mesh-api.txt

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
new file mode 100644
index 000000000..249dba869
--- /dev/null
+++ b/doc/mesh-api.txt
@@ -0,0 +1,273 @@
+Bluetooth Mesh Socket API
+*************************
+
+Copyright (C) 2018 Intel Corporation. All rights reserved.
+
+This document decribes the data format that is used for communication with the
+kernel via Bluetooth Mesh socket. The data that are passed over this type of
+a socket is specific to Bluetooth Mesh Profile.
+
+The Bluetooth Mesh socket is implemented as part PF_BLUETOOTH family and can be
+created by opening a raw HCI socket with hci_channel set to HCI_CHANNEL_BTMESH.
+The mesh socket requires the creating process to have CAP_NET_ADMIN capability.
+
+===========================================
+Packet Structure: user space to kernel (Tx)
+===========================================
+
+Each Tx packet sent from the user space to the kernel starts with fixed length
+header (2 octets), followed by variable length payload.
+
+	0            8            16
+	+------------+------------+------------------------
+	|  Control   |   Type     | Payload
+	+------------+------------+------------------------
+
+
+Control (1 octet)
+=================
+Normal:			0x00
+Poll:			0x01
+Poll Response:		0x02
+Relay:			0x03
+Extended Control:	0xFF
+
+Values 0x04-0xFE are reserved.
+
+The Control values 0x00 - 0x03 determine which set of configured mesh settings
+to use when the payload contains Mesh Network PDUs.
+
+When the Control field of Mesh packet header is set to Extended Control (0xFF),
+the payload contains a 1-octet value with an action code.
+Currently, the following action codes are defined:
+	None  (0x00) -	Specifies no action. Reserved.
+	Flush (0x01) -	Flush all the pending mesh packets whose type is matching
+			the value in Type field of the Mesh packet header.
+	Values 0x02 -0xFF are reserved.
+
+
+Type (1 octet)
+==============
+Network:	0x00 -	The payload contains a Mesh Data Packet
+Beacon:		0x01 -	The payload contains a Mesh Beacon
+Configuration:	0x02 -	Reserved -- (Proxy Configuration)
+Provisioning:	0x03 -	The payload contains a Mesh Provisioning message
+Setup:		0x40 -	The payload contains clear text mesh setup command
+All:		0x80 -	An indicator that a requested action (see Extended
+			Control Operation) applies to all Mesh packets that
+			are pending processing
+
+Values 0x03-0x3F, 0x41-0x7F, 0x81-0xFF  are reserved.
+
+Packets with types 0x00 - 0x03 contain encrypted mesh data to be sent.
+
+A payload of a packet type Network contains a Mesh Network PDU. The information
+about which timing settings to use when sending this payload is indicated by
+Control field in the first octet of the packet header.
+The table below describes how to interpret Control values 0x00 - 0x003
+for a packet of Network type.
+
+---------------------------------------------------------------------------
+|                          Packet Type: Network (0x00)                    |
+---------------------------------------------------------------------------
+| Control Field                                                           |
+--------------------------------------------------------------------------|
+| Normal        - Expected to be used for the majority of outgoing mesh   |
+| (0x00)          messages. The retransmission parameters for the outgoing|
+|                 message are either default or configured using          |
+|                 configuration command Set Network Retransmit (defined   |
+|                 further below).                                         |
+|-------------------------------------------------------------------------|
+| Poll         -  Specifies that the outgoing mesh message is a friend    |
+| (0x01)          poll. The timing parameters for sending a friend poll   |
+|                 are configured by command Set Poll (defined further     |
+|                 below). No retransmissions.                             |
+|-------------------------------------------------------------------------|
+| Poll Response - Specifies that the outgoing mesh message is a response  |
+| (0x02)          to a friend poll. The timing parameters for sending     |
+|                 friend poll response are enclosed in the ancillary data |
+|                 accompanying this payload. The parameters are in        |
+|                 Mesh Poll Response Info format (defined further below). |
+|                 No retransmissions.                                     |
+|-------------------------------------------------------------------------|
+| Relay         - Specifies that the payload is a relayed mesh message.   |
+| (0x03)          messages. The retransmission parameters for the outgoing|
+|                 message are either default or configured using          |
+|                 configuration command Set Relay Retransmit (defined     |
+|                 further below).                                         |
+|-------------------------------------------------------------------------|
+
+A packet with Beacon type contains a Mesh Beacon message which is sent out
+once and requires no additional timing information.
+
+Packet type Configuration is currently a placeholder.
+
+The payload of packet with type Provisioning contains Mesh Provisioning
+message. The message will be retransmitted until the next packet with
+Provisioning Type is received from the user space or the transmission is
+canceled explicitly by receiving a packet from the user space with Control field
+set to Extended Control with action Flush and the packet Type set either to
+Provisioning:
+	0xFF 0x03 0x01
+or All:
+	0xFF 0x80 0x01
+
+The Provisioning messages are retransmitted with the same period as regular
+Mesh Network messages.
+
+A Setup type packet contains a Mesh Setup command with unencrypted payload:
+	Configuration Opcode	(1 octet)
+	configuration data	(variable)
+
+Configuration Opcodes
+---------------------
+
+Set Scan Filter
+---------------
+	Opcode:			0x01
+	Filter_Id		(1 octet)
+	Duplicates		(1 octet)
+	Num_Patterns		(1 octet)
+	Filters			(variable length)
+
+Sets scan filter parameters. Allows to specify filtering of Mesh specific
+advertisements.
+
+Set Scan
+--------
+	Opcode:			0x02
+	Enable			(1 octet)
+	Filter_Id		(1 octet)
+
+Starts/Stops scanning for Mesh advertisements.
+
+Set Tx Power
+------------
+	Opcode:			0x03
+	Tx_Power		(1 octet)
+
+Sets default Tx power.
+
+Set Channel Map
+---------------
+	Opcode:			0x04
+	Channel_Map		(1 octet)
+
+Sets default Tx channel map.
+
+Set Network Retransmit
+----------------------
+	Opcode:			0x05
+	Count			(1 octet)
+	Interval:		(2 octets)
+	Min_Random_Delay:	(1 octet)
+	Max_Random_Delay:	(1 octet)
+
+Sets Mesh network retransmit parameters.
+
+Set Relay Retransmit
+--------------------
+	Opcode:			0x06
+	Count			(1 octet)
+	Interval:		(2 octets)
+	Min_Random_Delay:	(1 octet)
+	Max_Random_Delay:	(1 octet)
+
+Sets Mesh relay retransmit parameters.
+
+Set Poll
+--------
+	Opcode:			0x07
+	Duration		(1 octet)
+	Delay			(1 octet)
+	Filter_Id		(1 octet)
+
+Configures settings for message type Poll.
+
+Tx Ancillary Data
+==================
+
+Mesh Poll Response Info
+=======================
+
+cmsg_level     cmsg_type             cmsg_data[]
+-------------------------------------------------------------------------
+SOL_BLUETOOTH  BTMESH_POLL_RSP_INFO  (Mesh Poll Response Info Parameters)
+
+	Code:	0x01
+	Parameters:
+		Instant		(4 octets)
+		Delay		(1 octet)
+		Window		(1 octet)
+
+These parameters are present in ancillary data, when payload type is set to
+Network and control field is set to Poll Response.
+
+Instant is a 4-octet opaque value that corresponds to the instant of an
+incoming mesh message (see Packet structure: kernel to user space).
+
+Delay and Window define transmit delay and window relative to the incoming
+message specified by Instant.
+
+Transmit Power
+==============
+
+cmsg_level     cmsg_type             cmsg_data[]
+---------------------------------------------------------------
+SOL_BLUETOOTH  BTMESH_TX_POWER_INFO  (Tx Power Parameters)
+
+	Code:	0x02
+	Parameters:
+		Tx_Power	(1 octet)
+
+Transmit power setting can be used for finer control on the outbound messages.
+If not present, use default value (builtin or configured).
+
+Transmit Channel
+================
+cmsg_level     cmsg_type             cmsg_data[]
+---------------------------------------------------------------
+SOL_BLUETOOTH  BTMESH_TX_CHANNEL_INFO  (Transmit Channel Parameters)
+
+	Code:	0x03
+	Parameters:
+		Tx_Channel	(1 octet)
+
+The presense of this option specifies transmit channel and allows
+for better control, e.g., to respond on the same
+channel as the one on which incoming message has been received.
+If not present, the default value will be used (builtin or configured).
+
+
+===========================================
+Packet structure: kernel to user space (Rx)
+===========================================
+
+Each Rx packet sent from the kernel to the user space contains an encrypted Mesh
+message of varibale length and may be accompanied by additional ancillary data:
+
+Receive Message Info
+====================
+
+cmsg_level     cmsg_type             cmsg_data[]
+------------------------------------------------------------------------
+SOL_BLUETOOTH  BTMESH_RECV_MSG_INFO  (Recv Message Info Parameters)
+
+	Code:	0x04
+	Parameters:
+		Instant		(4 octets)
+		Channel		(1 octet)
+		RSSI		(1 octet)
+
+
+Instant is an opaque 4-octet value that can be used to send message of type
+Poll Response to match it with the incoming mesh message.
+Channel field (1 octet) and RSSI field are informatioanal.
+
+--------------------------------------------------------------------------
+
+The socket API follows "best effort" approach for user space / kernel interface:
+there is no asynchronous feedback on status of the data sent over the socket.
+
+All multi-octet fields are in little-endian byte order (least significant byte
+first).
-- 
2.13.6

