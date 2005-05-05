Return-Path: <netdev-bounce@oss.sgi.com>
Subject: Re: [2.6 patch] net/bluetooth/: possible cleanups
From: Marcel Holtmann <marcel@holtmann.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: marcel@holtmann.or.sgi.com, maxk@qualcomm.com,
   bluez-devel@lists.sourceforge.net, netdev@oss.sgi.com,
   linux-kernel@vger.kernel.org
In-Reply-To: <20050505002310.GF3593@stusta.de>
References: <20050505002310.GF3593@stusta.de>
Content-Type: text/plain
Date: Thu, 05 May 2005 15:28:30 +0200
Message-Id: <1115299710.8496.168.camel@pegasus>
Mime-Version: 1.0
Sender: netdev-bounce@oss.sgi.com
Errors-to: netdev-bounce@oss.sgi.com
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Adrian,

> This patch contains the following possible cleanups:
> - #ifdef HCI_DATA_DUMP the following function:
>   lib.c: bt_dump
> - #if 0 the following unused global functions:
>   - hci_core.c: hci_suspend_dev
>   - hci_core.c: hci_resume_dev
> - remove the following unneeded EXPORT_SYMBOL's:
>   - hci_core.c: hci_dev_get
>   - hci_core.c: hci_send_cmd
>   - hci_event.c: hci_si_event
> 
> Please review which of these changes do make sense and which conflict 
> with pending patches.

I like to let hci_suspend_dev() and hci_resume_dev() stay for now. No
driver uses it, but actually nobody really looked deep enough to really
understand the needs for suspend of Bluetooth devices.

The hci_dev_get(), hci_send_cmd() and hci_si_event() doesn't need to be
exported. And I think that the bt_dump() and and BT_DMP() stuff can be
removed completely.

Please redo the patch and actually it is enough to copy the bluez-devel
mailing list. I will take care of getting it back into mainline.

Regards

Marcel
