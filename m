Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Smartcard replacement security?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050323154630.F2A554A3@arbetsmyra.dyndns.org>
References: <20050323094241.380D34A3@arbetsmyra.dyndns.org>
	 <1111590295.1916.3.camel@pegasus>
	 <20050323154630.F2A554A3@arbetsmyra.dyndns.org>
Content-Type: text/plain
Message-Id: <1111599501.1916.8.camel@pegasus>
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
Date: Wed, 23 Mar 2005 18:38:21 +0100

Hi Ronny,

> > > paired of course. But then, how "unsafe" is this realy? Can someone
> > > else spoof my phone and thus fooling my computer other than using
> > > some kind of brute force? Authentication is made two-ways, right?
> >
> > this depends on how your automatic unlocking is working. If you know
> > the link key and the BD_ADDR you can spoof anything.
> 
> Sure, but I was woundering how hard it is for an intruder to guess the 
> link key. Of course if he sniff the traffic while doing the pairing 
> with PIN he knows my code, but if he misses this pairing, then what is 
> his chanses? The BD_ADDR is of course public (via a nearby scan).
> 
> I haven't read the whole spec but minor parts of it. It says 
> authentication can be made one-way or both-ways. Do BlueZ support both 
> of these ways? Which is the most commonly used?

this all depends on. Unless you don't tell us something more about how
do you plan to realize the unlock thing this talking makes no sense. I
don't understand what you mean by one/two-way authentication. However
the Bluetooth authentication is weak if you don't enable encryption
directly afterwards.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
