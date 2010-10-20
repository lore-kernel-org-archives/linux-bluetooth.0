Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 20 Oct 2010 16:21:00 +0200
Message-ID: <AANLkTikmAHP8JiBw=cYqHCbiLot6rLjjboc7wnySmEmj@mail.gmail.com>
Subject: Activating a serial connection with qdbus
From: Igor pesando <ipesando@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi *,

If I try to connect with the spp profile to a device using qdbus o dbus.send as

qdbus --system org.bluez /org/bluez/5989/hci1/dev_00_11_22_33_44
org.bluez.Serial.Connect spp

I get the proper reply /dev/rfcomm0 but the connection is dropped
immediately as rfcomm shows.
On the other side if I use rfcomm or the python script test-serial the
connection is established and kept alive.

So the questions is whether this is the expected behaviour.
Equivalently I ask whether one should interact with the dbus interface
only by programs
and use rfcomm otherwise. If so I do not understand why it is not
possible to set the Powered property
using hciconfig since if the device property Powered is false it is
not possible to initialize HCI device.

Thanks in advance for any answer.

Igor

--
-----------------------------------------------------------
fatti non foste a viver come bruti,
ma per seguire virtute e canoscenza.
Dante, Inf. XXVI 119-120

Ye were not made to live like unto brutes,
But for pursuit of virtue and of knowledge.
(Trans. H.W. Longfellow)
