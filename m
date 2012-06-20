Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Jun 2012 12:41:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: Joao Paulo Rechi Vita <jprvita@openbossa.org>,
	Henrique Dante <hdante@profusion.mobi>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH RFC] gdbus: Rename variables named "signal" (so that it
 can be compiled with -Wshadow)
Message-ID: <20120620094104.GA17914@x220>
References: <1339761848-7472-1-git-send-email-hdante@profusion.mobi>
 <CAJdJm_OrV7Xua91zUcyATHCWtHHAZUsOYJbVL8Vn_194O8_=Hw@mail.gmail.com>
 <CAFAvTnNJp0Q1JAt+HUy4X5mBG_xO+fQgUYoYiy+90uHJNtx9Mw@mail.gmail.com>
 <CAFAvTnNcj8ODBqbKJpZzHmFE0Hy_oVtng9Lc-5Ess353Dv2LuQ@mail.gmail.com>
 <CAAngNMaxPad3h8hXpCg4hN_gunjAjesQTeSv45a34X6+mG5+sw@mail.gmail.com>
 <CAMOw1v7ZfiuMxXhXRo2RcB7-WK21gbfip3hXTuRYy=WCj2iaAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAMOw1v7ZfiuMxXhXRo2RcB7-WK21gbfip3hXTuRYy=WCj2iaAQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Tue, Jun 19, 2012, Lucas De Marchi wrote:
> >>>> Would it be interesting to add this option to acinclude.m4? Or does it
> >>>> generate too much noise?
> >>>
> >>>  It generates few warnings. Depending on the acceptance of this patch,
> >>> I could fix bluez as a whole and add -Wshadow to acinclude.m4.
> >>
> >>  Actually, I had a partial build here. Ignore the previous answer, it
> >> generates a lot of warnings.
> >>
> >
> > If we're not going to enable -Wshadow by default, does it make sense
> > to apply this patch? Who is going to check if no new shadow warnings
> > are being inserted in new commits?
> 
> I'm all for doing the following:
> 
> 1) Fix all the places with shadow variables
> 2) Add -Wshadow to the warning flags
> 
> There are lots of them.

Agreed. This could be one of the targets before releasing BlueZ 5.0.

Johan
