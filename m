Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Rainer Dorsch <rdorsch@web.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Setting up an hotplug connection with USB dongles
References: <200411282132.37941.rdorsch@web.de> <200412232343.45609.rdorsch@web.de> <1103889889.20258.82.camel@pegasus>
In-Reply-To: <1103889889.20258.82.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200501021451.09711.rdorsch@web.de>
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
Date: Sun, 2 Jan 2005 14:51:09 +0100

Hi Marcel,

thanks for the immediate reply....but somehow I must miss something:

Am Freitag, 24. Dezember 2004 13:04 schrieb Marcel Holtmann:
> Hi Rainer,
>
> > I used the Debian standard stuff (at least, as far as I am aware of it):
> >
> > rd@topsi:~$ grep bnep0 /etc/network/interfaces
> > iface bnep0 inet dhcp
>
> add a line with "auto bnep0" and it will bring up your interface when it
> is available.

=46rom man interfaces

Stanzas beginning with the word "auto" are used to identify the physical=20
interfaces to be brought up when ifup is run with the -a option.  (This
option  is  used  by  the system boot scripts.)  Physical interface names=20
should follow the word "auto" on the same line.  There can be multiple
"auto" stanzas.  ifup brings the named interfaces up in the order listed.

=46rom the ifup manpage

      -a, --all
              If given to ifup, affect all interfaces marked auto.  Interfa=
ces=20
are brought up in the order in  which  they  are  defined  in  /etc/net-
              work/interfaces.  If given to ifdown, affect all interfaces. =
=20
Interfaces are brought down in the order in which they are currently listed
              in the state file.


>
> > rd@topsi:~$ cat /etc/bluetooth/pan/dev-up
> > #!/bin/sh
> > echo running dev-up
> > ifup bnep0
>
> Don't do it this way. Bad stuff.
>

Are you suggeting to use "ifup -a" instead of "ifup bnep0"? Why would I wan=
t=20
to bring up all interaces again.


Somehow I do not get rid of the impression that I missed something...

Thanks,
Rainer

=2D-=20
Rainer Dorsch
Alzentalstr. 28
D-71083 Herrenberg
07032-919495
Icq: 32550367


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
