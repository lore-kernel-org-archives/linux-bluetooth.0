Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Sep 2009 12:07:55 +0200
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: BlueZ devel list <linux-bluetooth@vger.kernel.org>
Subject: Re: BNEP problem, hardware dependent?
Message-ID: <20090918120755.3ef94e40@strolchi.home.s3e.de>
In-Reply-To: <2d5a2c100909161148h7d15ebf2g1fecc84e670480f7@mail.gmail.com>
References: <20090916181902.52bf7e99@strolchi.home.s3e.de>
	<2d5a2c100909161148h7d15ebf2g1fecc84e670480f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 16 Sep 2009 15:48:11 -0300
Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:

> Hi Stefan,
> 
> On Wed, Sep 16, 2009 at 1:19 PM, Stefan Seyfried
> <stefan.seyfried@googlemail.com> wrote:
> > Hi,
> >
> > recently I was changing my work machine. When I wanted to do my
> > usual setup (hacked up test-network script) to connect to the
> > internet via my mobile phone, I got "bnep error".
> >
> > It is this piese of code in network/connection.c:
> >
> > 270         if (rsp->ctrl != BNEP_SETUP_CONN_RSP)
> > 271                 return TRUE;
> > 272
> > 273         r = ntohs(rsp->resp);
> > 274
> > 275         if (r != BNEP_SUCCESS) {
> > 276                 error("bnep failed");
> > 277                 goto failed;
> > 278         }
> 
> Weird, are you sure that it is failing in one of those checks? It

Yes, it is exactly "bnep failed" and this is the only occurence of this
string in the code ;)

> never happened to me before, you just switch dongle, right?

Yes. The builtin dongle on my new (old ;) machine did not work, so I
started to investigate. I tried various external dongles, some worked,
others didn't. All with the same setup (I'm not 100% sure if I did pair
the phone in advance or if I waited for the bnep-connect to request
pairing, but I am pretty sure that I did it the same with all dongles).
Finally I exchanged the internal module (it's an HP machine, the
modules all have the same form factor, and I found another one which
did work).

> Make sure you did paired with device before attempting to connect, you
> can also mark it as trusted so it does ask for confirmation, if it
> still fail could you please send us the hcidump and bluetooth output?

I'll check if I still have a dongle that fails, and if so, I'll debug
it.

I was just not sure if there was hardware / firmware involved, so
wanted to check that first ;)

> Nope, you are correct, the hardware should not affect much the
> profiles, of course profiles depending on things like SCO may be
> affected by the hardware but that's it. IIRC the only special
> requirement for BNEP is that the MTU should be configured to 1691.
> (this is easy to check with hcidump)

Will do so, too, if I can make it fail again.

Thanks,

	seife
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out."
