Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Tue, 21 Sep 2010 01:10:39 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, marcel@holtmann.org
Subject: Re: Possible regression with skb_clone() in 2.6.36
Message-ID: <20100921041039.GA8978@vigoh>
References: <1283209824-8795-1-git-send-email-padovan@profusion.mobi>
 <20100917153440.474b93e4.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100917153440.474b93e4.akpm@linux-foundation.org>
List-ID: <linux-bluetooth.vger.kernel.org>

* Andrew Morton <akpm@linux-foundation.org> [2010-09-17 15:34:40 -0700]:

> On Mon, 30 Aug 2010 20:10:23 -0300
> "Gustavo F. Padovan" <padovan@profusion.mobi> wrote:
> 
> > I've been experiencing some problems when running the L2CAP Streaming mode in
> > 2.6.36. The system quickly runs in an Out Of Memory condition and crash. That
> > wasn't happening before, so I think we may have a regression here (I didn't find
> > where yet). The crash log is below.
> 
> So 2.6.35 was OK?
> 
> > The following patch does not fix the regression, but shows that removing the
> > skb_clone() call from l2cap_streaming_send() makes the problem goes away. The
> > patch is good anyway since it saves memory and time when sending Streaming mode
> > packets.
> 
> How does "make it go away" differ from "fix the regression" :)
> 
> But yes, if we don't understand the source of the bug then it may well
> still be there.  Did you make any progress in understanding the cause?

I did some progress and found that this really fix the bug. We are fine
here then. :)

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
