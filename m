Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Brad Midgley" <bmidgley@gmail.com>
Subject: Re: [RFC/PATCH] sbc: new filtering function for 8 band fixed point encoding
Date: Mon, 15 Dec 2008 14:54:19 +0200
Cc: "Jaska Uimonen" <jaska.uimonen@nokia.com>,
	linux-bluetooth@vger.kernel.org
References: <1227879337.20555.12.camel@esdhcp03999.research.nokia.com> <200812121914.48340.siarhei.siamashka@nokia.com> <d89ddf300812121119o601fe1acs229741960a98835c@mail.gmail.com>
In-Reply-To: <d89ddf300812121119o601fe1acs229741960a98835c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200812151454.19090.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 12 December 2008 21:19:20 ext Brad Midgley wrote:
> Guys
>
> One mistake we made was not keeping track of what functions we were
> applying to the published tables as we worked things to look less and
> less like the pseudocode in the spec. So if you start again from one
> of the tables in the spec, keep a comment like
>
> /* ourtable(x) = (int32)(table1(x) << 16) */

This part can be probably done just by having a macro, something like
#define F_TO_Q15(x) (int16_t)((x>0) ? ((x)*(1<<15)+0.5) : ((x)*(1<<15)-0.5))
And then using plain floating point numbers from the SBC specification in the
table, wrapped into this macro. Though I wonder if it is possible to use such
conditional expression in the static table initializer list with all versions
of gcc/other compilers.

> Which in this case would mean that in ourtable we've shifted the
> original table1 float value left 16 bits and truncated it to an int32.
>
> I also combined tables or split tables to simplify our loop logic or
> eliminate operations; an explanation in a comment would have been
> appropriate.

Yes, any transformations or simplifications should be extensively commented.
So that it will be always possible to reproduce them or verify their
correctness.

Can anybody try to remember/explain what transformations were applied to
the existing fixed point implementation?

-- 
Best regards,
Siarhei Siamashka
