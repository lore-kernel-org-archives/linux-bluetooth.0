Return-Path: <netdev-bounce@oss.sgi.com>
Subject: Re: [2.6 patch] net/bluetooth/: misc possible cleanups
From: Marcel Holtmann <marcel@holtmann.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Max Krasnyansky <maxk@qualcomm.com>, bluez-devel@lists.sourceforge.net,
   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   Network Development Mailing List <netdev@oss.sgi.com>
In-Reply-To: <20041214041352.GZ23151@stusta.de>
References: <20041214041352.GZ23151@stusta.de>
Content-Type: text/plain
Date: Tue, 14 Dec 2004 08:34:08 +0100
Message-Id: <1103009649.2143.65.camel@pegasus>
Mime-Version: 1.0
Sender: netdev-bounce@oss.sgi.com
Errors-to: netdev-bounce@oss.sgi.com
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Adrian,

> The patch below contains the following possible cleanups:
> - make needlessly global code static
> - remove the following EXPORT_SYMBOL'ed but unused functions in 
>   hci_core.c:
>   - hci_suspend_dev
>   - hci_resume_dev
>   - hci_register_cb
>   - hci_unregister_cb

these functions must stay. They have users outside the mainline kernel
that are not merged back yet. Otherwise they won't be exported ;)

> Please comment on which of these changes are correct and which conflict 
> with pending patches.

Please send a separate patch for all the RFCOMM changes, because these
conflicts with some pending patches and then it will make it easier for
me to merge them.

The rest of the changes are fine with me, but I like to see also a
separate patch for the CMTP stuff and cmtp_send_capimsg() don't need a
forward declaration. Simply move the function to another place in the
source code.

Regards

Marcel
