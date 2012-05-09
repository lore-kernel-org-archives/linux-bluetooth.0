Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 May 2012 12:02:07 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	David Herrmann <dh.herrmann@googlemail.com>,
	linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Subject: Re: [PATCH 3/3] Bluetooth: Remove batostr()
Message-ID: <20120509090205.GC7628@aemeltch-MOBL1>
References: <1336483706-1533-1-git-send-email-dh.herrmann@googlemail.com>
 <1336483706-1533-3-git-send-email-dh.herrmann@googlemail.com>
 <CAA37ikZW1H1zfPr8d5uonpY0SEZk=dbDQ+XsYhOytXg4ExuLAA@mail.gmail.com>
 <1336488880.5970.149.camel@aeonflux>
 <CAA37ikaTN=jyf4NfVvLp0SmfPSmCvAodt-DEro+RB=y+g8sFyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAA37ikaTN=jyf4NfVvLp0SmfPSmCvAodt-DEro+RB=y+g8sFyw@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Tue, May 08, 2012 at 03:11:01PM -0300, Ulisses Furquim wrote:
> >> > batostr() is not used anywhere and I don't see any reason why we should
> >> > keep it. Use ba2str() instead.
> >> >
> >> > Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> >> > ---
> >> >  include/net/bluetooth/bluetooth.h |    1 -
> >> >  net/bluetooth/lib.c               |   14 --------------
> >> >  2 files changed, 15 deletions(-)
> >>
> >> The patchset looks good to me. I'm also not sure we need another
> >> specifier for snprintf().
> >>
> >> Given we had static buffers instead of allocating them in the stack
> >> every time it'd be good to hear from Marcel if we had a reason and if
> >> it's still valid. IMO we don't have problems with stack usage in our
> >> code paths now but I haven't actually checked it.
> >
> > that code is most likely 11+ years old. It is actually not from me. So
> > if you wanna know why, you need to track down Max.
> >
> > Using %pM and baswap seems to be the best approach for fixing this right
> > now. However I am not against introducing a snprintf modifier for
> > Bluetooth addresses.
> 
> I see. Ok, makes sense. David or Andrei? Will any of you guys send a patch?

I think that adding print specifier is the best option, we can apply old
patch from Joe Perches.

Best regards 
Andrei Emeltchenko 
