Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: Support for Ralink RT3298 Bluetooth Module
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <519E0CC5.9010300@pdm.ac.in>
Date: Thu, 23 May 2013 19:00:32 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <95E714D7-326A-4126-9B08-124EEAF4432A@holtmann.org>
References: <519E0CC5.9010300@pdm.ac.in>
To: Mohit <mt1037ag11@pdm.ac.in>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mohit,

> There was a proprietary driver for Ralink RT3298 bluetooth module that compiled in kernel 3.2 but stopped compiling in kernel 3.3, 3.4 or 3.5 which is available here http://downloads.zotac.com/mediadrivers/mb/download/NB087_Ubuntu.zip. I get the following output when compiling in kernel 3.5 :

if neither Ralink nor Ubuntu feels the need to get this upstream, why would we care if this compiles or not. This is not how Linux works. The community is not responsible for out-of-tree drivers.

> mohit@linux-xmln:~/Downloads/NB087_Ubuntu/NB087_BT_ubuntu_release/rtbth_v3.9.3/rtbth_v3.9.3> make
> make -C /lib/modules/3.7.10-1.4-desktop/build M=/home/mohit/Downloads/NB087_Ubuntu/NB087_BT_ubuntu_release/rtbth_v3.9.3/rtbth_v3.9.3 modules
> make[1]: Entering directory `/usr/src/linux-3.7.10-1.4-obj/x86_64/desktop'
>  CC [M]  /home/mohit/Downloads/NB087_Ubuntu/NB087_BT_ubuntu_release/rtbth_v3.9.3/rtbth_v3.9.3/rtbth_core_main.o
>  CC [M]  /home/mohit/Downloads/NB087_Ubuntu/NB087_BT_ubuntu_release/rtbth_v3.9.3/rtbth_v3.9.3/rtbth_core_init.o
>  CC [M]  /home/mohit/Downloads/NB087_Ubuntu/NB087_BT_ubuntu_release/rtbth_v3.9.3/rtbth_v3.9.3/rtbth_core_pci.o
> /home/mohit/Downloads/NB087_Ubuntu/NB087_BT_ubuntu_release/rtbth_v3.9.3/rtbth_v3.9.3/rtbth_core_pci.c: In function ‘rtbt_pci_suspend’:
> /home/mohit/Downloads/NB087_Ubuntu/NB087_BT_ubuntu_release/rtbth_v3.9.3/rtbth_v3.9.3/rtbth_core_pci.c:60:43: error: ‘struct hci_dev’ has no member named ‘driver_data’


This change was made over a year ago. So seems nobody really cares enough.

commit 155961e8001719af6d87cbcc961111e8ce477843
Author: David Herrmann <dh.herrmann@googlemail.com>
Date:   Thu Feb 9 21:58:32 2012 +0100

    Bluetooth: Remove hci_dev->driver_data
    
    The linux device model provides dev_set/get_drvdata so we can use this
    to save private driver data.
    This also removes several unnecessary casts.
    
    Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
    Acked-by: Marcel Holtmann <marcel@holtmann.org>
    Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>

Regards

Marcel

