Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <5.1.0.14.2.20030428143907.10cb0da8@unixmail.qualcomm.com>
To: David Woodhouse <dwmw2@infradead.org>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] [PATCH] Fix abuse of kernel headers.
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1051313297.2850.14.camel@imladris.demon.co.uk>
References: <5.1.0.14.2.20030425153625.081db0f0@unixmail.qualcomm.com>
	<5.1.0.14.2.20030425104103.1040bb30@unixmail.qualcomm.com>
	<5.1.0.14.2.20030425104103.1040bb30@unixmail.qualcomm.com>
	<5.1.0.14.2.20030425153625.081db0f0@unixmail.qualcomm.com>
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
Date: Mon, 28 Apr 2003 14:49:59 -0700
Content-Type: text/plain; CHARSET=us-ascii

At 04:28 PM 4/25/2003, David Woodhouse wrote:
>On Fri, 2003-04-25 at 23:49, Max Krasnyansky wrote:
>> >Take a look at the PPC version.
>
>> Looks ok to me ;-). But I do remember some problem on some arch.
>> Which was the reason why I implemented sdp_get_unaligned() instead
>> of using <asm/unaligned.h>
>
>It's wrapped in '#ifdef __KERNEL__' on the build box I used. 
Yep. That's it. I remember some problem with get_unaligned() but I couldn't remember 
what exactly it was. Thanks for the reminder :)

>> >I looked at that but AFAIK the C standard doesn't actually guarantee the
>> > packed structure method will work 
>
>> I don't think packet structures are in the standard. But compiler has to 
>> guarantee that. Otherwise we'd have big problems (all hci structures
>> are packed).
>
>The people I consulted weren't convinced that the compiler must generate
>code which handles the _structure_ being misaligned. Expecting it to
>emitting code to correctly read an int which is three bytes from the
>beginning of the struct is OK; expecting it to emit code which can
>handle misalignment when the member being accessed is at a normal offset
>from the start of the structure isn't necessarily safe.
Here is what info gcc has to say about that
"`packed'
     The `packed' attribute specifies that a variable or structure field
     should have the smallest possible alignment--one byte for a
     variable, and one bit for a field, unless you specify a larger
     value with the `aligned' attribute.

     Here is a structure in which the field `x' is packed, so that it
     immediately follows `a':

          struct foo
          {
            char a;
            int x[2] __attribute__ ((packed));
          };
"

See. It doesn't matter where the field is, compiler has to generate the 
code that can deal with any alignment.

Max



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
