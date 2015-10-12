Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 12 Oct 2015 15:55:23 +0800
Message-ID: <CACw_oNf4Lg5p3m6UDtBSQb21qC6KybJynGG3-AoTLprVfwk4-A@mail.gmail.com>
Subject: Question: how can a bluetooth peripheral keep working after switching
 the adapter(CSR chip) on pc from hid to hci mode ?
From: M Ren <itux.ren@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi developers ,

I have a embeded device (named Device) which is paired with a
peripheral (named Peripheral),
Device is a CSR chip supporting BR/EDR and BLE, working under hid mode,
Peripheral supports  BLE HID

I intend to achive this :
log into to Device like ssh,
then excute hid2hci , so Device goes into hci mode,
how can the Peripheral keep working without end-user's extra actions
like pressing button on Device or Peripheral ?

My thought:
On Device, I can use bccmd to read all ps_keys ,
and from CSR documents, it mentioned ps_keys related to paring,
like EDIV, RAND, LTK .
can I creat files under /var/lib/bluetooth/<Device bdaddr>/<Peripheral bdaddr>/
before excuting hid2hci ?
which files and items in it are mandatory ?

if this way doesn't make sense, do you have some suggestions ?
