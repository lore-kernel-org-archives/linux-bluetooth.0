Return-Path: <SRS0+9677ac3b03026936ed9b+262+infradead.org+dwmw2@pentafluge-190310.srs.infradead.org>
Subject: Re: [Bluez-devel] autoconf breaks portability. Film at 11.
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1084382619.25099.81.camel@pegasus>
References: <1084268833.11301.0.camel@hades.cambridge.redhat.com>
	 <1084368666.25099.38.camel@pegasus>
	 <1084369122.4426.106.camel@hades.cambridge.redhat.com>
	 <1084369703.25099.56.camel@pegasus>
	 <1084371089.4426.148.camel@hades.cambridge.redhat.com>
	 <1084382619.25099.81.camel@pegasus>
Content-Type: text/plain
Message-Id: <1084384989.4426.450.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Wed, 12 May 2004 19:03:09 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, 2004-05-12 at 19:23 +0200, Marcel Holtmann wrote:
> Hi David,
> 
> > I sent you proper Makefiles a long time ago. You didn't apply them :)
> 
> must have missed it. Please send it again.

It was October 2002. I don't seem to be able to find my list archives
from then -- it's possible I wasn't subscribed at the time, although
that surprises me.

http://sourceforge.net/mailarchive/message.php?msg_id=2348496
http://sourceforge.net/mailarchive/message.php?msg_id=2360924

ftp://ftp.uk.linux.org/pub/people/dwmw2/random/bluez-makefiles-3.tar.gz

I'd have to update them and there were a couple of missing features
('make DESTDIR=xx install' comes to mind) but I'm more than happy to do
so if you're interested. 

> > configure.in:19: required file `./ltmain.sh' not found
> > compat/Makefile.am: installing `./depcomp'
> 
> but this isn't a problem. It says something like that, but also creates
> every file that it complains about.

hades /hades/bluez/libs2 $ ./configure
-bash2: ./configure: No such file or directory

> Actually I think I have fixed it in both packages. The different between
> them is that the byteswap is done in libs2 and not utils2, while it is
> done in utils and not libs. Please reinstall libs2 from CVS and check
> again.

'cvs up' shows no changes since I tested, in either libs2 or utils2.

Will try again to eliminate user error in the morning. Three hours of
phone conferences just melted my brain...


-- 
dwmw2
