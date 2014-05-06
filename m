Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Prithvi Raj Narendra
	<prithviraj.narendra@masterschool.eitictlabs.eu>
Date: Tue, 6 May 2014 15:26:35 +0200
Message-ID: <CALu-FW3mY6S+OV2c7ccDSs24HbDUO0wVhf=axjmOxg_UjP8MWQ@mail.gmail.com>
Subject: Connecting to BLE slave to communicate with L2CAP packets
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,
I am trying to connect a BLE embedded device (slave) to a BLE dongle
(master) and then communicate with L2CAP packets. For this the dongle
can successfully scan for the advertising slave with hcitool lescan
and connect with it with hcitool lecc. Next I would like to
communicate with the slave by sending and receiving L2CAP packets. How
can this be achieved? I have tried various options with l2test to do
this but haven't succeedded. I have used
-V le_random address type
-M to specify that the dongle is the master
-J 65 to specify channel id of 0x41
-i hci1 to specify the dongle

The modes that I have tried are
-u connect and receive
-n connect and be silent
-r listen and receive
-w listen and send

When trying to connect I am getting Invalid arguments(22) error. How
can I communicate with L2CAP layer with BLE devices? Any help is
greatly appreciated.
Thanks,
Prithvi
