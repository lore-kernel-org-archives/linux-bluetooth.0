Return-Path: <SRS0+8aa17180e48eb1082b98+354+infradead.org+dwmw2@baythorne.srs.infradead.org>
Subject: RE: [Bluez-devel] Alignment issue
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Daryl Van Vorst <daryl@wideray.com>,
   "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1092252699.4564.238.camel@pegasus>
References: <001201c47fc2$7093e4a0$1301010a@baked>
	 <1092252699.4564.238.camel@pegasus>
Content-Type: text/plain
Message-Id: <1092299689.4622.8.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Date: Thu, 12 Aug 2004 09:34:49 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, 2004-08-11 at 21:31 +0200, Marcel Holtmann wrote:
> this is what the Linux kernel is using and we will notice it if some
> compiler version will optimize it in future. I committed that change to
> CVS.

The Linux kernel isn't the best example to follow when it comes to
relying on undocumented and unguaranteed compiler behaviour. Don't be so
sure the kernel would notice -- we have to fix up alignment trap in the
kernel _anyway_ so the use of get_unaligned() is only an optimisation
there.

I'd be more inclined to play with using char * pointers in the memcpy,
and/or __attribute__((packed)).

-- 
dwmw2
