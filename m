Return-Path: <edd@usefulinc.com>
Subject: Re: [Bluez-users] Release of new BlueZ libs and utils
From: Edd Dumbill <edd@usefulinc.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1073398529.2508.92.camel@pegasus>
References: <1071791711.6635.18.camel@pegasus>
	 <1073147533.8729.53.camel@saag>  <1073148476.8729.56.camel@saag>
	 <1073149849.25261.97.camel@pegasus>  <1073154814.8729.66.camel@saag>
	 <1073212685.25261.138.camel@pegasus>  <1073388369.8729.164.camel@saag>
	 <1073392659.2508.43.camel@pegasus>  <1073394683.8730.225.camel@saag>
	 <1073395217.2508.62.camel@pegasus>  <1073397739.8735.243.camel@saag>
	 <1073398529.2508.92.camel@pegasus>
Content-Type: text/plain
Message-Id: <1073399458.8735.268.camel@saag>
Mime-Version: 1.0
Date: Tue, 06 Jan 2004 14:30:58 +0000
List-ID: <bluez-users.lists.sourceforge.net>

On Tue, 2004-01-06 at 14:15, Marcel Holtmann wrote:
> > Maybe the P800's just gone crazy :(  Oh well.
> 
> I don't think so, because if the ACL link is still connected we should
> answer the SABM command. Looks for me like a scheduling bug in our
> implementation. You got this with 2.4.23-mh1 and 2.6.0-mh2, right? I
> think I had some similar problem, but I can't remember where I got it or
> how to reproduce it.

Yes, I had it with both kernels.  (Though my testing with 2.6 is
somewhat limited due to the lockup problem I was getting.)

> BTW is the P800 so stupid that it searches for the SP record, but
> connects back to channel 1. To what channel do you connect on the P800
> to trigger the callback.

Well, no, this all used to work.  It seems odd that it happens to me and
nobody else.  I trigger it by connecting to whichever channel the P800
runs SP on.  At the moment that's channel 2, though it does shift around
sometimes.

Though in this case it does connect back to channel 1 it refuses to do
the PPP dance with it, so I'm unsure what's going on there.  It just
hangs up after a whle.

And now, it has just worked properly for the first time in days!   And
now it seems to be working about 50% of the time.

Thanks for your help, Marcel.

-- Edd
