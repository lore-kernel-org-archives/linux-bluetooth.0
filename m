Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: "'Max Krasnyansky'" <maxk@qualcomm.com>, "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
Date: Fri, 9 May 2003 19:33:30 -0700
Message-ID: <000201c3169c$8cd51570$6400a8c0@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1052526375.1214.130.camel@pegasus.local>
List-ID: <bluez-devel.lists.sourceforge.net>



> > So how about we do this:  As above, if it exists then we 
> close it. If 
> > not, we log an error.
> 
> the proposal from Cetecom makes no sense.
> 
> If you have one channel with correct data and you get a wrong 
> packet which was for another channel, but the CID is corrupt 
> and show now the value of the correct channel. You will 
> infect a correct working channel with a false packet.
> 
> The main problem is that wrong packets should not arrive at 
> the L2CAP layer. If they do and we decect them (like a length 
> mismatch), we have to close down all channels and remove the 
> infected ACL link.
> 
> Max, what do you think? This way is a little bit radical, but 
> I think it is an acceptable way of handling these errors. And 
> with this method we will pass this test.

I like it.  If the other end is that screwed up we should get rid of it
completely.

-Daryl.
