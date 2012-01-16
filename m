Return-Path: <cyrus@holtmann.org>
Message-ID: <1326708597.3360.133.camel@pohly-mobl1.fritz.box>
Subject: Re: bluez 4.97: build failure when used in C++ apps
From: Patrick Ohly <patrick.ohly@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, Milan Crha <mcrha@redhat.com>,
	ying.an.deng@intel.com, ulf.hofemeier@intel.com, ning.w.wang@intel.com
Date: Mon, 16 Jan 2012 11:09:57 +0100
In-Reply-To: <1326705845.6454.274.camel@aeonflux>
References: <1326702341.3360.107.camel@pohly-mobl1.fritz.box>
	 <1326705845.6454.274.camel@aeonflux>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Mo, 2012-01-16 at 10:24 +0100, Marcel Holtmann wrote:
> Hi Patrick,
> 
> > Bluez 4.97 has entered some distros recently (Fedora Core, MeeGo 1.2
> > update), which broke compilation of the C++ code in SyncEvolution
> > using /usr/lib/bluetooth.h.
> > 
> > The compiler error is:
> > /usr/include/bluetooth/bluetooth.h::131:9: error: invalid conversion from 'void*' to 'bt_get_le64(void*)::<anonymous struct>*'
> > ...
> > 
> > The reason is that C++, in contrast to C, does not allow conversion of
> > void * to anything, and this code gets compiled as C++ when the app is
> > written in C++. The macro with the assignment itself is older, but only
> > recent Bluez starts to use it in inline functions, thus triggering the
> > problem.
> > 
> > Attached is a proposed solution. Note that I have only verified that it
> > now compiles in C and C++, I have not actually tested the resulting
> > Bluez, because compilation fails for me on Debian Testing for another
> > reason (libcheck.a linked into shared object, doesn't work because not
> > relocatable).
> 
> please can we get inline patches from git format-patch.

Will do. 

> Also this topic
> has been raised before and I need confirmation for a GCC guru to confirm
> that this does exactly the same all all platforms.

Now that you mentioned it I found the previous patch:
http://article.gmane.org/gmane.linux.bluez.kernel/20276/match=invalid
+conversion+void+bt_get_le64+anonymous+struct

Note that my patch is different. It keeps the "struct
__attribute__((packed))" magic and merely changes the (void *) typecast
to something that works in C++ and C. I was uncomfortable to depend on
"typeof" for that initially, but the macro already uses that for the
struct member.

In the worst case it'll fail to compile with some (hypothetical) version
of gcc which supports typeof for the old case but not the new one. IMHO
that's less problematic than the known failure that we have now - but of
course I am biased. I'd like to keep SyncEvolution working with Bluez
without rewriting it in C++ ;-)

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.
