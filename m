Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050510072005.75813.qmail@web8301.mail.in.yahoo.com>
From: Mayank Batra <mayankbatra@yahoo.co.in>
Subject: Re: [Bluez-devel] Regarding a2recv
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050509005413.3787d2d7.henryk@ploetzli.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 10 May 2005 08:20:05 +0100 (BST)

Henryk,

> I now completely restructured the a2recv code into
> something that more
> closely resembles a socket server application.
> Basically it is now a
> giant endless loop that is blocking in select() on
> the serverfd and
> optionally the cmdfd and streamfd (should they be
> open) and as soon as
> there is data to read or a connection to accept I am
> reading it.

Good job!

> There is also an internal state like that from the
> AVDTP spec and I'm
> treating incoming packets based on that state. This
> will allow any
> sequence of AVDTP_DISCOVER, AVDTP_GET_CAPABILITIES,
> AVDTP_OPEN, etc.
> commands to occur and also makes it possible to have
> the server handle
> more than one connection during its lifetime (only
> one at a time, of
> course).
> The code is currently completely lacking any error
> handling, and simply
> ignores the offending packet (or exits), so that
> should be added. I also
> don't like the structs used for the avdtp signalling
> packets, I think
> there should only be one struct that includes a
> struct avdtp_header and
> a union with all the other optional signalling
> contents. Then there
> would have to be specialised read()/write()
> functions which figure out
> (based on the header) how long the packet actually
> is and automatically
> send/receive that many bytes. However, that would
> also require
> modification of a2play so I thought I'd ask first.
> 
> That would make it easier to send rejection messages
> (which may differ
> from the acceptance message in length) and do proper
> error handling.

Even I tested a2recv with a2play and BlueSoleil.
It was working without much trouble, that is why I
didn't bother much about the error handling part.
What I needed at that time was a quick fix solution to
make an A2DP sink.

> 
> Again, please check that I didn't break your
> devices. I can only test
> with a2play. There might also still be some flaws in
> the state handling
> since this is slightly more complex than the
> original straight linear
> design.

Well, I haven't tested the restructured code yet. But
the one before this one was working fine.
 

Mayank

________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
