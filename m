Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <532f6c3c0512121252r14ebe56bn@mail.gmail.com>
From: Beware of the Hare <hujumuju@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] MSDUN failed. Connection timed out(110)
In-Reply-To: <1134418604.429.9.camel@blade>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <532f6c3c0512121211j3f1fa779r@mail.gmail.com>
	 <1134418604.429.9.camel@blade>
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
Date: Mon, 12 Dec 2005 21:52:15 +0100

2005/12/12, Marcel Holtmann <marcel@holtmann.org>:
> Hi,
>
> > I am trying to connect my PocketPC 2003 to the internet via bluetooth.
> >
> > i have all needed modules
> >
> > -------------------
> > rfcomm                 34972  3
> > l2cap                  22404  5 rfcomm
> > hci_usb                13192  2
> > bluetooth              43012  7 rfcomm,l2cap,hci_usb
> > --------------------------------
> >
> > and deamons ( HCID, SDPD, DUND) loaded (i think ;)
>
> what version of bluez-utils is installed?

bluez-utils-2.23
bluez-libs-2.23
bluez-hcidump-1.28

> > dun-mda-bt peer file is:
> >
> > -------------------
> > root@pajonk:/etc/ppp/peers # cat /etc/ppp/peers/dun-mda-bt
> > 115200
> > local
> > noipdefault
> > connect "/etc/ppp/at-cmd.pl -v"
> > noauth
> > nodefaultroute
> > 192.168.1.1:192.168.1.10
> > ms-dns 192.168.1.1
> > ------------------
> >
> > /etc/ppp/at-cmd.pl is a perl script that "do talking":
>
> I don't think that this is needed. The magic is done by the --msdun
> switch.

Well....i succesfully made this connection earlier on another distro
(fedora - now i am on ubuntu) with the same devices, same settings,
and /etc/ppp/at-cmd.pl was "a must" to connect.

Looks like this script isn't executed. At least it doesn't appear in
log file as it should:
http://wiki.xda-developers.com/index.php?pagename=3Dbluetoothnetworking

>
> > DUN profile is registered by /usr/local/bin/sdptool add DUN
> No need for that, because dund will do that for you if not told
> otherwise.

Here are hcidump logs with and without DUN service registered before
connection attempt:

http://grudziadz.org/hcidump_with_DUN_regietered.log
http://grudziadz.org/hcidump_without_DUN_regietered.log

--
Best regards


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
