Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] can't establish a connection
References: <1091742606.6143.17.camel@localhost> <200408060216.05030.cijoml@volny.cz> <1091809290.4570.9.camel@localhost>
In-Reply-To: <1091809290.4570.9.camel@localhost>
Cc: ben4fun <ben_4_fun@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200408061827.43940.cijoml@volny.cz>
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
Date: Fri, 6 Aug 2004 18:27:43 +0200

Then add into your kernel config
CONFIG_USB_DEVICEFS=3Dy
and recompile

And pls, write into mailing list!

M.

Dne p=E1 6. srpna 2004 18:21 jste napsal(a):
> Hi,
>
> > add
> >
> > none            /proc/bus/usb   usbdevfs faults                 0      =
 0
> >
> > into /etc/fstab
> >
> > then write
> > mount -a
>
> It's done.
> After a reboot, I did  "mount -t usbdevfs none /proc/bus/usb" from the
> USB-howto . It confirmed me it was already mounted. But it is strange
> that /proc/bus/usb/device file is still empty.
>
> Then I did "hciconfig hci0 up"
> and I still have "Can't init device hci0. Connection timed out(110)"
>
> But the hciconfig message changed. It is now:
>
> "hci0:   Type: USB
>         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
>         DOWN
>         RX bytes:0 acl:0 sco:0 events:0 errors:0
>         TX bytes:6 acl:0 sco:0 commands:2 errors:0"
>
> No idea why I have so much difficulties with this dongle.
>
> Regards,
>
> Ben


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
