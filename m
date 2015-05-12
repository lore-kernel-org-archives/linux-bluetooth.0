Return-Path: <cyrus@holtmann.org>
From: Ankur Patel <ankur@embertec.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 12 May 2015 18:53:26 +0930
Subject: Issue with Add Advertisement and Bonding Procedure 
Message-ID: <BD5E516FF3711A41B93DC005170007BB010D943FDA25@EMBSVR01.ember.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Folks,

Back with some more questions. I did tried googling but couldn't able to find much info on 'btmgmt' tool hence sharing issues. 

Ran below commands to Setup the device (All went Good):
btmgmt name testbt
btmgmt privacy on
btmgmt le on  
btmgmt keys on
btmgmt ltks off
btmgmt irks
btmgmt connectable on
btmgmt bondable on
btmgmt pairable on
btmgmt discov on
btmgmt advertising on
btmgmt fast-conn on
btmgmt linksec on
btmgmt power on

Failed to Add Advertisement
------------------------------------

root@imx28evk:~/tools# btmgmt info
Index list with 1 item
hci0:   Primary controller
        addr 1C:BA:8C:86:81:21 version 6 manufacturer 13 class 0x000000
        supported settings: powered connectable fast-connectable discoverable bondable link-security ssp br/edr hs le advertising debug-keys privacy
        current settings: powered connectable fast-connectable discoverable bondable link-security ssp br/edr hs le advertising debug-keys privacy
        name testbt
        short name

// Starting Gatt Service
root@imx28evk:~/tools# ./gatt-service &
gatt-service unique name: :1.6
Registered service: /service1
Get UUID: 00001802-0000-1000-8000-00805f9b34fb
Exist Includes: 00001802-0000-1000-8000-00805f9b34fb
Characteristic(00002a06-0000-1000-8000-00805f9b34fb): Get("Value")
Descriptor(8260c653-1a54-426b-9e36-e84c238bc669): Get("Value")

// Adding Advertisement but Fails
root@imx28evk:~/tools# btmgmt add-adv -u 180d -u 180f -d 090954657374204C4505FFE0000102 1
Add Advertising failed with status 0x01 (Unknown Command)

I am sure I am missing something to add advertisement. Can anyone share how to add advertisement? 

Test case: TC_CONN_GCEP_BV_03_C
-----------------------------------------------
PTS Address:        00:1B:DC:07:2E:85

Ran below command on device before running the test:

root@imx28evk:~/tools# btmgmt info
Index list with 1 item
hci0:   Primary controller
        addr 1C:BA:8C:86:81:21 version 6 manufacturer 13 class 0x000000
        supported settings: powered connectable fast-connectable discoverable bondable link-security ssp br/edr hs le advertising debug-keys privacy
        current settings: powered connectable fast-connectable discoverable bondable link-security ssp br/edr hs le advertising debug-keys privacy
        name testbt
        short name
root@imx28evk:~/tools# btmgmt keys on
Keys successfully loaded
root@imx28evk:~/tools# btmgmt ltks off
Long term keys successfully loaded
root@imx28evk:~/tools# btmgmt irks
Identity Resolving Keys successfully loaded

Step1) Run the testcase from PTS gui.
Step2) It comes with popup: "Please send connect request to establish a connection"
Step3) Ran below command on Device:

        root@imx28evk:~/tools# btmgmt add-device -a 0x1  -t 0x01 00:1B:DC:07:2E:85
        Adding device with 00:1B:DC:07:2E:85 (LE Public)

        root@imx28evk:~/tools# btmgmt pair -c 0x03 -t 0x01 00:1B:DC:07:2E:85
        Pairing with 00:1B:DC:07:2E:85 (LE Public)
        hci0 00:1B:DC:07:2E:85 type LE Public connected eir_len 0
        <Waited for 2 mins. Not returned to command prompt - Hence did ctrl-c>

        Then run below command to check if the connection is there or not. 

        root@imx28evk:~/tools# btmgmt con
        00:1B:DC:07:2E:85 type LE Public

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
    
The device is in bondable mode based on the btmgmt info command output as above. Still I couldnt able to find why PTS fails to start Bonding Procedure? Is there something related to storing of the ltks keys? 

Please share your suggestions.

Thank you,
Ankur.
