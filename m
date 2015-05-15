Return-Path: <cyrus@holtmann.org>
From: Ankur Patel <ankur@embertec.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 15 May 2015 18:49:20 +0930
Subject: Issue: PTS Test case TC_CONN_GCEP_BV_03_C
Message-ID: <BD5E516FF3711A41B93DC005170007BB010E5D9DF140@EMBSVR01.ember.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Folks,

Device Configuration:  Linux Kernel: 3.18.12 & Bluez: 5.30++73b28a10cb
PTS MAC Address: 00:1B:DC:07:2E:85
Device MAC Address: 1C:BA:8C:86:81:21

I am facing issue passing the Test case TC_CONN_GCEP_BV_03_C on PTS. 

On Device:
Step1> Ran Bluetoothd using command: /usr/lib/bluez5/bluetooth/bluetoothd -d -n -E & 
Step2> Setup the Device using bluetoothctl as below: 
[bluetooth]# show
Controller 1C:BA:8C:86:81:21
        Name: test-bt
        Alias: test-bt
        Class: 0x400000
        Powered: yes
        Discoverable: no
        Pairable: yes
        UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
        UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
        UUID: SIM Access                (0000112d-0000-1000-8000-00805f9b34fb)
        UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
        UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
        UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
        UUID: Heart Rate                (0000180d-0000-1000-8000-00805f9b34fb)
        UUID: Vendor specific           (12345678-1234-5678-1234-56789abcdef0)
        Modalias: usb:v1D6Bp0246d051E
        Discovering: no

ON PTS:
Step1) Run the testcase  TC_CONN_GCEP_BV_03_C from PTS gui.
Step2) It comes with popup: "Please send connect request to establish a connection"
Step3) Ran below command on Device:

[bluetooth]# pair 00:1B:DC:07:2E:85
Attempting to pair with 00:1B:DC:07:2E:85
[CHG] Device 00:1B:DC:07:2E:85 Connected: yes
                [bluetooth]#
Step4) Meanwhile, on PTS "Connect request" Popup disappear and new popup appears "Please start the Bonding Procedure in bondable mode" and stays forever.

ON PTS Output Window:
Test case : TC_CONN_GCEP_BV_03_C started
                - MTC: Successfully received HCI_LE_CLEAR_WHITE_LIST_COMPLETE_EVENT.
                - MTC: Successfully received HCI_LE_ADD_DEVICE_TO_WHITE_LIST_COMPLETE_EVENT.
                - MTC: LE bondable mode successfully set.
                - MTC: Successfully received HCI_LE_SET_ADVERTISING_PARAMETERS_COMPLETE_EVENT.
                - MTC: Successfully received HCI_LE_SET_ADVERTISING_DATA_COMPLETE_EVENT.
                - MTC: Successfully received HCI_LE_SET_SCAN_RESPONSE_DATA_COMPLETE_EVENT.
                - MTC: Successfully received HCI_LE_SET_ADVERTISE_ENABLE_COMMAND_COMPLETE_EVENT.
                - MTC: Successfully received HCI_LE_CONNECTION_COMPLETE_EVENT.
    <No More Output>
    
Output on DEVICE:
bluetoothd[4521]: src/agent.c:agent_ref() 0x146c820: ref=2
bluetoothd[4521]: src/device.c:bonding_request_new() Requesting bonding for 00:1B:DC:07:2E:85
bluetoothd[4521]: src/agent.c:agent_ref() 0x146c820: ref=3
bluetoothd[45[177100.375066] hci0: type 1 len 5
21]: src/agent.c:agent_unref() 0[177100.381298] hci0: type 1 len 29
x146c820: ref=2
bluetoothd[4521]: src/adapter.c:suspend_discovery()
bluetoothd[4521]: src/adapter.c:adapter_bonding_attempt() hci0 bdaddr 00:1B:DC:07:2E:85 type 1 io_cap 0x03
[177101.727353] hci0: type 2 len 16
bluetoothd[4521]: src/adapter.c:connected_callback() hci0 device 00:1B:DC:07:2E:85 connected eir_len 0
bluetoothd[4521]: src/gatt-database.c:connect_cb() New incoming LE ATT connection
bluetoothd[4521]: attrib/gattrib.c:g_att[177101.803319] hci0: type 2 len 12
rib_ref() 0x146c6e0: g_attrib_ref=1
[177101.864789] hci0: type 2 len 26
bluetoothd[4521]: src/device.c:gatt_debu[177102.005372] hci0: type 2 len 16
g() MTU exchange complete, with MTU: 23
[177102.072631] hci0: type 2 len 26
[177102.146201] hci0: type 2 len 16
bluetoothd[4521]: src/device.c:gatt_debug() Primary service discovery failed. ATT ECODE: 0x0a
[177102.212893] hci0: type 1 len 32
bluetoothd[4521]: src/device.c:gatt_debug() Secondary service discovery failed. ATT ECODE: 0x0a
bluetoothd[4521]: src/device.c:gatt_debug() Failed to initialize gatt-client
bluetoothd[4521]: src/device.c:gatt_client_ready_cb() status: failed, error: 10

After looking into the protocol viewer, I found that the PTS is responding "Errorcode: Attribute not found" to  Read by Group Type Request for primary/secondary service by Device. This triggers failing of bonding procedure between device and PTS. Do I need to configure PTS for this? Am I on correct direction to run the test case?

Regards,
Ankur.
