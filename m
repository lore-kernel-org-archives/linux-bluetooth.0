Return-Path: <SRS0+1e64d80a8a8dcd07f28e+518+infradead.org+dwmw2@canuck.srs.infradead.org>
Subject: Re: [Bluez-devel] Alignment issue
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Daryl Van Vorst <daryl@wideray.com>,
   "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1106491241.9269.10.camel@pegasus>
References: <001301c47f09$3900e650$1301010a@baked>
	 <1092208405.4564.227.camel@pegasus>
	 <1106231454.26551.582.camel@hades.cambridge.redhat.com>
	 <1106232343.8190.187.camel@pegasus>
	 <1106233175.26551.597.camel@hades.cambridge.redhat.com>
	 <1106480346.9269.2.camel@pegasus>
	 <1106483393.6480.11.camel@localhost.localdomain>
	 <1106491241.9269.10.camel@pegasus>
Content-Type: text/plain
Date: Sun, 23 Jan 2005 15:11:08 +0000
Message-Id: <1106493068.6480.12.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>

On Sun, 2005-01-23 at 15:40 +0100, Marcel Holtmann wrote:
> patch is now in the CVS and everything seems fine again. Btw what is the
> difference between typeof and __typeof__. The latter one is used by the
> previous macro and you used the other?

There's no difference. It's just like 'inline' and '__inline__'. 

> Fine with me, but then I simply replace it with bt_{get|put}unaligned
> and remove the complete stuff. There is no external user
> sdp_interal.h.

Even better.

-- 
dwmw2
