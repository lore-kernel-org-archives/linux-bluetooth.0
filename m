Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Oct 2009 09:31:18 +0100
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: BlueZ devel list <linux-bluetooth@vger.kernel.org>
Subject: Re: hid2hci rules breaks standard USB dell mouses
Message-ID: <20091028093118.71e8f55c@strolchi.home.s3e.de>
In-Reply-To: <4AE7651C.7010809@dell.com>
References: <4AE18EA3.50701@pardus.org.tr>
	<4AE1E1E8.3080902@dell.com>
	<1256373518.7812.1.camel@localhost.localdomain>
	<4AE7651C.7010809@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 27 Oct 2009 16:24:44 -0500
Mario Limonciello <mario_limonciello@dell.com> wrote:

> Hi Marcel:
> 
> Marcel Holtmann wrote:
> >
> > and please send a patch to fix the ones in BlueZ, too
> I sent a patch to drop it from bluez so it doesn't have to be
> maintained in two places, but it was never responded to.  Here it is
> again taken from my mail archive.

Maybe a compromise for the near future:
* update the rules / tools in bluez to be in sync with udev
* don't install them by default unless "--enable-old-udev" (or
  something like that) is ./configure'd

Reasoning:
* people might want to use new bluez with old udev (I personally would
  avoid updating udev in a running system since it seems to interdepend
  on many things. Updating bluez has been painless for me over the last
  years).

Marcel, Mario, does this sound acceptable? If yes, I am willing to
prepare a patch.

Have fun,

	seife
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out."
