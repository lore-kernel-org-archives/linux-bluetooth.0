Return-Path: <cyrus@holtmann.org>
References: <52E3B66B-DC7A-4225-8779-8C1E9B0FC15E@holtmann.org> <1378454956-26605-1-git-send-email-djcb.bulk@gmail.com> <4A735792-B4D7-468A-A61A-488F605AAB30@holtmann.org>
From: Dirk-Jan C. Binnema <djcb.bulk@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] build: use -lrt for clock_gettime on glibc < 2.17
In-reply-to: <4A735792-B4D7-468A-A61A-488F605AAB30@holtmann.org>
Date: Tue, 10 Sep 2013 10:20:32 +0300
Message-ID: <87fvtdp2gv.fsf@djcbsoftware.nl>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>


marcel@holtmann.org writes:

> Hi Dirk-Jan,
>

<snip>

>
> so I fixed this upstream a lot simpler by always checking for
> clock_gettime in -lrt. Can you check if that works for you. On an
> older Debian test box it just works fine for me.

Sure, that works; but that's equivalent to the first patch I made... I
only made the more complicated one after your comment:

,----
| > +AC_SEARCH_LIBS(clock_gettime,rt)
|
| I do [not] like this since this now it links everything with -lrt even if it
| is not needed.
`----

AC_SEARCH_LIBS doesn't add -lrt if it's not needed, so I interpreted
your comment as you not wanting -lrt in parts of the code that don't
need it.

Anyway, good it works now...

Thanks,
Dirk.

-- 
Dirk-Jan C. Binnema                  Helsinki, Finland
e:djcb@djcbsoftware.nl           w:www.djcbsoftware.nl
pgp: D09C E664 897D 7D39 5047 A178 E96A C7A1 017D DA3C
