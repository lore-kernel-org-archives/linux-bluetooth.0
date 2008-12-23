Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "Uimonen Jaska (Nokia-D/Helsinki)" <Jaska.Uimonen@nokia.com>
Subject: Re: [RFC/PATCH] sbc: new filtering function for 8 band fixed point encoding
Date: Tue, 23 Dec 2008 13:14:14 +0200
Cc: "ext Marcel Holtmann" <marcel@holtmann.org>,
        "ext Brad Midgley" <bmidgley@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <1227879337.20555.12.camel@esdhcp03999.research.nokia.com> <1229994015.8047.27.camel@californication> <701586182114824C876BD526F939600A0118BEEB@vaebe103.NOE.Nokia.com>
In-Reply-To: <701586182114824C876BD526F939600A0118BEEB@vaebe103.NOE.Nokia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200812231314.14270.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 23 December 2008 10:20:25 Uimonen Jaska (Nokia-D/Helsinki) wrote:
> Hi Guys,
>
> As Siarhei said, we had a talk last week about
> The optimizations to the code.
>
> I added the modifications to the code, which reduce
> The amount of operations quite a lot.

Yes, thank you very much for doing this part of work, I included these
modifications into the last revision of my patch. And of course, your
initial patch to fix the SBC quality issues was invaluable. I hope that you
will not be forgotten to be credited properly when the filtering functions
are complete and committed.

> The problem 
> With this modification is that it also reduces the 
> Readability of the code.

Yes, that's one of the reasons why I'm trying to post different revisions
here, so all the history of modifications can be tracked if somebody is
interested.

> So because of the redundancy in the cosine transform
> it is possible to reduce the number of variables
> and operations in the preceding filtering.
> This is very hard to explain with comments in the code
> (so you would write something like "here should be t[12], but
> The table goes only to 8 because of redundancy in the following
> Cosine transform). To really make the stuff
> Understandable one should write some small
> Wikipage or extensive comments to the code.
>
> So this is the path the previous code also took, but
> At some point there was a mistake. I really don't still
> Get how the anamatrix stuff was calculated, but as
> You see it takes time to reverse engineer :)
>
> But I suggest me and Siarhei clean the code internally
> And try really hard to follow the conventions. It starts
> To get little bit messy, because we both have many
> Versions of the code.

I think that my last revision of patch is more or less complete and needs
only minor tweaks and cosmetic changes. It's not too obfuscated yet, and
the logic still can be seen (hopefully).

I intentionally decided not to include loops unrolling part as it actually
makes code harder to optimize further (for example add SIMD optimizations).
The idea is to have some kind of "reference" implementation, which is
reasonably compact and simple and also configurable for having high
precision mode (very useful for testing purposes).

Implementations, optimized for various platforms can be derived from it:
1. Platforms where multiplications are expensive and you want to avoid as many
of them as possible (reintroduce 'anamatrix' table, have shifts and additions
instead of multiplications, etc)
2. Platforms where the total number of operations is desired to be kept at
minimum (tables need to have unused and duplicate elements removed in
order to reduce the number of operations for loading constants)
3. Platforms where SIMD optimizations are possible (the code and tables should
have a regular structure, suitable for vectorizing, some table elements may
have to be be reordered)

As one can see, these platform specific optimizations have somewhat
contradictory requirements. I tried to arrange the code in such a way, that
any of such further optimizations can be easily introduced based on it.

-- 
Best regards,
Siarhei Siamashka
