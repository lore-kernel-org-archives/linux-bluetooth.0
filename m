Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1253272222.18963.4109.camel@localhost.localdomain>
References: <a70b8cd30908280742k6cdcaa2l3a267661fe1da17d@mail.gmail.com>
	 <1253272222.18963.4109.camel@localhost.localdomain>
Date: Fri, 18 Sep 2009 15:31:44 +0200
Message-ID: <a70b8cd30909180631r4546ffc0q66edc6cc8bd010f2@mail.gmail.com>
Subject: Re: [PATCH] PS3Remote unpairing and power-saving
From: "Ruslan N. Marchenko" <rufferson@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

Thanks for finding your time for review.

2009/9/18, Bastien Nocera <hadess@hadess.net>:
> Don't use statics, add those to a ps3 specific struct.

This function is ps3remote_event which supposed to be use for ps3remote only,
also the driver assumes only single ps3remote device per bluez instance.
I just copied semantic from ps3remote_decode function, where also 2
statics are used. Though I can move them all to input structure.
Should I?

> > +     g_timer_start(((struct fake_hid *)fake->priv)->timer);
>
>
> Why do you start the timer unconditionally, instead of just when using
>  the HOME key?
>

Because this statement is to reset event timer, which causes remote to
be disconnected on idle. Each key-press resets the timer
unconditionally. g_timer_start is recommended to use instead of
g_timer_reset since they do the same thing and reset will be
deprecated (I guess).


Regards,

-- 
Looking forward to reading yours.
     Ruslan N. Marchenko
