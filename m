Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1253281766.18963.4279.camel@localhost.localdomain>
References: <a70b8cd30908280742k6cdcaa2l3a267661fe1da17d@mail.gmail.com>
	 <1253272222.18963.4109.camel@localhost.localdomain>
	 <a70b8cd30909180631r4546ffc0q66edc6cc8bd010f2@mail.gmail.com>
	 <1253281766.18963.4279.camel@localhost.localdomain>
Date: Wed, 23 Sep 2009 20:14:57 +0200
Message-ID: <a70b8cd30909231114x2dcc1a58q442f5be7123a64c6@mail.gmail.com>
Subject: Re: [PATCH] PS3Remote unpairing and power-saving
From: "Ruslan N. Marchenko" <rufferson@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

2009/9/18, Bastien Nocera <hadess@hadess.net>:
>
> Please. And if you manage to make it handle more than one remote in the
>  process, then all the better.
>

That part I've done, however now I'm stuck in power-off button (ps).
Something has changed since v48 and now, when remote is powered off,
and then turned on again, connection is not establishing. Only control
channel is passing (PSM 17) and I never getting PSM 19 connection,
though in hcidump I see it is negotiated. As if interrupt channel is
handled by some other driver. Any hints?

-- 
Looking forward to reading yours.
     Ruslan N. Marchenko
