Return-Path: <massimiliano_cuccia@yahoo.com>
Message-ID: <20040928225548.79491.qmail@web53204.mail.yahoo.com>
Date: Tue, 28 Sep 2004 15:55:48 -0700 (PDT)
From: Massimiliano Cuccia <massimiliano_cuccia@yahoo.com>
Subject: Re: [Bluez-users] compiling bluez/obex (btobex)
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <1096355726.4684.1.camel@notepaq>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-users.lists.sourceforge.net>

> simply call ./bootstrap in the CVS repository. It
> will do the correct
> autoconf/automake work for you and after that you
> can proceed with
> calling configure and so on.

Really, really thanks Marcel
I'm following this way
but I encountered some problems and I need help again

1 - running bootstrap give an error
"bad interpreter: no such file or directory"
So I proceded running the contents of the file itself
(copy-paste in the command line, excluding
"#!/bin/sh").

doing so I run configure, make and make install for
libs, sdp and hcidump without any error message.

compiling the others packages I encountered problems

2 - for pan and for hciemu, running configure I
obtains
"configure: error: cannot run /bin/sh ./config.sub"
3 - for utils, I need yacc ... so I will report later 
4 - for bluefw, doing make I obtain:
"/usr/src/linux/include/linux/usbdevice_fs.h:49
variable or field '__user' declared void"
5 - for obex, during make, the "gcc ... -o btobex ..."
say: "./obex.c: undefined reference to
'OBEX_SetTransportMTU'"

where am I wrong now?


		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 
