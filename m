Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: jungle@saphire.dk
Subject: Re: [Bluez-users] Logitech MX900 mouse not working.
References: <1090765201.983.13.camel@aquarius>
In-Reply-To: <1090765201.983.13.camel@aquarius>
Cc: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200407251632.32162.cijoml@volny.cz>
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
Date: Sun, 25 Jul 2004 16:32:32 +0200

And you should better run hotplug
apt-get install hotplug

Michal

Dne ne 25. =E8ervence 2004 16:20 Kim Pedersen napsal(a):
> Hello,
>
> I just bought a Logitech MX900 set (Mouse, Keyboard and Bluetooth HUB),
> and I am trying very hard to get it working.
>
> At the moment I am able to use the keyboard, due to the PS2 compability
> feature, but I am unable to even use hciscan to obtain a bluetooth
> address on the mouse. The only response I get from the mouse in X is up
> and down movement, laggy and unusable.
>
> I have read the mailing list archive and the Logitech MX900 Bluetooth
> Optical mouse page (http://www.bueche.ch/comp/mx900/mx900.html) and
> followed the instructions, but with no luck. I also tried all the tips
> in the feedback section on that page. Google provided me with some
> resources which I have tried, again with no luck.
>
>
> At the moment I am running a 2.6.7 kernel with the 2.6.8-rc2 patch,
> which was recommended on the Bluez website. I am using Debian Unstable
> and have installed the userland utilies.
>
> I have tried to load all sorts of bluetooth modules and compiling them
> directly into the kernel (shouldnt matter, but you know, you get
> paranoid).
>
> No matter what I do, I cannot get hcitool scan to give me anything but:
>
> Device is not available: Success
>
> hid2hci tells me:
> Switching device 046d:c703 to HCI mode failed (No such file or
> directory)
>
>
> dmesg tells me it has found the USB Bluetooth hub:
>
> usb 3-2: new full speed USB device using address 2
> hub 3-2:1.0: USB hub found
> hub 3-2:1.0: 2 ports detected
> usb 3-2.1: new low speed USB device using address 3
> input: Logitech USB Receiver on usb-0000:00:1d.2-2.1
> input: Logitech USB Receiver on usb-0000:00:1d.2-2.1
>
> Right now, this is the output of lsmod (Keep in mind that I have tried
> ALOT of different combinations of the bluetooth modules):
>
> Module                  Size  Used by
> hci_vhci                6016  0
> hci_uart               15316  0
> bfusb                  11648  0
> firmware_class          8576  1 bfusb
> hci_usb                11136  0
> agpgart                28844  0
> hidp                   12672  0
> ehci_hcd               27524  0
> snd_emu10k1_synth       7936  0
> snd_emux_synth         36352  1 snd_emu10k1_synth
> snd_seq_virmidi         7040  1 snd_emux_synth
> snd_seq_midi_emul       7808  1 snd_emux_synth
> snd_emu10k1            94344  3 snd_emu10k1_synth
> snd_util_mem            4352  2 snd_emux_synth,snd_emu10k1
> snd_hwdep               8224  2 snd_emux_synth,snd_emu10k1
> ipaq                   11156  0
> usbserial              26984  1 ipaq
> nvidia               2077320  12
> usb_storage            59984  0
> loop                   13832  0
> uhci_hcd               30608  0
> ohci_hcd               20100  0
> usbhid                 30272  0
> usbmouse                5376  0
> usbkbd                  7040  0
> usbcore               104420  13
> bfusb,hci_usb,ehci_hcd,ipaq,usbserial,usb_storage,uhci_hcd,ohci_hcd,usbhi=
d,
>usbmouse,usbkbd
>
>
> I hope someone will be able to point me to a step by step instruction
> set, or tell me where I am missing a step here. It is starting to annoy
> me.
>
> Again, I think I have read quite alot of documentation, but I could have
> missed something. If that is the case, just point me to it.
>
> Thanks.
>
> Sincerely,
>
> // Kim Pedersen
>   -- Freedom Matters!
>
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by BEA Weblogic Workshop
> FREE Java Enterprise J2EE developer tools!
> Get your free copy of BEA WebLogic Workshop 8.1 today.
> http://ads.osdn.com/?ad_id=3D4721&alloc_id=3D10040&op=3Dclick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
