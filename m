Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 17 Jun 2009 15:03:44 +0300
Message-ID: <508e92ca0906170503y360613b2n42d9454fefb6815e@mail.gmail.com>
Subject: Double SSP paring error or feature?
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

We have error with SSP paring. Originally we could not connect some
devices and the problem was reproduced on my PC with 2 USB Bluetooth
adapters.

bluez asks user paring confirmation 2 times.

Test:

hci1:	Type: USB
	BD Address: 00:02:72:16:4E:D5 ACL MTU: 1021:8 SCO MTU: 64:1
	UP RUNNING PSCAN
	RX bytes:12122 acl:78 sco:0 events:449 errors:0
	TX bytes:22547 acl:82 sco:0 commands:294 errors:0

hci2:	Type: USB
	BD Address: 00:02:72:16:19:39 ACL MTU: 1021:8 SCO MTU: 64:1
	UP RUNNING PSCAN
	RX bytes:12593 acl:82 sco:0 events:475 errors:0
	TX bytes:28404 acl:78 sco:0 commands:329 errors:0


hci1:
sudo ./l2test -i hci1 -r -E -S   # server

hci2:
sudo ./l2test -i hci2 -n 00:02:72:16:4E:D5 -b 10 -N 1 -E -S -s   # client

 ./simple-agent hci1
Agent registered
RequestConfirmation (/org/bluez/6255/hci1/dev_00_02_72_16_19_39, 533464)
Confirm passkey (yes/no): yes
RequestConfirmation (/org/bluez/6255/hci1/dev_00_02_72_16_19_39, 152200)
Confirm passkey (yes/no): yes


./simple-agent hci2
Agent registered
RequestConfirmation (/org/bluez/6255/hci2/dev_00_02_72_16_4E_D5, 533464)
Confirm passkey (yes/no): yes
RequestConfirmation (/org/bluez/6255/hci2/dev_00_02_72_16_4E_D5, 152200)
Confirm passkey (yes/no): yes

For the single connection passkey is asked 2 times.

The reason looks to be because bluetoothd does not store link keys
since ioctl  HCIGETAUTHINFO returns 0.
Kernel in function hci_get_auth_info returns "conn->auth_type" which
is 0 at this stage. As I understood
"auth_type" initialized later when "l2cap_connect_req" comes in
"l2cap_check_security".

What is the best way to solv this? In kernel or in user-space? Is it an error?

Regards,
Andrei
