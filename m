Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Ethereal-dev] Re: [Bluez-devel] bluetooth ethereal dissector
From: Marcel Holtmann <marcel@holtmann.org>
To: Guy Harris <guy@alum.mit.edu>
Cc: Paul Ionescu <paul@acorp.ro>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   ethereal-dev@ethereal.com
In-Reply-To: <20031030035431.A18203@quadrajet.sonic.net>
References: <1067379074.2419.24.camel@paul>
	<1067425631.24043.224.camel@pegasus>
	<D4C83C06-0A45-11D8-B1BA-000A958097E4@alum.mit.edu>
	<1067482224.18114.6.camel@pegasus>
	<FBDCA88C-0A86-11D8-B1BA-000A958097E4@alum.mit.edu>
	<1067513580.18114.20.camel@pegasus>
	<20031030035431.A18203@quadrajet.sonic.net>
Content-Type: text/plain
Message-Id: <1067518169.11791.29.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 30 Oct 2003 13:49:23 +0100

Hi Guy,

> > Attached is another patch against CVS, which re-introduces the byte
> > swapping,
> 
> I've checked in a change to replace g_ntohs with GUINT16_FROM_LE and to
> replace g_ntohl with GUINT32_FROM_LE.

works fine now on my x86 machine.

> > I also use the macro _U_ for __attribute((packed))__
> 
> The macro _U_ is defined as __attribute__((unused)), not
> __attribute((packed))__.

I am feeling so stupid :(

> If __attribute((packed))__ is *required* in order to make it work, then
> you need to find some *other* way to make it work - conditionally using
> __attribute((packed))__ or not depending on whether GCC is being used or
> not won't help.  For example, define the structure as an array of bytes,
> or as a sequence of arrays of bytes, and use the "pletoh" macros to
> extract values from them.

It works for me now and until anyone shows us otherwise, lets leave it
out.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
