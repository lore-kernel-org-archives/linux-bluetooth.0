Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030513153902.0d3016d8@unixmail.qualcomm.com>
Date: Tue, 13 May 2003 16:02:06 -0700
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: RE: [Bluez-devel] Qualification Testing
Cc: Daryl Van Vorst <daryl@wideray.com>, "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1052865099.4608.9.camel@pegasus.local>
References: <5.1.0.14.2.20030513095851.0d257510@unixmail.qualcomm.com>
	<000201c31771$70577930$6400a8c0@baked>
	<5.1.0.14.2.20030513095851.0d257510@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 03:31 PM 5/13/2003, Marcel Holtmann wrote:
>Hi Max,
>
>> Hmm, ok :). But after thinking more about this I think that we probably still need 
>> some way to tell the apps that link became unreliable. I mean parsing syslogs is 
>> not very elegant solution :). Also even though Cetecom accepted it as a solution 
>> other BQBs might not.
>> 
>> Here is what I had in mind. We could add L2CAP socket option L2CAP_RELIABILITY,
>> which will be used by the apps that are "paranoid" :) about link reliability.
>> Then whenever we receive corrupted L2CAP frame we'd check connected sockets, attached
>> to this connection, that have this option enabled and signal error condition on them. 
>> i.e. read/recvmsg will return error. Application can then either clear that error with 
>> getsockopt(SO_ERROR) and continue or close the socket.
>
>the idea itself sounds very good. But I see no advantage in implementing
>such kind of extra functionality. We can not detect if a frame is
>currupt or not, because we have no checksum mechanism. The only thing we
>can detect is a length mismatch. What about a corrupted cid? 
>If you notify the wrong socket and the application on that socket can't deal
>with such an error.
Definition of the L2CAP_RELAIBILITY option is rather broad :). In general it would mean
"Notify me when you can no longer guaranty reliable transmission".
You're right what we don't have checksum. But we can detect failures other than
the wrong length. For example missing start frame or missing continuation frame.
CID we're going to have to ignore because it doesn't necessarily mean that connection
became unreliable.
So there is no such thing as notifying the wrong socket in this case. If L2CAP detects
that connection became unreliable it notifies all sockets on that connection (those 
that explicitly requested notification of course).

Comments ?

Max
