Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 25 Mar 2013 21:02:28 -0400
Message-ID: <CAB8sVA9vLu1CbfUmNrGqShePg+s0s3M-vhkPvo_FjOgHLcm6DQ@mail.gmail.com>
Subject: Installing & Compiling Bluez From Git
From: Brendan West <extremeskateboarding@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I've been trying to compile and install Bluez both from the Git
repository (located at
git://git.kernel.org/pub/scm/bluetooth/bluez.git) and the standard
"bluez-5.3.tar.gz" package, but I don't think it's working..  I am
following the instructions in the README file, but the Bluetooth on my
Debian Wheezy doesn't update to the Bluez 5.x version (at least I'm
assuming so, since the file in /etc/init.d/bluetooth says it's still
for Bluez 4.x; and none of the tests included with the packages work).
 I have been told by another guy on the mailing list that perhaps the
bluetoothd file didn't update properly, but I haven't been able to
figure out how to do that (I assumed that it would have updated
properly with the "make install" command).  I am new to
compiling/installing packages from source, so any tips would be
appreciated.  Thanks.

Brendan West
