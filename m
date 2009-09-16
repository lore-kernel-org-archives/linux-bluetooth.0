Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090916181902.52bf7e99@strolchi.home.s3e.de>
References: <20090916181902.52bf7e99@strolchi.home.s3e.de>
Date: Wed, 16 Sep 2009 15:48:11 -0300
Message-ID: <2d5a2c100909161148h7d15ebf2g1fecc84e670480f7@mail.gmail.com>
Subject: Re: BNEP problem, hardware dependent?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc: BlueZ devel list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

On Wed, Sep 16, 2009 at 1:19 PM, Stefan Seyfried
<stefan.seyfried@googlemail.com> wrote:
> Hi,
>
> recently I was changing my work machine. When I wanted to do my usual
> setup (hacked up test-network script) to connect to the internet via my
> mobile phone, I got "bnep error".
>
> It is this piese of code in network/connection.c:
>
> 270 а а а а if (rsp->ctrl != BNEP_SETUP_CONN_RSP)
> 271 а а а а а а а а return TRUE;
> 272
> 273 а а а а r = ntohs(rsp->resp);
> 274
> 275 а а а а if (r != BNEP_SUCCESS) {
> 276 а а а а а а а а error("bnep failed");
> 277 а а а а а а а а goto failed;
> 278 а а а а }

Weird, are you sure that it is failing in one of those checks? It
never happened to me before, you just switch dongle, right?

> I then found out that it did work with some dongles, and it did not
> work with others. Apparently there was no connection to the "quality"
> of the dongles (but I have to admit, that AFAIR all were broadcom or
> worse), there was a very cheap one that did work and more expensive
> ones that didn't.

Make sure you did paired with device before attempting to connect, you
can also mark it as trusted so it does ask for confirmation, if it
still fail could you please send us the hcidump and bluetooth output?

> I always thought that the "supported profiles" list on the packaging
> was just a "what we licensed in the driver" list and that all hardware
> could do everything.
>
> Am I wrong?

Nope, you are correct, the hardware should not affect much the
profiles, of course profiles depending on things like SCO may be
affected by the hardware but that's it. IIRC the only special
requirement for BNEP is that the MTU should be configured to 1691.
(this is easy to check with hcidump)


-- 
Luiz Augusto von Dentz
Engenheiro de Computaчуo
