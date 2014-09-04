Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/2] android/hal-ipc-api: Add Handsfree client IPC API
Date: Thu,  4 Sep 2014 11:58:19 +0200
Message-Id: <1409824700-23052-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 317 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 317 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index ae62c10..6061ebb 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -2078,3 +2078,320 @@ Notifications:
 
 		Notification parameters: Status (4 octets)
 		                         Handle (4 octets)
+
+
+Bluetooth Handsfree Client HAL (ID 10)
+======================================
+
+Android HAL name: "hf_client" (BT_PROFILE_HF_CLIENT_ID)
+
+Commands and response:
+
+	Opcode 0x00 - Error response
+
+		Valid status values: 0x01 = Fail
+		                     0x02 = Not ready
+		                     0x03 = No memory
+		                     0x04 = Busy
+		                     0x05 = Done (already completed)
+		                     0x06 = Unsupported
+		                     0x07 = Parameter invalid
+		                     0x08 = Unhandled
+		                     0x09 = Authentication failure
+		                     0x0a = Remote device down
+
+	Opcode 0x01 - Connect command/respose
+
+		Command parameters: Remote address (6 octects)
+		Response parameters: <none>
+
+		 In case of an error, the error response will be returned.
+
+	Opcode 0x02 - Disonnect command/response
+
+		Command parameters: Remote address (6 octetcs)
+		Response parameters: <none>
+
+		 In case of an error, the error response will be returned.
+
+	Opcode 0x03 - Connect Audio command/response
+
+		Command parameters: Remote address (6 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
+	Opcode 0x04 - Disconnect Audio command/response
+
+		Command parameters: Remote address (6 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
+	Opcode 0x05 - Start Voice Recognition command/response
+
+		Command parameters: <none>
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
+	Opcode 0x06 - Stop Voice Recognition command/response
+
+		Command parameters: <none>
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
+	Opcode 0x07 - Volume Control command/response
+
+		Command parameters: Volume type (1 octet)
+		                    Volume (1 octet)
+		Response parameters: <none>
+
+		Valid volume types: 0x00 = Speaker
+		                    0x01 = Microphone
+
+		In case of an error, the error response will be returned.
+
+	Opcode 0x08 - Dial command/response
+
+		Command parameters: Number (string)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
+	Opcode 0x09 - Dial Memory command/response
+
+		Command parameters: Location (1 octet)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
+	Opcode 0x10 - Handle Call Action command/response
+
+		Command parameters: Action (1 octet)
+		                    Call Index (1 octet)
+		Response parameters: <none>
+
+		Valid actions: 0x00 = CHLD_0
+		               0x01 = CHLD_1
+		               0x02 = CHLD_2
+		               0x03 = CHLD_3
+		               0x04 = CHLD_4
+		               0x05 = CHLD_1x
+		               0x06 = CHLD_2x
+		               0x07 = ATA
+		               0x08 = CHUP
+		               0x09 = BTRH_0
+		               0x10 = BTRH_1
+		               0x11 = BTRH_2
+
+		In case of an error, the error response will be returned.
+
+	Opcode 0x11 - Query Current Calls commad/response
+
+		Command parameters: <none>
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
+	Opcode 0x12 - Query Current Operator Name
+
+		Command parameters: <none>
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
+	Opcode 0x13 - Retrieve Subscriber Info command/response
+
+		Command parameters: <none>
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
+	Opcode 0x14 - Send DTMF Code command/response
+
+		Command parameters: Code (1 octet)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
+	Opcode 0x15 - Request Last Voice Tag Number command/response
+
+		Command parameters: <none>
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
+Notifications:
+
+	Opcode 0x81 - Connection State Changed notification
+
+		Notification parameters: State (1 octet)
+		                         Peer Features (1 octet)
+		                         Address (6 octets)
+
+		Valid State values: 0x00 = Disconnected
+		                    0x01 = Connecting
+		                    0x02 = SLC Connected
+		                    0x03 = Disconnecting
+
+		Note: Peer Features is valid only in SCL Connected state
+ 
+	Opcode 0x82 - Audio State Changed notification
+
+		Notification parameters: State (1 octet)
+		                         Address (6 octets)
+
+		Valid State values: 0x00 = Disconnected
+		                    0x01 = Connecting
+		                    0x02 = Connected
+		                    0x03 = Connected mSBC
+
+	Opcode 0x83 - Voice Recognition State Changed notification
+
+		Notification parameters: State (1 octet)
+
+		Valid State values: 0x00 = VR Stopped
+		                    0x01 = VR Started
+
+	Opcode 0x84 - Network State Changed notification
+
+		Notification parameters: State (1 octet)
+
+		Valid State values: 0x00 = Network Not Available
+		                    0x01 = Network Available
+
+	Opcode 0x85 - Network Roaming Type Changed notification
+
+		Notification parameters: Type (1 octet)
+
+		Valid Type values: 0x00 = Home
+		                   0x01 = Roaming
+
+	Opcode 0x86 - Network Signal Strength notification
+
+		Notification parameters: Signal Strength (1 octet)
+
+	Opcode 0x86 - Network Battery Level notification
+
+		Notification parameters: Battery Level (1 octet)
+
+	Opcode 0x87 - Current Operator Name notification
+
+		Notification parameters: Name (string)
+
+	Opcode 0x88 - Call Indicatior notification
+
+		Notification parameters: Call (1 octet)
+
+		Valid Call values: 0x00 = No Call In Progress
+		                   0x01 = Call In Progress
+
+	Opcode 0x89 - Call Setup Indicator notification
+
+		Notification parameters: Call Setup (1 octet)
+
+		Valid Call Setup values: 0x00 = None
+		                         0x01 = Incoming
+		                         0x02 = Outgoing
+		                         0x03 = Alerting
+
+	Opcode 0x8a - Call Held Indicator notification
+
+		Notification parameters: Call Held (1 octet)
+
+		Valid Call Held values: 0x00 = None
+		                        0x01 = Hold and Active
+					0x02 = Hold
+
+	Opcode 0x8b - Resposne and Hold Status notification
+
+		Notification parameters: Status (1 octet)
+
+		Valid Status values: 0x00 = Held
+		                     0x01 = Accept
+		                     0x02 = Reject
+
+	Opcode 0x8c - Calling Line Identification notification
+
+		Notification parameters: Number (string)
+
+		Note: This will be called only on incoming call if number is
+		provided.
+
+	Opcode 0x8d - Call Waiting notification
+
+		Notification parameters: Nunmber (string)
+
+	Opcode 0x8e - Current Calls List notification
+
+		Notification parameters: Index (1 octet)
+		                         Direction (1 octet)
+		                         Call State (1 octet)
+		                         Multiparty (1 octet)
+		                         Number (string)
+
+		Valid Direction values: 0x00 = Outgoing
+		                        0x01 = Incoming
+
+		Valid Call Sate values: 0x00 = Active
+		                        0x01 = Held
+		                        0x02 = Dialing
+		                        0x03 = Alerting
+		                        0x04 = Incoming
+		                        0x05 = Waiting
+		                        0x06 = Call held by Response and Hold
+
+		Valid Multiparty values: 0x00 = Single Call
+		                         0x01 = Multiparty (conference) Call
+
+		Note: Number might be empty
+
+	Opcode 0x8f - Volume Changed notification
+
+		Notification parameters: Type (1 octet)
+		                         Volume (1 octet)
+
+		Valid Type values: 0x00 = Speaker
+		                   0x01 = Microphone
+
+	Opcode 0x90 - Command Complete Callback notification
+
+		Notification parameters: Type (1 octet)
+		                         CME (1 octet)
+
+		Valid Type values: 0x00 = OK
+		                   0x01 = Error
+		                   0x02 = Error no carrier
+		                   0x03 = Error busy
+		                   0x04 = Error no answer
+		                   0x05 = Error delayed
+		                   0x06 = Error blacklisted
+		                   0x07 = Error CME
+
+		Note: CME parameter is valid only for Error CME type
+
+	Opcode 0x91 - Subscriber Service Info Callback notification
+
+		Notification parameters: Name (string)
+		                         Type (1 octet)
+
+		Valid Type values: 0x00 = Service unknown
+		                   0x01 = Service voice
+		                   0x02 = Service fax
+
+	Opcode 0x92 - In Band Ring Settings Callback notification
+
+		Notification parameters: State (1 octet)
+
+		Valid State values: 0x00 = In band ringtone not provided
+		                    0x01 = In band ringtone provided
+
+	Opcode 0x93 - Last Voice Call Tag Number Callback notification
+
+		Notification parameters: Number (string)
+
+	Opcode 0x94 - Ring Indication notification
+
+		Notification parameters: <none>
-- 
1.8.4

