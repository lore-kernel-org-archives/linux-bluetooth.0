Return-Path: <SRS0+7df27e75be190699ff02+264+infradead.org+dwmw2@baythorne-140453.srs.infradead.org>
Subject: Re: [Fwd: Re: [Bluez-devel] PAN and bridge problem when
	bnep0	disconnects before bnep1]
From: David Woodhouse <dwmw2@infradead.org>
To: Matthias Thomae <bluez@thomae-privat.de>
Cc: Christoph Scholz <scholz@cs.uni-bonn.de>,
   bluez-devel@lists.sourceforge.net, marcel@holtmann.org
In-Reply-To: <40A480B8.2050400@thomae-privat.de>
References: <1084467658.2322.37.camel@willie.informatik.uni-bonn.de>
	 <40A480B8.2050400@thomae-privat.de>
Content-Type: text/plain
Message-Id: <1084539891.6181.68.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Date: Fri, 14 May 2004 14:04:51 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, 2004-05-14 at 10:18 +0200, Matthias Thomae wrote:
> > I have not written to to the bridge people. My personal opinion is that
> > BlueZ should do the forwarding (like Affix does). You can argue about
> > that of course.
> 
> I don't have a competent opinion about that (except: it's not only the 
> forwarding problem, but also DHCP, right?), and don't know what Affix does.

I don't think it makes sense to do the bridging in our BNEP code. We
already _have_ bridging code in the kernel, and there's no sense in
duplicating it. Using the existing code allows us to do things like
bridging directly onto real Ethernet, too.

> Marcel, what do you think? Is there any sense to contact the bridge people?

The mail at http://lists.osdl.org/pipermail/bridge/2004-May/000321.html
to which Diego referred was from the 'bridge people', and says:

"The bridge code was being to picky. The bridge will still work fine
when there are two interfaces with the same local address, because it is
only used for setting the source address on the outgoing bridge
packets."

It seems that we can read 'should still work fine' instead of 'will
still work fine' in the above, given your report -- so yes, you should
report it as a bug in the bridging code if you still can't get it to
work on 2.6.6 + Stephen's patch.

-- 
dwmw2
