Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: =?ISO-8859-1?Q?Aur=E9lien_Ridet?= <aurelien.ridet@gmail.com>
Date: Thu, 3 Apr 2014 22:32:45 +0200
Message-ID: <CAEvBDCU5u+vVYAM4-3WYh4=MLUoD6YyXhDoUGzaEHoTeXmv9jg@mail.gmail.com>
Subject: Ralink driver compilation probleme since past commit
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear,

Today I encountered a problem with driver compilation.

I'm trying to install a combo Wifi + Bluetooth RALINK card and I can't
get Bluetooth drivers 3.9.3 compiled. Here is a part of log
/var/lib/dkms/rtbth/3.9.3/
build/make.log :

[...]
/var/lib/dkms/rtbth/3.9.3/build/src/rtbth_core_bluez.c:406:6: error:
'struct hci_dev' has no member named 'ioctl'  hdev->ioctl = rtbt_hci_dev_ioctl;
[...]

Searching on Internet, I found that :

CommitDate: Thu Oct 10 22:11:41 2013 +0200 Bluetooth: Remove
hdev->ioctl driver callback Since there is no use of hdev->ioctl by
any Bluetooth driver since ever, so just lets remove it.

Unfortunnaly this one used this structure.
Could you help me please ?
$ uname -r
3.13-1-686-pae

Will this commit reverted ?
Can I undo it myself and recompile everything (how must I do)?
OR how far must I downgrade my kernel to compile this driver ? (I can't
find what was the first to use this modification).

Best regard.
Aurelien.

I can give you any detail you ask for.

Sorry for English faults, it's not my native language.
