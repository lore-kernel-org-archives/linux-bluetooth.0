Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Alignment issue
From: Marcel Holtmann <marcel@holtmann.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Daryl Van Vorst <daryl@wideray.com>,
   "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1106231454.26551.582.camel@hades.cambridge.redhat.com>
References: <001301c47f09$3900e650$1301010a@baked>
	 <1092208405.4564.227.camel@pegasus>
	 <1106231454.26551.582.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Message-Id: <1106232343.8190.187.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 20 Jan 2005 15:45:42 +0100

Hi David,

> > > The attached patch should fix the problem (it does as far as I can tell).
> > > The compiler probably thinks both arguments to memcpy() are aligned and so
> > > makes an optimization which breaks the copy (because the destination is not
> > > actually aligned). Perhaps this is a compiler bug... I'm using gcc 3.3.3.
> > > After googling and reading some discussion on the topic it seems that it's
> > > probably not a compiler bug. I'll leave that for someone else to decide. :)
> > 
> > after checking some more resources, you may be right and the compiler
> > optimizes here where it should not. I found a comment about gcc and
> > using its __builtin_memcpy. Try to replace the memcpy with memmove and
> > see if this works.
> 
> That isn't guaranteed to work either. This is the patch I've been
> testing in the Fedora RPM since August. It lets the compiler know what's
> happening so it can generate optimal code.

why using a do-while for put_unaligned() and not for get_unaligned(). Is
this supposed to work with each GCC version? Will it also work with
other compilers? What about performance? If a platform can do unaligned
access by itself it should be faster than compiler tricks.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
