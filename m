Return-Path: <cyrus@holtmann.org>
Message-ID: <551E9BFC.9070202@hurleysoftware.com>
Date: Fri, 03 Apr 2015 09:56:12 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Frederic Danis <frederic.danis@linux.intel.com>
CC: linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org,
	jslaby@suse.cz
Subject: Re: [RFC 3/5] Bluetooth: hci_uart: Add HCIUARTSETBAUDRATE ioctl
References: <1427985456-31536-1-git-send-email-frederic.danis@linux.intel.com> <1427985456-31536-4-git-send-email-frederic.danis@linux.intel.com> <551E717A.6040500@hurleysoftware.com> <551E8C6A.8040009@linux.intel.com> <551E9987.9050800@hurleysoftware.com>
In-Reply-To: <551E9987.9050800@hurleysoftware.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 04/03/2015 09:45 AM, Peter Hurley wrote:
> I'd like to be able to help out with the firmware download problem
> but it's not clear to me at what point that is being executed since
> the patch that adds a setup() method to the protocol doesn't compile:
> 
> /home/peter/src/kernels/mainline/drivers/bluetooth/hci_ldisc.c: In function ‘hci_uart_set_proto’:
> /home/peter/src/kernels/mainline/drivers/bluetooth/hci_ldisc.c:485:11: error: ‘struct hci_uart_proto’ has no member named ‘setup’
>   hu->proto->setup = NULL;
>            ^
> /home/peter/src/kernels/mainline/drivers/bluetooth/hci_ldisc.c:488:13: error: ‘struct hci_uart_proto’ has no member named ‘setup’
>     hu->proto->setup = devtypes[i].setup;
>              ^
> make[3]: *** [drivers/bluetooth/hci_ldisc.o] Error 1

Ah, I see it's in -next. Ok, I'll go look at that.

