Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3DE3D017.2210011B@exodus.net>
From: Maksim Yevmenkin <myevmenk@exodus.net>
MIME-Version: 1.0
To: Max Krasnyansky <maxk@qualcomm.com>
CC: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] BlueZ HCIDump 1.5 has been released
References: <5.1.0.14.2.20021125101006.078e54a0@mail1.qualcomm.com>
	<5.1.0.14.2.20021126085633.07976128@mail1.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 26 Nov 2002 11:48:39 -0800

Hello Max,

[...]

> >or I'm missing something.
> No you're not. HCIDump code does need some audit.

ok :)

> >Also I have a HUGE favor to ask :) Would it be too hard to not
> >use *any* Linux specific stuff? Here I'm talking about things
> >like
> >
> >1) data types: __u8, __u16 etc. Would it be possible to
> >   use standard <sys/types.h>
> Yeah. We converted all headers and stuff but forgot about hcidump.
> btw We use <stdint.h> instead of <sys/types.h> i.e. uint32_t, etc.
>
> >2) Any stuff from <asm/*.h> including "get_unaligned()"
> Sure.
> 
> >3) Man page is very strange. Mdoc macros are used seems to
> >   be Linux (new mdoc?) specific.
> No idea what you're talking about :). Looks perfectly ok to me.

well, how about the following

1) Some macros have wrong capitalization. For example: .SH and .PP
   i think it should be .Sh and .Pp

2) Use of .TH macro with hardwired "Linux System Administration".
   Instead i would suggest to use something like

   .Dd November, 12 2002
   .Dt HCIDUMP 1
   .Os

3) Use of .B macro where .Nm should be used.

4) SYNOPSIS section probably should use .Op Fl opt Ar arg macro.

5) All lists and list items probably should use .Bl, .It and
   .El macros.

6) AUTHORS section probably should use .An Name Aq e-mail macro.
 
7) man page has name hcidump.8 (i.e. section 8) but the page itself
   says its section 1.

> >It would make porting so much easier. Should I made the patches
> >and submit them ?
> Yes, by all means.

ok.

thanks,
max


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
