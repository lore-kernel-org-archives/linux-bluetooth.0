Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Daryl Van Vorst <daryl@wideray.com>, "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.2.20030513153902.0d3016d8@unixmail.qualcomm.com>
References: <5.1.0.14.2.20030513095851.0d257510@unixmail.qualcomm.com>
	<000201c31771$70577930$6400a8c0@baked>
	<5.1.0.14.2.20030513095851.0d257510@unixmail.qualcomm.com>
	<5.1.0.14.2.20030513153902.0d3016d8@unixmail.qualcomm.com>
Message-Id: <1052867997.4608.23.camel@pegasus.local>
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
Date: 14 May 2003 01:19:50 +0200
Content-Type: text/plain

Hi Max,

> >> Hmm, ok :). But after thinking more about this I think that we probably still need 
> >> some way to tell the apps that link became unreliable. I mean parsing syslogs is 
> >> not very elegant solution :). Also even though Cetecom accepted it as a solution 
> >> other BQBs might not.
> >> 
> >> Here is what I had in mind. We could add L2CAP socket option L2CAP_RELIABILITY,
> >> which will be used by the apps that are "paranoid" :) about link reliability.
> >> Then whenever we receive corrupted L2CAP frame we'd check connected sockets, attached
> >> to this connection, that have this option enabled and signal error condition on them. 
> >> i.e. read/recvmsg will return error. Application can then either clear that error with 
> >> getsockopt(SO_ERROR) and continue or close the socket.
> >
> >the idea itself sounds very good. But I see no advantage in implementing
> >such kind of extra functionality. We can not detect if a frame is
> >currupt or not, because we have no checksum mechanism. The only thing we
> >can detect is a length mismatch. What about a corrupted cid? 
> >If you notify the wrong socket and the application on that socket can't deal
> >with such an error.
> Definition of the L2CAP_RELAIBILITY option is rather broad :). In general it would mean
> "Notify me when you can no longer guaranty reliable transmission".
> You're right what we don't have checksum. But we can detect failures other than
> the wrong length. For example missing start frame or missing continuation frame.
> CID we're going to have to ignore because it doesn't necessarily mean that connection
> became unreliable.
> So there is no such thing as notifying the wrong socket in this case. If L2CAP detects
> that connection became unreliable it notifies all sockets on that connection (those 
> that explicitly requested notification of course).

so if we detect a failure in an ACL packet, we notify all L2CAP
connections on the ACL link that have this option set. This sounds a
little bit better to me. I understand you wrong at the first time and
now I think we should have such extra stuff.

But I don't like the name and your meaning of this options. It sounds
like something that it is not and will never be. For the description of
this option I think it should be something like

	"Notify me when you detect an error in the ACL payload"

And the option name can be L2CAP_CHECKACL. This is not very good, I
know, so any other proposals?

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
