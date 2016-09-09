Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Montague, Jay" <jmontague@tycoint.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: bluez bluetooth problem
Date: Fri, 9 Sep 2016 10:19:48 +0000
Message-ID: <9F3DE92910DE1D4697DD7D6F2FB4FDDC25A15D17@003FCH1MPN5-071.003f.mgd2.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

Is anyone able to help me with this?

Thanks
Jay

-----Original Message-----
From: Montague, Jay
Sent: 07 September 2016 16:05
To: 'linux-bluetooth@vger.kernel.org' <linux-bluetooth@vger.kernel.org>
Subject: bluez bluetooth problem

Dear Bluez,

I am having a problem that I wondered whether you could help me with?

I'm currently working on a project in which I'm trying to communicate to an=
 Intel Edison board from my Windows PC via Bluetooth. I have managed to suc=
cessfully connect and communicate via Bluetooth using the serial port and b=
luez version 5.22. But my problem is that I can only auto connect to the PC=
 once I have already manually paired to the device. So my aim is to have so=
ftware running on the Edison which will be able to auto pair to a PC and co=
nnect without knowing the PC device id in advance, for the PC to then send =
commands and eventually files to the Edison.

I have been able to manually send serial commands to the Edison by using a =
Putty terminal and using rfcomm and the "cat /dev/rfcomm0" command. Using p=
rocess below on the Edison:

rfkill unblock bluetooth
sdptool add -channel=3D22 SP
rfcomm watch /dev/rfcomm0 22 > /dev/null & bluetoothctl agent NoInputNoOutp=
ut default-agent discoverable on

"pair with Edison from PC and accept pairing on the Edison"

cat /dev/rfcomm0

"send text to Edison via Putty terminal com port"


So I have been trying to automate this process by writing C code on the Ecl=
ipse IDE and also by writing scripts running on the Edison but I have not b=
een able to successfully send commands to the bluetoothctl function.

I have tried to send commands using the Eclipse IDE but when I send the fol=
lowing:

system("echo -e 'agent NoInputNoOutput\n | bluetoothctl");

On the Edison it reports "No agent is registered" and the following message=
:

(bluetoothctl:690): GLib-CRITICAL **: Source ID 22 was not found when attem=
pting to remove it


Also if I try to create a script file like the following:

#!/bin/sh
rfkill unblock bluetooth
sdptool add -channel=3D22 SP
sleep 1
bluetoothctl << EOF
agent NoInputNoOutput
EOF
sleep 1

Again it just report "No agent is registered".


I have been in communication with Intel support but I've got to a point whe=
re I don't think I can get any further and they have recommended that I con=
tact you.

https://communities.intel.com/thread/104504


Any help would be very much appreciated.

Kind regards

Jay




________________________________

This e-mail contains privileged and confidential information intended for t=
he use of the addressees named above. If you are not the intended recipient=
 of this e-mail, you are hereby notified that you must not disseminate, cop=
y or take any action in respect of any information contained in it. If you =
have received this e-mail in error, please notify the sender immediately by=
 e-mail and immediately destroy this e-mail and its attachments.
