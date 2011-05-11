Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 11 May 2011 09:52:28 +0100
Message-ID: <BANLkTimHaJaCjawT2JuW0kH18ihkyVr5Yg@mail.gmail.com>
Subject: HCI data payload not getting through when using BlueZ
From: Eponymous - <the.epon@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=000e0ce02aaa3a96a204a2fc310b
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--000e0ce02aaa3a96a204a2fc310b
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I've ran into an issue where data doesn't seem to be received by a slave device.

I do the following:

Using Gentoo Linux (2.6.34-gentoo-r1)
Using BlueZ 4.81

1. Use BlueZ to connect to two Bluetooth devices using HCI only. This
is over USB.

2. I set one device as a slave and then create a connection between
the two. This completes sucessfully and can be seen on both sides.

3. I then try to send an acl packet with the word "hi" in it and it is
not received on the other side.

--------

Doing the same thing above but:

Using Fedora Core 5 (2.6.20-1.2320.fc5)
And:
bluez-libs-2.25-1
bluez-pin-0.30-2
bluez-utils-2.25-4
bluez-libs-devel-2.25-1
bluez-hcidump-1.30-1

and using the same hardware - the problem doesn't happen.

I have attached two HCI dumps, one of the Master device and one of the Slave.

Thanks for any help you can give.

--000e0ce02aaa3a96a204a2fc310b
Content-Type: application/octet-stream; name="master.out"
Content-Disposition: attachment; filename="master.out"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gnk12z7n0

EQAAAFNPyU01cQMAAQUEDSExAFsCABjMAQAAAAAHAAEAU0/JTdWIAwAEDwQAAQUEDgABAFVPyU1/
DQYABAMLACsAITEAWwIAAQAGAAEAVU/JTdYoBgAEGwMrAAUEAAAAWk/JTQRlBQABBRAADgABAFpP
yU13cQUABA4LAQUQADYBQAoACAALAAAAWk/JTbZyBQACKyAGAAIAQABoaQ==
--000e0ce02aaa3a96a204a2fc310b
Content-Type: application/octet-stream; name="slave.out"
Content-Disposition: attachment; filename="slave.out"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gnk1347v1

BwAAAEtPyU1SPwEAAQUMAwIAAgcAAQBLT8lNClIBAAQOBAEFDAAFAAAAS0/JTUVTAQABGgwBAwcA
AQBLT8lNwF0BAAQOBAEaDAAEAAAAS0/JTZJeAQABCRAADQABAEtPyU16aQEABA4KAQkQACExAFsC
AA4AAQBVT8lNYxEGAAQDCwArAN/+AVsCAAEACgABAFVPyU1LFQYABCAH3/4BWwIAAQYAAQBVT8lN
GB0GAAQbAysABQ==
--000e0ce02aaa3a96a204a2fc310b--
