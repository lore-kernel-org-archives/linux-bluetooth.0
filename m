Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RFCOMM server problem
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.2.20030514093502.0d45fe08@unixmail.qualcomm.com>
References: <5.1.0.14.2.20030514093502.0d45fe08@unixmail.qualcomm.com>
Content-Type: text/plain
Message-Id: <1052950924.4608.68.camel@pegasus.local>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 15 May 2003 00:21:58 +0200

Hi Max,

> >if I set up a RFCOMM server on a 2.4.20-mh7 (plus all new patches) and
> >try to connect from another machine which runs 2.4.20-mh6, the
> >communications stops after the initial SABM for dlci 0. The server
> >didn't send the UA for this dlci. The connection establishment fails
> >because of the timeout. If I don't start the server and try to establish
> >the connection I see the UA for dlci 0. If I change the direction and
> >put the server on the machine with the older kernel all is working fine.
> >
> >Any idea what is going wrong?
> Sounds weird. MSC,RLS,etc changes couldn't affect that. On my machines
> everything works as expected. I'll test again.
> Make sure you recompiled everything in RFCOMM module. We changed dlc struct 
> a bit may be something like rfcomm/sock.c wasn't recompiled and still uses 
> old struct. I can't think of anything else at this point.

I was thinking the same, but after some more testing it gets much more
weird. First the kernels I have used are both clean builds from scratch
and packed up in a Debian package, so it is not a compile problem. I
tested this with two of my machines, that have mostly the same kernel
now:

	Sony C1VE	2.4.20-mh7 (plus bt-2.4)
	Pentium 4	2.4.20-mh7 (plus bt-2.4 except the LM_RELIABLE)

The problem only happens if I want to connect from my C1VE to the P4.
The other direction is working fine. I ran hcidump on both sides and
also on the P4 side I see the SABM package, but the rfcomm.o module is
not reacting. For me it looks like an initial processing of incoming
packets is missing. Did you have any other idea?

Regards

Marcel




-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
