Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] can't establish a connection
References: <1091742606.6143.17.camel@localhost> <1091747064.6143.25.camel@localhost> <1091748133.20839.63.camel@pegasus>
In-Reply-To: <1091748133.20839.63.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200408060216.05030.cijoml@volny.cz>
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
Date: Fri, 6 Aug 2004 02:16:04 +0200

add=20

none            /proc/bus/usb   usbdevfs faults                 0       0

into /etc/fstab

then write

mount -a=20

and try again

M.
Dne p=E1 6. srpna 2004 01:22 Marcel Holtmann napsal(a):
> Hi Ben,
>
> > Unfortunately it gives me "Can't init device hci0. Connection timed
> > out(110)" Too bad.
>
> show us the content of the /proc/bus/usb/devices file.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by OSTG. Have you noticed the changes on
> Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
> one more big change to announce. We are now OSTG- Open Source Technology
> Group. Come see the changes on the new OSTG site. www.ostg.com
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
