Return-Path: <cyrus@holtmann.org>
From: Ankur Patel <ankur@embertec.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 28 Apr 2015 17:24:58 +0930
Subject: btmgmt: failure with advertising report event
Message-ID: <BD5E516FF3711A41B93DC005170007BB010D94331BDC@EMBSVR01.ember.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Friends,

I am using Linux Kernel 3.10.32 on i.mx28 based platform with TI WL1831 WiFi/BT Module. It runs linux with Bluez 5.30. I am trying to run tests on PTS esp. for LE only mode. Hence following http://git.kernel.org/cgit/bluetooth/bluez.git/tree/android/pts-gap.txt commands to execute on device with "btmgmt" to run the tests. It fails to execute most of the commands mentioned for 
eg. "btmgmt advertising on"

It returns with Error:
root@imx28evk:~# btmgmt advertising on
Set Advertising for hci0 failed with status 0x01 (Unknown Command)

Any pointers on how to solve this error?

I have read some more documentation and found (not sure) that full feature for btmgmt is supported with Linux Kernel 3.18 only. Is that true? If Yes, Is there any way I can use that with v3.10.32?

Regards,
Ankur
