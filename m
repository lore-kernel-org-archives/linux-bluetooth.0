Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] MSDUN failed. Connection timed out(110)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <532f6c3c0512121252r14ebe56bn@mail.gmail.com>
References: <532f6c3c0512121211j3f1fa779r@mail.gmail.com>
	 <1134418604.429.9.camel@blade>
	 <532f6c3c0512121252r14ebe56bn@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1134422155.429.16.camel@blade>
Mime-Version: 1.0
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
Date: Mon, 12 Dec 2005 22:15:55 +0100

Hi,

> > > dun-mda-bt peer file is:
> > >
> > > -------------------
> > > root@pajonk:/etc/ppp/peers # cat /etc/ppp/peers/dun-mda-bt
> > > 115200
> > > local
> > > noipdefault
> > > connect "/etc/ppp/at-cmd.pl -v"
> > > noauth
> > > nodefaultroute
> > > 192.168.1.1:192.168.1.10
> > > ms-dns 192.168.1.1
> > > ------------------
> > >
> > > /etc/ppp/at-cmd.pl is a perl script that "do talking":
> >
> > I don't think that this is needed. The magic is done by the --msdun
> > switch.
> 
> Well....i succesfully made this connection earlier on another distro
> (fedora - now i am on ubuntu) with the same devices, same settings,
> and /etc/ppp/at-cmd.pl was "a must" to connect.
> 
> Looks like this script isn't executed. At least it doesn't appear in
> log file as it should:
> http://wiki.xda-developers.com/index.php?pagename=bluetoothnetworking

the PDA sends AT commands and not the magic CLIENTSERVER string. So you
may wanna try it without the --msdun switch.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
