Return-Path: <cyrus@holtmann.org>
Message-ID: <1393903271.6313.3.camel@melech-server.localdomain>
Subject: cannot connect Rock Candy Gesture Controller (wiimote) on Arch Linux
From: "Mark E. Lee" <mark@markelee.com>
To: linux-bluetooth@vger.kernel.org
Date: Mon, 03 Mar 2014 22:21:11 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Salutations,

I recently purchased an off-brand wiimote from Target (USA). It is the
Rock Candy Gesture Controller (w/o motion plus). I have been unable to
connect to it via bluetooth on Arch Linux 64-bit (bluez 5.15-1). This
issue has been reported on GitHub
<https://github.com/dvdhrm/xwiimote/issues/43#issuecomment-36577704>.
I've reiterated my tests with the device below :

--OUTPUT of $ hcitool inq --iac=liac
Inquiring ...

00:17:AB:39:1C:70 clock offset: 0x5574 class: 0x002504

---OUTPUT of # hcitool info 00:17:AB:39:1C:70---
Inquiring ...
Requesting information ...
BD Address: 00:17:AB:39:1C:70
OUI Company: Nintendo Co., Ltd. (00-17-AB)
Device Name: Nintendo RVL-CNT-01
LMP Version: 3.0 (0x5) LMP Subversion: 0xc
Manufacturer: not assigned (771)
Features: 0xbc 0x02 0x04 0x38 0x08 0x00 0x00 0x00


---OUTPUT of $ hcitool inq---

Inquiring ...

---OUTPUT of $ hcitool scan---

Scanning ...

---OUTPUT of $ sdptool browse 00:17:AB:39:1C:70---
Browsing 00:17:AB:39:1C:70 ...

Service Search failed: Connection timed out

---OUTPUT of $ bluetoothctl; connect 00:17:AB:39:1C:70---

Device 00:17:AB:39:1C:70 not available

---OUTPUT of $ sdptool search 00:17:AB:39:1C:70---

Unknown service 00:17:AB:39:1C:70
----

Any help towards getting this device to work?

-- 
Mark E. Lee <mark@markelee.com>

