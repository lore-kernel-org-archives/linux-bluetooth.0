Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Logitech diNovo hub not recognized?
From: Marcel Holtmann <marcel@holtmann.org>
To: Holger Frydrych <h.frydrych@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40EFABCE.7000503@gmx.de>
References: <40EEC9CD.8030003@gmx.de> <1089396942.22528.10.camel@pegasus>
	 <40EF0F10.8050302@gmx.de> <1089413516.13519.16.camel@pegasus>
	 <40EFABCE.7000503@gmx.de>
Content-Type: text/plain
Message-Id: <1089449283.13519.35.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 10 Jul 2004 10:48:03 +0200

Hi Holger,

> > did hid2hci showed any error messages. Is there anything in the logfiles
> > or visible through dmesg. What kind of machine do you use? Do you have
> > the hiddevX devices nodes?
> hid2hci tells this:
>   Switching device 046d:c704 to HCI mode was successful.

this sound good.

> But this immediately results in my keyboard, mouse and MediaPad not 
> working anymore, or rather they get disconnected, I suppose. So I press 
> the connect button on the keyboard and then the one on the hub, just the 
> hub does not react (does not start blinking) and so nothing happens. Ok, 
> so I've got my old PS/2 keyboard and attached this one additionally so I 
> can keep typing. I then tried 'hcitool dev' which now (after hid2hci) 
> shows me the logitech hub as hci0. I then typed 'hcitool scan', it does 
> not complain about missing devices, the hub starts blinking and it 
> finally lists all my diNovo devices. So far, so good. Then I try to 
> manually connect one of my devices (doesn't matter, which) via 'hcitool 
> cc [address]', and the hub again starts blinking, but all I get in 
> result is: 'Can't create connection: Input/Output error'. 'hidd 
> --search' returns a similar error: 'Can't create HID control channel: 
> Invalid exchange'...

Don't use "hcitool cc ...", because this is only for development. What
does "hciconfig -a" show?

Run "hcidump -x" as root while connecting with hidd.

> Interestingly, the HIDP protocol still identifies as mh1, though I 
> meanwhile did supply the mh2 patch. So is this correct, or should I 
> investigate more here?

These are two different version numbers. What "modinfo hidp" shows means
that you use the HIDP version 1.0 with an additional patch for the
report protocol mode. I only put -mh1 after it to identify it, because
the HIDP with boot protocol mode is submitted for kernel inclusion.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
