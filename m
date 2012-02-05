Return-Path: <cyrus@holtmann.org>
Message-ID: <1328439363.32199.20.camel@pohly-mobl1.fritz.box>
Subject: Re: bluez 4.97: build failure when used in C++ apps
From: Patrick Ohly <patrick.ohly@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, Milan Crha <mcrha@redhat.com>,
 ying.an.deng@intel.com, ulf.hofemeier@intel.com, ning.w.wang@intel.com,
 Tino Keitel <tino.keitel+syncevolution@tikei.de>, Rohan Garg
 <rohan16garg@gmail.com>
Date: Sun, 05 Feb 2012 11:56:03 +0100
In-Reply-To: <1326708597.3360.133.camel@pohly-mobl1.fritz.box>
References: <1326702341.3360.107.camel@pohly-mobl1.fritz.box>
	 <1326705845.6454.274.camel@aeonflux>
	 <1326708597.3360.133.camel@pohly-mobl1.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2012-01-16 at 11:09 +0100, Patrick Ohly wrote:
> On Mo, 2012-01-16 at 10:24 +0100, Marcel Holtmann wrote:
> > Also this topic
> > has been raised before and I need confirmation for a GCC guru to confirm
> > that this does exactly the same all all platforms.
> 
> Now that you mentioned it I found the previous patch:
> http://article.gmane.org/gmane.linux.bluez.kernel/20276/match=invalid
> +conversion+void+bt_get_le64+anonymous+struct
> 
> Note that my patch is different. It keeps the "struct
> __attribute__((packed))" magic and merely changes the (void *) typecast
> to something that works in C++ and C.

How do we move forward with this? More and more distros are picking up
the broken header file.

In MeeGo and Tizen we applied the patch that I had suggested.

Milan, do you know what Fedora is doing? Tino, what about Debian? Roran,
you had it in Ubuntu Precise Pangolin. Care to file a bug there, if
there isn't one already?

Would it be more acceptable for upstream to put the modified macros into
an ifdef so that they are really only used in C++, keeping the code for
C as it is now?

I'll send such a patch immediately.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.
