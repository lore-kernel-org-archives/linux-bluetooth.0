Return-Path: <dwmw2@infradead.org>
Subject: Re: [Bluez-devel] Re: [BUG] BlueTooth socket busted in 2.6.0-test5
From: David Woodhouse <dwmw2@infradead.org>
To: jt@hpl.hp.com
Cc: Marcel Holtmann <marcel@holtmann.org>, Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ mailing list <bluez-devel@lists.sourceforge.net>,
   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030911203249.GA15575@bougret.hpl.hp.com>
References: <20030910225810.GA7712@bougret.hpl.hp.com>
	 <1063237174.28890.6.camel@pegasus>
	 <20030911203249.GA15575@bougret.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1063344094.7869.396.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Date: Fri, 12 Sep 2003 06:21:34 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, 2003-09-11 at 13:32 -0700, Jean Tourrilhes wrote:
> 	My testing was too light :
> ------------------------------------------------------
> kernel BUG at include/linux/module.h:296!
 <...>
> EIP is at bnep_sock_create+0x69/0xb2 [bnep]

Er, if we're actually _running_ code from the bnep module, how can it
have a zero refcount? This bug is elsewhere, surely?

Either that or it affects _all_ users of sk_set_owner() and wants fixing
there.

-- 
dwmw2
