Return-Path: <cyrus@holtmann.org>
Message-ID: <4B1CFA8A.4030503@hempeldesigngroup.com>
Date: Mon, 07 Dec 2009 07:52:26 -0500
From: Ralph Hempel <rhempel@hempeldesigngroup.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Linkkeys not permanent with Belkin 050d:016a Dongle
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm running Debian 5.0.3 with bluez-4.57 and am having some
issues pairing my LEGO MINDSTORMS NXT with my Belkin Mini Dongle.

The linkkey is always deleted after the connection is closed.

lsusb: ID 050d:016a Belkin Components

I can sucessfully pair to the LEGO NXT with the built-in Dell
Bluetooth adapter on my Dell D610

The Dell is BT 2.0 compatible, the Belkin 2.1 if that's any use.

Looking at the feature differences, the Belkin supports simple
pairing...

The LEGO NXT is probably BT 2.0.

---------------------------------------------------------------

I've got the following files set up correctly for each device:

/var/lib/bluetooth/xx:yy:zz:aa:bb:cc/pincodes - btaddr pincode
/var/lib/bluetooth/xx:yy:zz:aa:bb:cc/trusts   - btaddr [all]
/etc/bluetooth/rfcomm.conf                    - device info

My pairing attempts are all from the command line, no additional
GUI tools are loaded or used. I enable hcidump and have bluetoothd
running in the foreground with debugging on.

I'm using minicom (after pairing) to talk to the LEGO NXT using
the /dev/rfcomm0 device.

When I pair successfully using the Dell Bluetooth device the linkkey
file is updated and never changed unless I manually delete the
key for the specific device, in which case I have to re-pair.

That's expected.

When I pair with the Belkin dongle, the linkkey file is updated
BUT when I close the connection the hcidump says:

HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7

and the key is deleted from the linkkeys file.

I've poked around in the bluez source and see that link key removal
seems to be tied to a "temporary" flag that gets set at connection
time.

Would additional bluetoothd dumps from each paring attempt be useful,
or is there a set of commands I can run on each dongle to dump out
feature sets?

Ralph


