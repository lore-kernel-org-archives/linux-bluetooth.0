Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <58223.194.59.120.11.1102589549.squirrel@194.59.120.11>
In-Reply-To: <1102060352.7350.68.camel@pegasus>
References: <36763.194.59.120.11.1101982344.squirrel@thalreit.dyndns.org>
    <1101987478.15615.112.camel@pegasus>
    <48456.194.59.120.11.1102056209.squirrel@194.59.120.11>
    <1102057135.7350.66.camel@pegasus>
    <34315.194.59.120.11.1102057863.squirrel@194.59.120.11>
    <1102060352.7350.68.camel@pegasus>
Subject: Re: [Bluez-users] Thinkpad 560x with pnpbios and bluez
From: "Volker Jahns" <volker@thalreit.de>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 9 Dec 2004 11:52:29 +0100 (CET)

>> >> > is a vanilla 2.4.22-ac working for you?
>> >> Yup. That's OK for the PNP Bios (but will not incorporate the mh
>> >> patches,
>> >> of course )
>> >
>> > is patching the problem or do the kernel not work?
>> The ac and mh patches are conflicting.
>
> where?
OK, here's what I did:
--
tar xvjf linux-2.4.22.tar.bz2
cd linux-2.4.22
zcat ../patch-2.4.22-ac4.gz |patch -p1
--
This is all good, and also leads to working kernel w/ pnpbios support :-)

But then:
--
zcat ../patch-2.4.22-mh7.gz |patch -p1
patching file arch/sparc64/kernel/ioctl32.c
patching file CREDITS
Hunk #2 succeeded at 2655 (offset 6 lines).
patching file Documentation/Configure.help
Hunk #1 succeeded at 14766 (offset 473 lines).
Hunk #2 FAILED at 22494.
Hunk #3 succeeded at 22719 (offset 671 lines).
Hunk #4 succeeded at 22727 (offset 671 lines).
Hunk #5 FAILED at 22741.
Hunk #6 succeeded at 22808 (offset 662 lines).
Hunk #7 succeeded at 22816 (offset 662 lines).
Hunk #8 succeeded at 22853 (offset 662 lines).
Hunk #9 succeeded at 27944 with fuzz 2 (offset 772 lines).
2 out of 9 hunks FAILED -- saving rejects to file
Documentation/Configure.help.rej
patching file Documentation/devices.txt
The next patch would create the file
Documentation/firmware_class/firmware_sample_driver.c,
which already exists!  Assume -R? [n]
Apply anyway? [n]
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file
Documentation/firmware_class/firmware_sample_driver.c.rej
The next patch would create the file
Documentation/firmware_class/hotplug-script,
which already exists!  Assume -R? [n]
Apply anyway? [n]
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file
Documentation/firmware_class/hotplug-script.rej
The next patch would create the file Documentation/firmware_class/README,
which already exists!  Assume -R? [n]
Apply anyway? [n]
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file
Documentation/firmware_class/README.rej
patching file drivers/bluetooth/bfusb.c
patching file drivers/bluetooth/bluecard_cs.c
patching file drivers/bluetooth/bt3c_cs.c
patching file drivers/bluetooth/btuart_cs.c
patching file drivers/bluetooth/Config.in
patching file drivers/bluetooth/dtl1_cs.c
patching file drivers/bluetooth/hci_bcsp.c
patching file drivers/bluetooth/hci_ldisc.c
patching file drivers/bluetooth/hci_uart.h
patching file drivers/bluetooth/hci_usb.c
patching file drivers/bluetooth/hci_usb.h
patching file drivers/bluetooth/Makefile.lib
patching file drivers/input/Config.in
patching file drivers/input/keybdev.c
patching file drivers/input/Makefile
patching file drivers/input/uinput.c
patching file drivers/isdn/avmb1/capidrv.c
patching file drivers/isdn/avmb1/kcapi.c
patching file drivers/usb/hid-core.c
patching file drivers/usb/hiddev.c
The next patch would create the file include/linux/firmware.h,
which already exists!  Assume -R? [n]
Apply anyway? [n]
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file
include/linux/firmware.h.rej
patching file include/linux/hiddev.h
patching file include/linux/input.h
patching file include/linux/uinput.h
patching file include/net/bluetooth/bluetooth.h
patching file include/net/bluetooth/hci_core.h
patching file include/net/bluetooth/hci.h
patching file include/net/bluetooth/l2cap.h
patching file include/net/bluetooth/rfcomm.h
patching file kernel/ksyms.c
Hunk #1 succeeded at 50 (offset 1 line).
Hunk #2 succeeded at 586 (offset 14 lines).
patching file lib/Config.in
Reversed (or previously applied) patch detected!  Assume -R? [n]
Apply anyway? [n]
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file lib/Config.in.rej
The next patch would create the file lib/firmware_class.c,
which already exists!  Assume -R? [n]
Apply anyway? [n]
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file lib/firmware_class.c.rej
patching file lib/Makefile
Reversed (or previously applied) patch detected!  Assume -R? [n]
Apply anyway? [n]
Skipping patch.
2 out of 2 hunks ignored -- saving rejects to file lib/Makefile.rej
patching file MAINTAINERS
patching file Makefile
Hunk #1 FAILED at 1.
1 out of 1 hunk FAILED -- saving rejects to file Makefile.rej
patching file net/bluetooth/af_bluetooth.c
patching file net/bluetooth/bnep/core.c
Hunk #12 FAILED at 472.
Hunk #13 succeeded at 494 (offset -2 lines).
Hunk #14 succeeded at 564 (offset -2 lines).
Hunk #15 succeeded at 585 (offset -2 lines).
1 out of 15 hunks FAILED -- saving rejects to file
net/bluetooth/bnep/core.c.rej
patching file net/bluetooth/bnep/sock.c
patching file net/bluetooth/cmtp/sock.c
patching file net/bluetooth/Config.in
patching file net/bluetooth/hci_conn.c
patching file net/bluetooth/hci_core.c
patching file net/bluetooth/hci_event.c
patching file net/bluetooth/hci_sock.c
patching file net/bluetooth/hidp/Config.in
patching file net/bluetooth/hidp/core.c
patching file net/bluetooth/hidp/hidp.h
patching file net/bluetooth/hidp/Makefile
patching file net/bluetooth/hidp/sock.c
patching file net/bluetooth/l2cap.c
patching file net/bluetooth/Makefile
patching file net/bluetooth/rfcomm/core.c
patching file net/bluetooth/rfcomm/tty.c
--


-- 
Volker Jahns, volker@thalreit.de



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
