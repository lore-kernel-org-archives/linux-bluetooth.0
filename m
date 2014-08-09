Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sat, 9 Aug 2014 02:32:13 -0400
Message-ID: <CALNtCMkA=9GZWNBse7TN1u-ygWEm3zt-aNvjqhyzZV9jDCtL_g@mail.gmail.com>
Subject: Gatttool: Why limited to 5 connections?
From: Nancy Ouyang <nancy.ouyang@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I connect to five devices by spawning gatttools with pexpect in
python*. When I try to connect to a sixth device (using the same CSR
4.0 dongle for all connections) manually I encounter:

sudo gatttool -b DC:05:4F:BC:F6:4A -It random
[DC:05:4F:BC:F6:4A][LE]> connect
Attempting to connect to DC:05:4F:BC:F6:4A
Error: connect error: Too many links (31)

Is this a gatttool limitation or a hardware limitation? I cloned the
source at http://git.kernel.org/cgit/bluetooth/bluez.git and ran ~$
grep -r "attempting" but did not get any results, and am unsure where
to go next. I have searched the archives of this mailing list
"gatttool too many links" but did not find relevant results.

I would like to connect to 20 devices over bluetooth low energy, which
I think should be possible hardware- and firmware-wise.

Thanks,
--Nancy

=====
System settings: Ubuntu 14.04, bluez v5.20, CSR 4.0 dongle, adafruit
ble nrf8001 breakout.

reference:

* using the c files directly instead of pexpect:
http://stackoverflow.com/questions/16224561/multiple-ble-connections-using-linux-and-bluez-5-0
* my pexpect code: https://gist.github.com/nouyang/2a6a733d8facd23115a4
* explanation of my hardware setup & pexpect code:
http://www.orangenarwhals.com/?p=911
