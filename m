Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] uinput and modules.conf
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200403161418.11554.cijoml@volny.cz>
References: <200403160905.27291.cijoml@volny.cz>
	 <200403161337.13936.cijoml@volny.cz> <1079442594.3307.73.camel@pegasus>
	 <200403161418.11554.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1079444743.3307.82.camel@pegasus>
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
Date: Tue, 16 Mar 2004 14:45:44 +0100

Hi Michal,

> > > Hmm I have it and module is not autoloaded  :(
> > >
> > > crw-r--r--    1 root     root      10, 223 led 11 23:22 /dev/input/uinput
> >
> > do you use a 2.6 kernel?
> 
> 2.4.25-mh2

I can't explain this. Maybe you have run an extra "depmod -e".

> > So there is a connection and it looks like the HID parser is also
> > working, but no input events are generated. Do you forget to load or
> > compile in some extra modules like keybdev for 2.4.
> 
> I have all of them
> keybdev                 2148   0  (unused)
> uinput                    1996   2
> hostap_cs              45288   0  (unused)
> hostap                 74888   0  [hostap_cs]
> nsc-ircc               10588   1  (autoclean)
> irlan                  23388   0  (unused)
> irtty                   6528   0  (unused)
> ircomm-tty             21760   0  (unused)
> ircomm                  8396   0  [ircomm-tty]
> irda                   98012   0  [nsc-ircc irlan irtty ircomm-tty ircomm]
> ide-cd                 33412   1  (autoclean)
> cdrom                  30912   0  (autoclean) [ide-cd]
> rfcomm                 35360   4  (autoclean)
> l2cap                  18608  13  [rfcomm]
> hci_usb                 8536   1
> bluez                  35844   3  [rfcomm l2cap hci_usb]
> slamr                 246308   2  (autoclean)
> i810_audio             24860   1  (autoclean)
> ac97_codec             13108   0  (autoclean) [i810_audio]
> 8139too                13864   1  (autoclean)
> mii                     2464   0  (autoclean) [8139too]
> nls_iso8859-2           3324   1  (autoclean)
> ntfs                   56096   1  (autoclean)
> mousedev                4372   2  (autoclean)
> hid                    16424   0  (unused)
> input                   3360   0  [keybdev fake mousedev hid]
> rtc                     6856   0  (autoclean)

You started bthid as root, right? The device node for uinput must be
writeable.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
