Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4044F692.3080605@superbug.demon.co.uk>
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Nils Faerber <nils.faerber@kernelconcepts.de>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problem with hci_usb
References: <1078247120.9057.85.camel@localhost>
In-Reply-To: <1078247120.9057.85.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 02 Mar 2004 21:03:14 +0000

Nils Faerber wrote:
> Hi!
> I just found a quite strange problem with the hci_usb driver.
> We have a Fujitsu Siemens Lifebook with builtin Bluetooth here. This
> seems to be a CSR chipset connected via USB internally.
> The problem is that the chipset is set to SCO-PCM not SCO-HCI.
> Subsequently when SCO is enabled in the hci_usb driver something goes
> wrong and the usb-uhci driver constanly generates interrupts which are
> accounted to the UHCI and as ERR interrupts (in /proc/interrupts).
> Enabling debugging for USB does not produce anything new.
> What helped a lot is to disable the SCO option for the hci_usb driver.
> But this solution is quite unsatisfying since externally connected USB
> Bluetooth dongles would bow also not be able to use SCO over HCI even if
> they support it.
> 
> This is kernel 2.4.25 without additional patches.
> 
> The hci_usb in 2.6.3 must be somewhat different.
> It reports unsupported isochronous URBs (sorry, might be wrong, this is
> from my memory since I do not have 2.6.3 logs anymore) and disbled it at
> device startup. No more unnecessary interrupts and especially no ERR
> interrupts here.
> 
> So, are those changes also available as patch to fix the 2.4.25 driver?
> The current 2.4.25-mh1 patch at least does not seem to include a fix for
> this problem...
> 
> Apart from that, works like a charm! (Oh, I had to increase the USB
> hub.c DEBOUNCE_TIMEOUT from 400 to 1500 to make the device detect
> work...)
> 
> CU
>   nils faerber
> 

SCO support in bluez is still in development.
Once it works correctly in 2.6.x, someone might back port it to 2.4.x, 
but there is no point in back porting something until it is finished.
Everything you describe above is "known issues".

Cheers
James



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
