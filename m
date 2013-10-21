Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Oct 2013 20:48:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "alexandre@maloteaux.net" <alexandre@maloteaux.net>,
	marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@intel.com
Subject: Re: Issue with the kernel  bluetooth  HCI_Delete_Stored_Link_Key
 command patch
Message-ID: <20131021184839.GA10592@amd.pavel.ucw.cz>
References: <413864804.130358.1382295198929.open-xchange@oxwebmail.registrar-servers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <413864804.130358.1382295198929.open-xchange@oxwebmail.registrar-servers.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

Bouncing to right people.

And yes, my thinkpad was hit by something similar, but this one was
subsequently fixed.

									Pavel

On Sun 2013-10-20 14:53:18, alexandre@maloteaux.net wrote:
>  Hi
> I bought recently an old blutooth dongle in Gabon/Africa. I guess it is a pretty
> old 2.0 as it was written "Vista Compatible" on the box : Bus 004 Device 004: ID
> 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)
> 
> When trying to use it on ubuntu 13.10 - 3.11.0-12-generic, i got the same issue 
> with hcitool :
> Can't init device hci0: Operation not supported (95)
> 
> The main issue is that the bit7 of octet 6 is set in the supported command
> response (see attached hcidump).
> 
> i tried to recompile the kernel by commenting this code :
> 
> +       if (hdev->commands[6] & 0x80) {
> +               struct hci_cp_delete_stored_link_key cp;
> +
> +               bacpy(&cp.bdaddr, BDADDR_ANY);
> +               cp.delete_all = 0x01;
> +               hci_req_add(req, HCI_OP_DELETE_STORED_LINK_KEY,
> +                           sizeof(cp), &cp);
> +       }
> 
> and it worked.
> 
> Are you sure about the flag position in the supported command ?
> If so , is not possible on fail just to continue the init process as this
> command seems obsolete.
> 
> Best Regards

> hcidump -X
> HCI sniffer - Bluetooth packet analyzer ver 2.5
> device: hci0 snap_len: 1500 filter: 0xffffffff
> < HCI Command: Read Local Supported Features (0x04|0x0003) plen 0
> > HCI Event: Command Complete (0x0e) plen 12
>     Read Local Supported Features (0x04|0x0003) ncmd 1
>     status 0x00
>     Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
> < HCI Command: Read Local Version Information (0x04|0x0001) plen 0
> > HCI Event: Command Complete (0x0e) plen 12
>     Read Local Version Information (0x04|0x0001) ncmd 1
>     status 0x00
>     HCI Version: 2.0 (0x3) HCI Revision: 0x3000
>     LMP Version: 2.0 (0x3) LMP Subversion: 0x420b
>     Manufacturer: Broadcom Corporation (15)
> < HCI Command: Read BD ADDR (0x04|0x0009) plen 0
> > HCI Event: Command Complete (0x0e) plen 10
>     Read BD ADDR (0x04|0x0009) ncmd 1
>     status 0x00 bdaddr 00:19:86:00:19:C2
> < HCI Command: Read Buffer Size (0x04|0x0005) plen 0
> > HCI Event: Command Complete (0x0e) plen 11
>     Read Buffer Size (0x04|0x0005) ncmd 1
>     status 0x00
>     ACL MTU 1017:8 SCO MTU 64:0
> < HCI Command: Read Class of Device (0x03|0x0023) plen 0
> > HCI Event: Command Complete (0x0e) plen 7
>     Read Class of Device (0x03|0x0023) ncmd 1
>     status 0x00 class 0x000000
> < HCI Command: Read Local Name (0x03|0x0014) plen 0
> > HCI Event: Command Complete (0x0e) plen 252
>     Read Local Name (0x03|0x0014) ncmd 1
>     status 0x00 name 'BCM2045B'
> < HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> > HCI Event: Command Complete (0x0e) plen 6
>     Read Voice Setting (0x03|0x0025) ncmd 1
>     status 0x00 voice setting 0x0060
> < HCI Command: Set Event Filter (0x03|0x0005) plen 1
>     type 0 condition 0
>     Clear all filters
> > HCI Event: Command Complete (0x0e) plen 4
>     Set Event Filter (0x03|0x0005) ncmd 1
>     status 0x00
> < HCI Command: Write Connection Accept Timeout (0x03|0x0016) plen 2
>     timeout 32000
> > HCI Event: Command Complete (0x0e) plen 4
>     Write Connection Accept Timeout (0x03|0x0016) ncmd 1
>     status 0x00
> < HCI Command: Read Page Scan Activity (0x03|0x001b) plen 0
> > HCI Event: Command Complete (0x0e) plen 8
>     Read Page Scan Activity (0x03|0x001b) ncmd 1
>     status 0x00 interval 2048 window 18
> < HCI Command: Read Page Scan Type (0x03|0x0046) plen 0
> > HCI Event: Command Complete (0x0e) plen 5
>     Read Page Scan Type (0x03|0x0046) ncmd 1
>     0000: 00 00                                             ..
> < HCI Command: Set Event Mask (0x03|0x0001) plen 8
>     Mask: 0xfffffbff07180000
> > HCI Event: Command Complete (0x0e) plen 4
>     Set Event Mask (0x03|0x0001) ncmd 1
>     status 0x00
> < HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0
> > HCI Event: Command Complete (0x0e) plen 68
>     Read Local Supported Commands (0x04|0x0002) ncmd 1
>     status 0x00
>     Commands: ffffffffffffcfffffffffff0300ffff07
> < HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1
>     mode 1
> > HCI Event: Command Complete (0x0e) plen 4
>     Write Inquiry Mode (0x03|0x0045) ncmd 1
>     status 0x00
> < HCI Command: Read Local Extended Features (0x04|0x0004) plen 1
>     page 1
> > HCI Event: Command Complete (0x0e) plen 14
>     Read Local Extended Features (0x04|0x0004) ncmd 1
>     status 0x00 page 1 max 0
>     Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> < HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7
>     bdaddr 00:00:00:00:00:00 all 1
> > HCI Event: Command Complete (0x0e) plen 4
>     Delete Stored Link Key (0x03|0x0012) ncmd 1
>     status 0x11 deleted 0
>     Error: Unsupported Feature or Parameter Value
> 


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
