Return-Path: <cyrus@holtmann.org>
Message-ID: <237094.65595.qm@web95415.mail.in2.yahoo.com>
Date: Thu, 23 Apr 2009 19:25:48 +0530 (IST)
From: balaji palaniswami <balaji_palaniswami@yahoo.com>
Subject: A2DP BQB Failure
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Marcel,
We are trying to run BQB for A2DP profile in Linux environment..
 
Linux flavor: Ubuntu 8.10
Kernel version: 2.6.27.7-generic
Bluez Version used: 4.12 and 4.35
DUT: Atheros USB dongle
Remote PC: PTS dongle
Test case: TC_SRC_SET_PV_1_I - To verify that source can establish stream connection successfully.
 
We are getting following error.
1. Started the test, PTS tool putting PTS dongle in discoverable mode and asking to connect from DUT.
2. First of all we are not able to use the Applet to pair with PTS dongle. We have used following commands to fix this issue,
hciconfig hci0 auth
hcitool cc <pts dongle mac>
 
Above commands helped us to pair.
3. Next we started the Rhythm player to play a song to establish connection with PTS. (Assuming all settings are done properly)
4. We are getting "Service level connection is not set correctly".
5. We debugged the stack code and found connection refused error from l2cap_connect_rsp function.
 
Do you know any patches will help to resolve this issue?
 
Thanks,
Balaji


      Cricket on your mind? Visit the ultimate cricket website. Enter http://beta.cricket.yahoo.com

