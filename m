Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: [Fwd: Re: [Bluez-devel] PAN and bridge problem when bnep0
	disconnects before bnep1]
From: Christoph Scholz <scholz@cs.uni-bonn.de>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-5Le4cAulwalvAGoZ3pUk"
Message-Id: <1084467658.2322.37.camel@willie.informatik.uni-bonn.de>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 13 May 2004 19:00:58 +0200


--=-5Le4cAulwalvAGoZ3pUk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Forgot to also reply to the mailing list.

--=-5Le4cAulwalvAGoZ3pUk
Content-Disposition: inline
Content-Description: Forwarded message - Re: [Bluez-devel] PAN and bridge
	problem when bnep0 disconnects before bnep1
Content-Type: message/rfc822

Subject: Re: [Bluez-devel] PAN and bridge problem when bnep0 disconnects
	before bnep1
From: Christoph Scholz <scholz@cs.uni-bonn.de>
To: Matthias Thomae <bluez@thomae-privat.de>
In-Reply-To: <40A38196.90301@thomae-privat.de>
References: <1084452714.2318.12.camel@willie.informatik.uni-bonn.de>
	 <40A38196.90301@thomae-privat.de>
Content-Type: text/plain
Organization: University of Bonn
Message-Id: <1084461703.2322.27.camel@willie.informatik.uni-bonn.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 13 May 2004 17:21:43 +0200
Content-Transfer-Encoding: 7bit

On Thu, 2004-05-13 at 16:09, Matthias Thomae wrote:
> Hi Christoph,
> 
> Christoph Scholz wrote:
> > I experienced the same problem as Matthias Thomae. I already posted this
> 
> Glad there's others with the same problem ;)
> 
> > to the mailing-list some time ago (see attached mail). It is actually a
> 
> Missed your mail although I searched the archives...
> 
> > problem with the Linux bridge code. It does not seem to be able to cope
> > with multiple interfaces using the same MAC-Address.
> 
> Aha. These MAC addresses seem to be used in the forwarding database. 
> Maybe setting the ageing time to 0 (man brctl) would help...

I don't think so. The problem is that the code assumes that MAC
addresses are unique. Even if there are multiple Bluetooth BNEP devices,
there will only be one entry in the forwarding database. When one of the
devices is removed, this entry in the forwarding database is also
removed.

> 
> > Unfortunately, I have no real solution to the problem.
> 
> What kernel version are you using (on the GN)? I noticed in the 
> changelog for 2.6.6 there were a number of bridge-related changes, e.g.:

I used 2.4.x   with x >=20 (don't know exactly any more)

> 
> <shemminger@osdl.org>
> 	[BRIDGE]: Forwarding database changes.
> 	
> 	Make forwarding database more robust.
> 	  + Don't insert invalid ether address,
> 	  + Report errors back so adding an interface to bridge can fail
> 	  + get rid of unneeded explicit pads in data structure
> 	  + replace bitfields with byte's for simple booleans.
> 
> Maybe that fixes our problem? I might be able to try 2.6.6 and the 
> ageing timer tonight...

I am not sure but I would guess that the problem is still there. The
same warning can be found in br_fdb.c in 2.6.6:

printk(KERN_INFO "%s: attempt to add" " interface with same source add
ress.\n", source->dev->name);

I have not written to to the bridge people. My personal opinion is that
BlueZ should do the forwarding (like Affix does). You can argue about
that of course.

Regards,


Christoph

--=-5Le4cAulwalvAGoZ3pUk--



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
