Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Daryl Van Vorst <daryl@wideray.com>, "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1052547309.10456.259.camel@localhost.localdomain>
References: <000801c31684$627d9f80$1a01010a@baked>
	<1052526375.1214.130.camel@pegasus.local>
	<1052547309.10456.259.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1052565910.1288.187.camel@pegasus.local>
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
Date: 10 May 2003 13:25:02 +0200

Hi Max,

> > The main problem is that wrong packets should not arrive at the L2CAP
> > layer. If they do and we decect them (like a length mismatch), we have
> > to close down all channels and remove the infected ACL link.
> The key words is 'should not' here. I've seen it happen because of USB problems
> or UART H4 problems. Not the wrong length but missing fragments and
> stuff.  

and that's so stupid about this test. If you have problems with this, it
is not the fault of the L2CAP layer. You have to look for problems in
the HCI transport layer. Anyway I never had these problems with USB, I
only see them with a out of sync H4 driver.

> > Max, what do you think? This way is a little bit radical, but I think it
> > is an acceptable way of handling these errors. And with this method we
> > will pass this test.
> Yeah, I think it's a bit to aggressive. BNEP connection, for example,
> survives missing frags and pretty much anything else just fine. 
> 
> I'd rather keep the current code. Which I fixed btw to correctly drop
> frame if first fragment is too long. It was a real bug which could cause
> kernel oops in certain conditions.

Please don't understand me wrong. I like the current code, because it
gives us a chance to survice bad packets and didn't blow up the code
with some nasty checks that can't help us in this situation.

Daryl, can you please check with Cetecom what is really needed to pass
this test. From my understanding we do all right, because we notifier
the application (ok, in this case the complete Linux system) with an
error message in the syslog.

How must the testing application react on these errors. Is it enough to
put an error on the screen, or must it close the L2CAP connection. I
think we should write a test application which reads the syslog and
deals with the L2CAP error messages in some way.

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
