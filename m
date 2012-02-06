Return-Path: <cyrus@holtmann.org>
Message-ID: <1328520596.321.9.camel@pohly-mobl1.fritz.box>
Subject: Re: bluez 4.97: build failure when used in C++ apps
From: Patrick Ohly <patrick.ohly@intel.com>
To: Milan Crha <mcrha@redhat.com>
Cc: Rohan Garg <rohangarg@ubuntu.com>, Marcel Holtmann
 <marcel@holtmann.org>,  linux-bluetooth@vger.kernel.org,
 ying.an.deng@intel.com, ulf.hofemeier@intel.com,  ning.w.wang@intel.com,
 Tino Keitel <tino.keitel+syncevolution@tikei.de>
Date: Mon, 06 Feb 2012 10:29:56 +0100
In-Reply-To: <1328517973.2036.8.camel@localhost>
References: <1326702341.3360.107.camel@pohly-mobl1.fritz.box>
	 <1326705845.6454.274.camel@aeonflux>
	 <1326708597.3360.133.camel@pohly-mobl1.fritz.box>
	 <1328439363.32199.20.camel@pohly-mobl1.fritz.box>
	 <CAEb1ZdjiDFTngKg+zTMHgDQ7hNd6h+VAgbjeNJXQUyF+=d6a9Q@mail.gmail.com>
	 <1328517973.2036.8.camel@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2012-02-06 at 09:46 +0100, Milan Crha wrote:
> On Sun, 2012-02-05 at 16:29 +0530, Rohan Garg wrote:
> > I can file a bug for tracking purposes and get the patched package in
> > the archives, as long as upstream is willing to accept the patch ( or
> > a modified version of the patch ) in the near future. I don't speak
> > for the rest of the Ubuntu developers, but I consider the best
> > approach to getting issues fixed in distros.
> 
> 	Hi,
> I do not package bluez for Fedora, thus I've no idea about it, but we
> found this issue while building on Fedora.

And is it still broken or was bluez patched? I don't remember.

> Rohan, is it a typo or you really meant to say "fixed in distro"? As far
> as I can tell, all the major distros will suffer of the issue, thus why
> should each of them apply patch on their own, when it belongs to
> upstream, from my point of view?

Fixing it upstream certainly would be preferred, but as long as it is
not fixed there, distros need to find a workaround if they want to
continue supporting C++ apps like SyncEvolution.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.
