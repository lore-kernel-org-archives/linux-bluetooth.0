Return-Path: <cyrus@holtmann.org>
From: Ankur Patel <ankur@embertec.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 11 May 2015 09:18:52 +0930
Subject: LE only Mode:  PICS reference 
Message-ID: <BD5E516FF3711A41B93DC005170007BB010D943FD6AC@EMBSVR01.ember.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Folks,

I am new to the BT LE and pls bare with me if I ask some silly questions. Thank you for support. 

I am now using 3.18.12 Linux kernel and Bluez 5.30 version on board. Our product requirement is to support only LE modes. To create PICS for host system using bluez, do I have to take  http://git.kernel.org/cgit/bluetooth/bluez.git/tree/android/pics-gap.txt as a reference for selecting the configuration?
If yes, then in that case, why it has  Broadcaster and Observer selected to 'False' under line#150-151 in pics-gap.txt as bluez does supports Central/Broadcaster/Observer LE roles as mentioned under bluez-5.30/doc/supported-features.txt?

Inaddition, I am having some issue running the testcase TC_IDLE_NAMP_BV_02_C. pts-gts.txt says: "btmgmt advertising on" should work, but it is not working on my side.

Following Log info:
Test case : TC_IDLE_NAMP_BV_02_C started
                - MTC: Successfully received HCI_LE_CLEAR_WHITE_LIST_COMPLETE_EVENT.
                - MTC: Successfully received HCI_LE_ADD_DEVICE_TO_WHITE_LIST_COMPLETE_EVENT.
                - MTC: Successfully received HCI_LE_SET_SCAN_PARAMETERS_COMPLETE_EVENT.
                - MTC: Successfully received HCI_LE_SET_SCAN_ENABLE_COMPLETE_EVENT.
                - MTC: Receive Advertising report successfully.
                - MTC: Successfully received HCI_LE_SET_SCAN_ENABLE_COMPLETE_EVENT.
                - MTC: ATT connection established successfully.
                - MTC-INCONC: Error returned in ATT_READ_BY_TYPE_CFM.
                - CM_EXIT
                - CM_EXIT
                - CM_EXIT
                - CM_EXIT
                - MTC: Test case ended
                -Final Verdict: INCONC
TC_IDLE_NAMP_BV_02_C finished

-	Prior to running above command I have also set name using command 'btmgmt name test_dev'. Do I need to run more commands to it?

Thank you,
Ankur.
