Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Romain Izard <romain.izard.pro@gmail.com>
Date: Fri, 17 Jul 2015 12:24:38 +0200
Message-ID: <CAGkQfmNSWjD_S+fMHqn2SxcSxz0ru86jirOq3Atu75jz97RwQw@mail.gmail.com>
Subject: Declaring the ICS to test & certify a product using BlueZ
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

To pass the Bluetooth certification, it is necessary to describe the
behaviour of the certified product in a set of documents called
Implementation Conformance Statements (ICS). These documents describe
a list of features existing in the Bluetooth specification, that can
be mandatory, optional or prohibited, as well as logic rules to
combine those features.

I'm trying to certify a product based on a Texas Instruments WL1831
chip, using the latest BlueZ userspace and the kernel module from the
TI backport environment for its R8.5 WiFi driver package (based on
Linux 3.12.10). The kernel itself is a based on a 2.6.32 vendor tree.
The userspace component is based on bluetoothd, and its DBus API. As
TI provides this chip with a pre-certified close-source bluetooth
stack when using Sitara chips (not my case), there is little
information regarding stack certification.

The good point is that this setup works, and I'm able work in both
BR/EDR and LE modes. Unfortunately, as I am only integrating all those
pieces, I do not know very well how to fill the ICS documents. Many
questions are quite low level, and I do not know how BlueZ beheaves,
nor even how to look for this behaviour.

I can try to rely on some already existing information. The "android"
directory has a set of "pics-*.txt" files, but those may not be valid
when using bluetoothd. The Bluetooth certified composant database
contains a list of BlueZ stacks certified in the past, and it is
possible to get their ICS. But the ICS format evolves with the current
certification, so it's difficult to reuse an old one. Moreover, I
believe that it is possible that the correct ICS information depends
from configuration options for the stack, either at compilation time
or at runtime.

For those of you who have already passed a Bluetooth certification,
how did choose your ICS parameters ? What are the settings you know
that correspond to ICS parameters ?

The ICS parameters lead to a long list of tests to be run in the
Profile Tuning Suite. What needs to run on the tested device to pass
those tests ? Should bluetoothd be launched, and is it required to
configure it in a special way ?


Best regards,
-- 
Romain Izard
