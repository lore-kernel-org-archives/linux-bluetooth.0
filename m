Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 May 2012 16:23:33 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/4] Bluetooth: add a timer to L2CAP MSG_MORE code
Message-ID: <20120511192333.GC7620@joana>
References: <1336752974-7747-1-git-send-email-gustavo@padovan.org>
 <1336752974-7747-2-git-send-email-gustavo@padovan.org>
 <1336752974-7747-3-git-send-email-gustavo@padovan.org>
 <1336752974-7747-4-git-send-email-gustavo@padovan.org>
 <alpine.DEB.2.02.1205111131570.17554@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1205111131570.17554@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Mat Martineau <mathewm@codeaurora.org> [2012-05-11 11:38:15 -0700]:

> 
> On Fri, 11 May 2012, Gustavo Padovan wrote:
> 
> >There is now a 200 milliseconds limit for which L2CAP will wait for
> >which L2CAP will wait before send the already queued data to the
> >controller.
> >
> >Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
> 
> A timeout like this makes sense with a streaming protocol, but not
> with a datagram protocol like L2CAP.  The application could be
> waiting on file I/O (especially on a flash filesystem), be waiting
> for another blocking call to return, or another resource-intensive
> application could be hogging the processor for a short time.  If an
> incomplete SDU gets sent out because of a timeout like this, the
> profile on the other side will see it as corrupt.  Better to keep
> the queued data indefinitely.

I don't think this would case problems, before this gets to the profile the
ACL frame needs to be built and it won't be until we get the all pieces of the
L2CAP frame.

I'm following the TCP behaviour with MSG_MORE here.

	Gustavo
