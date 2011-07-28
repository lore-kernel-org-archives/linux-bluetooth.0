Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 28 Jul 2011 09:44:17 -0300
Message-ID: <CAKT1EBfK1P7oJpLrm2HNTQTOKoN0Z+6mh7BoeaVeA8gUQpD49g@mail.gmail.com>
Subject: Current status on BLE development
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

It is common to see questions in the ML or in the IRC asking the
status of BLE development and where the get the source code.
Below a short summary of our latest development on Bluetooth Low Energy:

* Discovery procedure over management interface (kernel): patches sent
to the mailing list, waiting maintainer approval

* SM(Security Manager): kernel & userspace
- Just Works key generation method is working and accepted upstream;
- Key Exchange and Storage: a first version of the implementation is
implemented and working, but before being accepted upstream it needs
some changes;
- Passkey Entry: Still not implemented;
- Out of Band: Still not implemented;
- Address Resolution: Planned but still not implemented;
- Command Signing: Still not implemented;

* LE connection improvements: under development

Proximity Monitor
=============
* Userspace
- New D-Bus API(improvement) was proposed and implemented, patches not
upstream[3]

* Kernel
- New RSSI Threshold Monitoring implemented. Required by Proximity
Path Loss. Under internal revision and will be sent to mailing list
after it.

git trees
===============
* For stable LE support on kernel, use Gustavo Padovan's
bluetooth-next tree:
git://git.kernel.org/pub/scm/linux/kernel/git/padovan/bluetooth-next-2.6.git
(it doesn't contain the patches for interleaved discovery using
management. Missing SM key distribution(SM phase 3).

* Unstable kernel with Interleaved Discovery, RSSI Threshold monitor,
remaining SM patches, changes in connection parameters based on
Proximity and Thermometer requirements:
http://git.infradead.org/users/vcgomes/linux-2.6.git (branch
proximity-integration)

* BlueZ Userspace
[3] git://git.infradead.org/users/cktakahasi/bluez.git proximity-devel

Regards,
Claudio
