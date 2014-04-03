Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: Ralink driver compilation probleme since past commit
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAEvBDCU5u+vVYAM4-3WYh4=MLUoD6YyXhDoUGzaEHoTeXmv9jg@mail.gmail.com>
Date: Thu, 3 Apr 2014 13:53:25 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F6CCE523-79B6-4513-8CD4-A6BA322F2E0B@holtmann.org>
References: <CAEvBDCU5u+vVYAM4-3WYh4=MLUoD6YyXhDoUGzaEHoTeXmv9jg@mail.gmail.com>
To: =?iso-8859-1?Q?Aur=E9lien_Ridet?= <aurelien.ridet@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Auelien,

> Today I encountered a problem with driver compilation.
> 
> I'm trying to install a combo Wifi + Bluetooth RALINK card and I can't
> get Bluetooth drivers 3.9.3 compiled. Here is a part of log
> /var/lib/dkms/rtbth/3.9.3/
> build/make.log :
> 
> [...]
> /var/lib/dkms/rtbth/3.9.3/build/src/rtbth_core_bluez.c:406:6: error:
> 'struct hci_dev' has no member named 'ioctl'  hdev->ioctl = rtbt_hci_dev_ioctl;
> [...]
> 
> Searching on Internet, I found that :
> 
> CommitDate: Thu Oct 10 22:11:41 2013 +0200 Bluetooth: Remove
> hdev->ioctl driver callback Since there is no use of hdev->ioctl by
> any Bluetooth driver since ever, so just lets remove it.
> 
> Unfortunnaly this one used this structure.
> Could you help me please ?
> $ uname -r
> 3.13-1-686-pae
> 
> Will this commit reverted ?
> Can I undo it myself and recompile everything (how must I do)?
> OR how far must I downgrade my kernel to compile this driver ? (I can't
> find what was the first to use this modification).

we are not converting the commit. This driver is an out-of-tree driver and as such it can break any time. The smart thing for Ralink/Mediatek to do would be to get this driver merged into the Bluetooth subsystem of the kernel.

Regards

Marcel

