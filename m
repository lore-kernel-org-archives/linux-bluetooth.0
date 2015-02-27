Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Feb 2015 14:32:49 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [V4.0] Regression: Support for Bluetooth Adapter dropped.
Message-ID: <20150227123249.GA30608@t440s.lan>
References: <CADDKRnAd4HCS80X+88fMB7C83bf13EKs8=CC9ZPa7amvpsQBPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CADDKRnAd4HCS80X+88fMB7C83bf13EKs8=CC9ZPa7amvpsQBPw@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jörg,

On Fri, Feb 27, 2015, Jörg Otte wrote:
> Bluetooth has ever been working on my Notebook. I successfully
> use Bluetooth mouse and Obex file transfer for years. And with
> Kernel V4.00 the Adapter is no longer recognized.
> 
> It is an Intel 8087:07da.
> 
> The first bad commit is:
> commit d0ac9eb72b6dceae318c15ee82ef2aaee233666d
> Author: Marcel Holtmann <marcel@holtmann.org>
> Date:   Wed Jan 28 19:41:43 2015 -0800
> 
>     Bluetooth: btusb: Ignore unknown Intel devices with generic descriptor
> 
> Can you please revert that commit?

I don't think a revert is necessary. There's already a patch available
that should fix this:

	http://marc.info/?l=linux-bluetooth&m=142464845203372&w=2

It should hopefully be making it to 4.0-rc2 or latest 4.0-rc3 (it's in
davem's networking tree at the moment but not yet in Linus's tree).

Johan
