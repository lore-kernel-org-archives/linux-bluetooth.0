Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Fix abuse of kernel headers.
From: David Woodhouse <dwmw2@infradead.org>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <5.1.0.14.2.20030425153625.081db0f0@unixmail.qualcomm.com>
References: <5.1.0.14.2.20030425104103.1040bb30@unixmail.qualcomm.com>
	<5.1.0.14.2.20030425104103.1040bb30@unixmail.qualcomm.com>
	<5.1.0.14.2.20030425153625.081db0f0@unixmail.qualcomm.com>
Content-Type: text/plain
Message-Id: <1051313297.2850.14.camel@imladris.demon.co.uk>
Mime-Version: 1.0
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
Date: Sat, 26 Apr 2003 00:28:17 +0100

On Fri, 2003-04-25 at 23:49, Max Krasnyansky wrote:
> >Take a look at the PPC version.

> Looks ok to me ;-). But I do remember some problem on some arch.
> Which was the reason why I implemented sdp_get_unaligned() instead
> of using <asm/unaligned.h>

It's wrapped in '#ifdef __KERNEL__' on the build box I used. 

> >I looked at that but AFAIK the C standard doesn't actually guarantee the
> > packed structure method will work 

> I don't think packet structures are in the standard. But compiler has to 
> guarantee that. Otherwise we'd have big problems (all hci structures
> are packed).

The people I consulted weren't convinced that the compiler must generate
code which handles the _structure_ being misaligned. Expecting it to
emitting code to correctly read an int which is three bytes from the
beginning of the struct is OK; expecting it to emit code which can
handle misalignment when the member being accessed is at a normal offset
from the start of the structure isn't necessarily safe.
 
> >and since we were always byteswapping
> No we don't. ntohs does nothing on big endian machines.

Sorry, I should have said 'since we were always byteswapping on i386
anyway'. 

Do it that way on ARM and you end up individually loading bytes and
shifting, then you swap them all round afterwards... :)

-- 
dwmw2




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
