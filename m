Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: "'Max Krasnyansky'" <maxk@qualcomm.com>, "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000801c31684$627d9f80$1a01010a@baked>
References: <000801c31684$627d9f80$1a01010a@baked>
Content-Type: text/plain
Message-Id: <1052526375.1214.130.camel@pegasus.local>
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
Date: 10 May 2003 02:26:08 +0200

Hi Daryl,

> > I was going to just drop the frame and log an error. The 
> > thing is, if the packet header is corrupted (i.e. wrong 
> > length, etc) we can't really trust its content. I mean if 
> > length is wrong how do we know that CID is right. It means 
> > that we don't really know which channel should be closed 
> > (i.e. which app should be notified).
> 
> Here's Cetecom's response to your comment:
> 
> "Good point ! I agree, in a messed up remote L2CAP stack, CID could be wrong
> as well if length is wrong. But I think it is a good approach to check
> first, if that CID exists and if yes, notify the app about that channel."
> 
> So how about we do this:  As above, if it exists then we close it. If not,
> we log an error.

the proposal from Cetecom makes no sense.

If you have one channel with correct data and you get a wrong packet
which was for another channel, but the CID is corrupt and show now the
value of the correct channel. You will infect a correct working channel
with a false packet.

The main problem is that wrong packets should not arrive at the L2CAP
layer. If they do and we decect them (like a length mismatch), we have
to close down all channels and remove the infected ACL link.

Max, what do you think? This way is a little bit radical, but I think it
is an acceptable way of handling these errors. And with this method we
will pass this test.

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
