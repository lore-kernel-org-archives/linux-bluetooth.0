Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] autoconf breaks portability. Film at 11.
From: Marcel Holtmann <marcel@holtmann.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1084384989.4426.450.camel@hades.cambridge.redhat.com>
References: <1084268833.11301.0.camel@hades.cambridge.redhat.com>
	 <1084368666.25099.38.camel@pegasus>
	 <1084369122.4426.106.camel@hades.cambridge.redhat.com>
	 <1084369703.25099.56.camel@pegasus>
	 <1084371089.4426.148.camel@hades.cambridge.redhat.com>
	 <1084382619.25099.81.camel@pegasus>
	 <1084384989.4426.450.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Message-Id: <1084398405.25099.118.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 12 May 2004 23:46:45 +0200

Hi David,

> It was October 2002. I don't seem to be able to find my list archives
> from then -- it's possible I wasn't subscribed at the time, although
> that surprises me.
> 
> http://sourceforge.net/mailarchive/message.php?msg_id=2348496
> http://sourceforge.net/mailarchive/message.php?msg_id=2360924
> 
> ftp://ftp.uk.linux.org/pub/people/dwmw2/random/bluez-makefiles-3.tar.gz
> 
> I'd have to update them and there were a couple of missing features
> ('make DESTDIR=xx install' comes to mind) but I'm more than happy to do
> so if you're interested. 

I am not interested in this way. I am interested in fixing this the
autoconf/automake way.

> > > configure.in:19: required file `./ltmain.sh' not found
> > > compat/Makefile.am: installing `./depcomp'
> > 
> > but this isn't a problem. It says something like that, but also creates
> > every file that it complains about.
> 
> hades /hades/bluez/libs2 $ ./configure
> -bash2: ./configure: No such file or directory

There must be another problem. Please do a clean CVS checkout.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
