Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hid2hci and Logitech Hub
From: Marcel Holtmann <marcel@holtmann.org>
To: Alexander Holler <holler@ahsoftware.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <30700000.1072366993@[192.168.207.2]>
References: <8430000.1072356496@[192.168.207.2]>
	 <1072363056.2876.75.camel@pegasus>  <30700000.1072366993@[192.168.207.2]>
Content-Type: text/plain
Message-Id: <1072369721.2876.90.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 25 Dec 2003 17:28:42 +0100

Hi Alexander,

make sure that you always post also the answers to the mailing list ;)

> > Logitech uses some specific HID reports to switch the device from HID to
> > HCI mode. They use the report ID 16 for that and we also must send the
> > same reports through hiddev interface of the USB HID driver, but by now
> > I haven't figured out how to do it the right way.
> 
> Ah, thanks, then I've got allways 'device busy' because the hid-driver uses 
> the interface.
> As I've just found an example to send HID reports, I will try if I have 
> luck finding the correct sequence.

I think it will be this one

	0x10, 0xff, 0x81, 0x80, 0x00, 0x00, 0x00

The 0x10 is the report ID.

> PS: 2.6 and the patch for 2.6 still oops when I disable the 
> bluetooth-device of my nb. Commenting out release of the isoc_iface (which 
> is still done automacally) helps. I will write these days a report to the 
> usb-helpline.

For now simply compile your kernel without USB SCO support. I still
haven't found the time to look deeper into it.

> PPS: Is there anywhere a irc channel or jabber conference for 
> bluez-users/devels?

Not that I know of.

> PPPS: I would prefer /usr/local as preset prefix for installing the lib2 
> (and the headers). ;)

I prefer /usr, but that is no problem anyway. Use --prefix ;)

> PPPPS: In a report to Logitech about some problems with the DiNovo (The 
> device shows  12-hour format instead 24-hour format) I've asked them too 
> about some help switching the hub. Maybe I will get an answer, because that 
> should reach one of the developers. The first answer from them was 
> deinstall and reinstall, but deinstalling the widcomm-stack doesn't switch 
> back the hub to hid-modus, so I haven't a chance to interact with my 
> computer (for reset) after the stack was deinstalled. So my second report 
> where I've asked about how to switch the hub could reach someone with 
> enough knowledge. ;)

Keep me informed if you got any success.

> I would be nice using the MediaPad under Linux, showing important messages 
> on the lcd. ;)

That is not really hard to achieve. I already reverse engineered most of
the protocol they use on report ID 16 and 17, but I don't found the time
to write it up.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
