Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Alignment issue
From: Marcel Holtmann <marcel@holtmann.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Daryl Van Vorst <daryl@wideray.com>,
   "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1106233175.26551.597.camel@hades.cambridge.redhat.com>
References: <001301c47f09$3900e650$1301010a@baked>
	 <1092208405.4564.227.camel@pegasus>
	 <1106231454.26551.582.camel@hades.cambridge.redhat.com>
	 <1106232343.8190.187.camel@pegasus>
	 <1106233175.26551.597.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Message-Id: <1106480346.9269.2.camel@pegasus>
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
Date: Sun, 23 Jan 2005 12:39:06 +0100

Hi David,

> > why using a do-while for put_unaligned() and not for get_unaligned(). 
> 
> Because get_unaligned() returns a value, and put_unaligned() does not.
> 
> > Is this supposed to work with each GCC version?
> 
> Yes.
> 
> > Will it also work with other compilers? 
> 
> Don't know; don't care. Remember, the existing code isn't guaranteed to
> work even with gcc, let alone other compilers. Does the rest of the
> BlueZ code compile with non-gcc compilers? Probably not... you have 122
> other instances of '__attribute__((packed))' in the source. Including
> the alignment stuff in include/sdp_internal.h which does it the way I'm
> suggesting, albeit with a gratuitous '#ifdef __i386__'.
> 
> > What about performance? If a platform can do unaligned
> > access by itself it should be faster than compiler tricks.
> 
> If the platform can do unaligned access by itself, then GCC knows that
> and emits a direct load/store instruction. It's only if the platform
> _can't_ do it by itself that GCC does anything different. That's why the
> #ifdef __i386__ in include/sdp_internal.h is pointless -- GCC should
> emit the same code even if the other version is used.

your patch results in a lot of "initialization from incompatible pointer
type" errors in the utils and hcidump. Basically in conjunction with
functions like ntohs() etc. How do we fix this?

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
