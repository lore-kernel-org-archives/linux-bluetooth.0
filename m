Return-Path: <steve.crane@rococosoft.com>
Subject: RE: [Bluez-devel] Alignment issue
From: Stephen Crane <steve.crane@rococosoft.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Daryl Van Vorst <daryl@wideray.com>,
   "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1092302834.28711.72.camel@pegasus>
References: <001201c47fc2$7093e4a0$1301010a@baked>
	 <1092252699.4564.238.camel@pegasus>
	 <1092299689.4622.8.camel@imladris.demon.co.uk>
	 <1092302834.28711.72.camel@pegasus>
Content-Type: text/plain
Message-Id: <1092305447.24961.1169.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Date: Thu, 12 Aug 2004 11:10:48 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

On Thu, 2004-08-12 at 10:27, Marcel Holtmann wrote:
> Hi David,
> 
> > > this is what the Linux kernel is using and we will notice it if some
> > > compiler version will optimize it in future. I committed that change to
> > > CVS.
> > 
> > The Linux kernel isn't the best example to follow when it comes to
> > relying on undocumented and unguaranteed compiler behaviour. Don't be so
> > sure the kernel would notice -- we have to fix up alignment trap in the
> > kernel _anyway_ so the use of get_unaligned() is only an optimisation
> > there.
> > 
> > I'd be more inclined to play with using char * pointers in the memcpy,
> > and/or __attribute__((packed)).
> 
> I am not an expert when it comes to specific compiler stuff and I can't
> make the best decision with my limited information. What I realized is
> that we need our own unaligned access implementation, because we can't
> rely on the asm/unaligned.h. So I started to put our own in bluetooth.h
> for general access. If this was wrong, please correct me.

I don't think this is wrong, in the absence of a system-supplied one.
This is the basic problem if you ask me: <asm/unaligned.h> _should_ be a
user-space header file (provided by glibc or something) because
unaligned access _is_ something that people who write network programs
need.

Later,
Steve
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)
