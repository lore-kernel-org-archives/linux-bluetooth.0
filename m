Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Mysterious problem with l2test on Coldfire 5282
From: Marcel Holtmann <marcel@holtmann.org>
To: Jeff Sutherland <jeffs@fairwayacademy.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200402171126.46462.jeffs@fairwayacademy.org>
References: <200402170924.31121.jeffs@fairwayacademy.org>
	 <1077032602.2665.12.camel@pegasus>
	 <200402171126.46462.jeffs@fairwayacademy.org>
Content-Type: text/plain
Message-Id: <1077042956.2665.85.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 17 Feb 2004 19:35:56 +0100

Hi Jeff,

> > maybe this code in send_mode() is the problem
> >
> > 	*(uint32_t *) buf = htobl(seq++);
> > 	*(uint16_t *)(buf+4) = htobs(data_size);
> >
> > Replace it with
> >
> > 	*(uint32_t *) buf = htobl(seq);
> > 	*(uint16_t *)(buf+4) = htobs(data_size);
> > 	seq++;
> >
> > I am not a uClinux or compiler expert, so this is only guess.
> 
> Oh, Doh!  I'm sure this is it (haven't tried it yet, though) because of the 
> way the byteswap_32() macro expands!  No fair doing increment/decrement ops 
> on variables inside macros :-)

I applied the fix for l2test, rctest and scotest. Should be in CVS now.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
