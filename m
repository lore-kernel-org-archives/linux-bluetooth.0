Return-Path: <steve.crane@rococosoft.com>
Subject: Re: [Bluez-devel] Alignment issue
From: Stephen Crane <steve.crane@rococosoft.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Daryl Van Vorst <daryl@wideray.com>,
   "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1092179574.4564.216.camel@pegasus>
References: <001301c47f09$3900e650$1301010a@baked>
	 <1092179574.4564.216.camel@pegasus>
Content-Type: text/plain
Message-Id: <1092216034.25087.1122.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Date: Wed, 11 Aug 2004 10:20:34 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Daryl, Marcel,

On Wed, 2004-08-11 at 00:12, Marcel Holtmann wrote:
> Hi Daryl,
> 
> > I ran into an alignment problem on our ARM platform. It showed up as corrupt
> > SDP responses. I traced it back to bt_put_unaligned() in bluetooth.h
> > 
> > The attached patch should fix the problem (it does as far as I can tell).
> > The compiler probably thinks both arguments to memcpy() are aligned and so
> > makes an optimization which breaks the copy (because the destination is not
> > actually aligned). Perhaps this is a compiler bug... I'm using gcc 3.3.3.
> > After googling and reading some discussion on the topic it seems that it's
> > probably not a compiler bug. I'll leave that for someone else to decide. :)
> 
> I am not an expert in this area. I thought that this method of getting
> unaligned support was compatible accross the platforms. Looking at the
> kernel unaligned for ARM shows me that this is actually more different.
> I need verification of that patch with GCC 2.95 and from PowerPC and
> SPARC platforms. I would do it by myself for SPARC, but the harddrive of
> my Sun machine is dead.

Why are these macros even here? ISTR Max having some reason not to use
<asm/unaligned.h> but surely that's what it's there for...

Steve
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)
