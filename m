Return-Path: <gregoire.favre@freesurf.ch>
Date: Thu, 8 Apr 2004 17:00:29 +0200
From: Gregoire Favre <Gregoire.Favre@freesurf.ch>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] No more bluez.o in 2.6?
Message-ID: <20040408150029.GA5539@magma.epfl.ch>
References: <20040407172325.GC9593@magma.epfl.ch> <20040407214322.GA14396@magma.epfl.ch> <1081417632.2970.0.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1081417632.2970.0.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>

On Thu, Apr 08, 2004 at 11:47:12AM +0200, Marcel Holtmann wrote:

> Hi Gregoire,

Hello Marcel and others :-)

> > I compiled 2.6.5-mm2 again, with all blutooth in, and now I can see m=
y
> > bluetooth device ;-) I can also scan my Palm device.
> > I try http://www-jcsu.jesus.cam.ac.uk/~ned21/tech/tungsten_linux.html
> > and after dund --listen --persist --msdun call dun
> > I got the following error when I try to connect:
> > dund[3647]: RFCOMM TTY creation failed. Operation not supported(95)
>=20
> this error is because you didn't set CONFIG_BT_RFCOMM_TTY in your kerne=
l
> config.

You're totally right!!!

Now, some kernels recompilation later, I still have a problem which I
don't know how to solve:

dund[3539]: DUN daemon ver 1.1
dund[3554]: New connection from 00:...
pppd[3561]: pppd 2.4.1 started by root, uid 0
pppd[3561]: Using interface ppp0
pppd[3561]: Connect: ppp0 <--> /dev/rfcomm0
pppd[3561]: Cannot determine ethernet address for proxy ARP
pppd[3561]: local  IP address 192.168.1.2
pppd[3561]: remote IP address 172.31.130.67
pppd[3561]: IPCP terminated by peer
pppd[3561]: Hangup (SIGHUP)
pppd[3561]: Modem hangup
pppd[3561]: Connection terminated.
pppd[3561]: Connect time 0.8 minutes.
pppd[3561]: Sent 571 bytes, received 322 bytes.
pppd[3561]: Exit.

And after that, I cannot try to connect anymore...

What I am trying just now:
pilot-xfer -p net:any -i AESLib.prc TuSSH0.69.prc
always following
http://www-jcsu.jesus.cam.ac.uk/~ned21/tech/tungsten_linux.html

Thank you very much,

	Gr=E9goire
_________________________________________________________________________=
_
http://algebra.epfl.ch/greg ICQ:16624071 mailto:Gregoire.Favre@freesurf.c=
h
