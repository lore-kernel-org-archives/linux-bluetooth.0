Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 2/2] android: Add PTS PICS for HID
Date: Fri, 15 Nov 2013 11:45:32 +0100
Message-Id: <1384512332-21906-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1384512332-21906-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1384435587-12427-1-git-send-email-jakub.tyszkowski@tieto.com>
 <1384512332-21906-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS PICS for HID, targeting Android 4.4.

---
 android/pics-hid.txt | 125 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)
 create mode 100644 android/pics-hid.txt

diff --git a/android/pics-hid.txt b/android/pics-hid.txt
new file mode 100644
index 0000000..d45fe33
--- /dev/null
+++ b/android/pics-hid.txt
@@ -0,0 +1,125 @@
+HID PICS for the PTS tool.
+
+* - different than PTS defaults
+
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_HID_1_1	True (*)	Role: Host, Report protocol
+TSPC_HID_1_2	False		Role: HID Role
+TSPC_HID_1_3	False		Role: Host, Boot protocol
+TSPC_HID_2_1	True		Host: Establish HID connection
+TSPC_HID_2_2	True		Host: Accept HID connection
+TSPC_HID_2_3	True		Host: Terminate HID connection
+TSPC_HID_2_4	True		Host: Accept termination of HID connection
+TSPC_HID_2_5	True		Host: Support for virtual cables
+TSPC_HID_2_6	True		Host: HID initiated connection
+TSPC_HID_2_7	True		Host: Host initiated connection
+TSPC_HID_2_8	True		Host: Host data transfer to HID
+TSPC_HID_2_9	True		Host: HID data transfer to Host
+TSPC_HID_2_10	False		Host: Boot mode data transfer to Host
+TSPC_HID_2_11	False		Host : Boot mode data transfer to HID
+TSPC_HID_2_12	False		Host : Support for Application to send
+					GET_Report
+TSPC_HID_2_13	False		Host : Support for Application to send
+					SET_REPORT
+TSPC_HID_2_14	False		Host : Support for sending HCI_CONTROL with
+					VIRTUAL_CABLE_UNPLUG
+TSPC_HID_2_15	False		Host : Support for receiving HCI_CONTROL with
+					VIRTUAL_CABLE_UNPLUG
+TSPC_HID_3_1	False		Host : Data reports larger than host MTU on
+					Control channel
+TSPC_HID_3_2	True (*)	Host : Data reports larger than host MTU on
+					Interrupt channel
+TSPC_HID_3_3	True (*)	Host : Data reports to host
+TSPC_HID_3_4	False		Host : Boot mode reports to host
+TSPC_HID_4_1	False		Host : Data reports larger than device MTU on
+					Control channel
+TSPC_HID_4_2	False		Host : Data reports larger than device MTU on
+					Interrupt channel
+TSPC_HID_4_3	True (*)	Host : Data reports to device
+TSPC_HID_4_4	False		Host : Boot mode reports to device
+TSPC_HID_5_1	False		Host : Set_Protocol command
+TSPC_HID_5_2	False		Host : Get_Protocol command
+TSPC_HID_5_3	False		Host : Set_Idle command
+TSPC_HID_5_4	False		Host : Get_Idle command
+TSPC_HID_5_5	False (*)	Host : Set_Report command
+TSPC_HID_5_6	False (*)	Host : Get_Report command
+TSPC_HID_6_1	False		Host : Initiate Authentication before
+					connection completed
+TSPC_HID_6_2	False		Host : Initiate Authentication after connection
+					completed
+TSPC_HID_6_3	False		Host : Initiate pairing before connection
+					completed
+TSPC_HID_6_4	False		Host : Initiate pairing after connection
+					completed
+TSPC_HID_6_5	False		Host : Encryption
+TSPC_HID_6_6	False		Host : Initiate encryption
+TSPC_HID_6_7	False		Host : Accept encryption requests
+TSPC_HID_6_8	True		Host : Role switch (Master/Slave)
+TSPC_HID_6_9	True		Host : Request Master Slave switch
+TSPC_HID_6_10	True		Host : Accept Master Slave switch requests
+TSPC_HID_6_11	False		Host : Hold mode
+TSPC_HID_6_12	True		Host : Sniff mode
+TSPC_HID_6_13	False		Host : Park mode
+TSPC_HID_7_1	True		Host : Supports inquiry, 79 channel
+TSPC_HID_7_2	False (*)	Host : Supports inquiry scan, 79 channel
+TSPC_HID_8_1	False		Hid : Pointing HID
+TSPC_HID_8_2	False		Hid : Keyboard HID
+TSPC_HID_8_3	False		Hid : Identification HID
+TSPC_HID_8_4	False		Hid : Other HID
+TSPC_HID_9_1	False		Hid : Establish HID connection
+TSPC_HID_9_2	False (*)	Hid : Accept HID connection
+TSPC_HID_9_3	False		Hid : Terminate HID connection
+TSPC_HID_9_4	False (*)	Hid : Accept Termination of HID connection
+TSPC_HID_9_5	False		Hid : Support for virtual cables
+TSPC_HID_9_6	False		Hid : HID initiated reconnection
+TSPC_HID_9_7	False		Hid : Host initiated reconnection
+TSPC_HID_9_8	False		Hid : Host data transfer to HID
+TSPC_HID_9_9	False		Hid : HID data transfer to Host
+TSPC_HID_9_10	False		Hid : HID Boot mode data transfer to Host
+TSPC_HID_9_11	False		Hid : Host Boot mode data transfer to HID
+TSPC_HID_9_12	False		Hid : Output reports declared
+TSPC_HID_9_13	False		Hid : Input reports declared
+TSPC_HID_9_14	False		Hid : Feature reports declared
+TSPC_HID_9_15	False		Hid : Support for sending HCI_CONTROL with
+					VIRTUAL_CABLE_UNPLUG
+TSPC_HID_9_16	False		Hid : Support for receiving HCI_CONTROL with
+					VIRTUAL_CABLE_UNPLUG
+TSPC_HID_10_1	False		Hid : Data reports larger than host MTU on
+					Control channel
+TSPC_HID_10_2	False		Hid : Data reports larger than host MTU on
+					Interrupt channel
+TSPC_HID_10_3	False		Hid : Data reports to host
+TSPC_HID_10_4	False		Hid : Boot mode reports to host
+TSPC_HID_11_1	False		Hid : Data reports larger than device MTU on
+					Control channel
+TSPC_HID_11_2	False		Hid : Data reports larger than device MTU on
+					Interrupt channel
+TSPC_HID_11_3	False		Hid : Data reports to device
+TSPC_HID_11_4	False		Hid : Boot mode reports to device
+TSPC_HID_12_1	False		Hid : Set_Protocol command
+TSPC_HID_12_2	False		Hid : Get_Protocol command
+TSPC_HID_12_3	False		Hid : Set_Idle command
+TSPC_HID_12_4	False		Hid : Get_Idle command
+TSPC_HID_12_5	False		Hid : Set_Report command
+TSPC_HID_12_6	False		Hid : Get_Report command
+TSPC_HID_13_1	False		Hid : Host initiated Authentication before
+					connection completed
+TSPC_HID_13_2	False		Hid : Host initiated Authentication after
+					connection completed
+TSPC_HID_13_3	False		Hid : Initiate pairing before connection
+					completed
+TSPC_HID_13_4	False		Hid : Initiate pairing after connection
+					completed
+TSPC_HID_13_5	False		Hid : Encryption
+TSPC_HID_13_6	False		Hid : Initiate encryption
+TSPC_HID_13_7	False		Hid : Accept encryption requests
+TSPC_HID_13_8	False		Hid : Role switch (Master/Slave)
+TSPC_HID_13_9	False		Hid : Request Master Slave switch
+TSPC_HID_13_10	False		Hid : Accept Master Slave switch requests
+TSPC_HID_13_11	False		Hid : Hold mode
+TSPC_HID_13_12	False		Hid : Sniff mode
+TSPC_HID_13_13	False		Hid : Park mode
+TSPC_HID_14_1	False		Hid : Supports inquiry, 79 channel
+TSPC_HID_14_2	False (*)	Hid : Supports inquiry scan, 79 channel
+TSPC_ALL	False		Enables all test cases when set to true.
-- 
1.8.4.1

