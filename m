Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: "'Max Krasnyansky'" <maxk@qualcomm.com>, "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000901c318df$6b11ad00$1a01010a@baked>
References: <000901c318df$6b11ad00$1a01010a@baked>
Content-Type: text/plain
Message-Id: <1052784278.1132.170.camel@pegasus.local>
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
Date: 13 May 2003 02:04:31 +0200

Hi Max,

> > Daryl, so it is now up to you to do your tests with Cetecom 
> > again and see what we pass and what we fail. The RFCOMM layer 
> > should now perform perfect, but the L2CAP config stuff will 
> > still fail. You can use 2.4.18-mh4 and apply these 5 patches 
> > from the bt-2.4 repository to it:
> 
> Great work guys! Thanks!

maybe we have another RFCOMM misbehaviour, which doesn't matter in the
real world, but can confuse the tester.

	< ACL data: handle 0x0029 flags 0x02 dlen 8
	    L2CAP(d): cid 0x45 len 4 [psm 3]
	      RFCOMM(s): DISC: cr 1 dlci 2 pf 1 ilen 0 fcs 0xb8 
	> ACL data: handle 0x0029 flags 0x02 dlen 8
	    L2CAP(d): cid 0x40 len 4 [psm 3]
	      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92 
	< ACL data: handle 0x0029 flags 0x02 dlen 8
	    L2CAP(d): cid 0x45 len 4 [psm 3]
	      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd 
	< ACL data: handle 0x0029 flags 0x02 dlen 12
	    L2CAP(s): Disconn req: dcid 0x0045 scid 0x0040
	> ACL data: handle 0x0029 flags 0x02 dlen 8
	    L2CAP(d): cid 0x40 len 4 [psm 3]
	      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
	> ACL data: handle 0x0029 flags 0x02 dlen 12
	    L2CAP(s): Disconn rsp: dcid 0x0045 scid 0x0040

The dump above is from a disconnect sequence of RFCOMM. We don't wait
for the UA of the DISC on the dlci 0. We send the L2CAP disconnect
request right after the disconnect of the dlci 0. The L2CAP channel
should be closed after receiving the UA or after a timeout.

> I'll hold off on more testing until we've figured out a solution for the
> L2CAP config stuff. More than likely something else will come out the
> woodwork too, but probably not much. A number of tests had to be postponed
> due to the previous failures.

Daryl, this is your decision (and of course your money), but I think it
will be good to see if our patches fixes the problems. New code can
introduce new bugs :)

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
