Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [RFC/PATCH] sbc: new filtering function for 8 band fixed point encoding
Date: Tue, 23 Dec 2008 12:45:14 +0200
Cc: ext Brad Midgley <bmidgley@gmail.com>,
        Jaska Uimonen <jaska.uimonen@nokia.com>,
        linux-bluetooth@vger.kernel.org
References: <1227879337.20555.12.camel@esdhcp03999.research.nokia.com> <200812230130.43968.siarhei.siamashka@nokia.com> <1229994015.8047.27.camel@californication>
In-Reply-To: <1229994015.8047.27.camel@californication>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200812231245.14493.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 23 December 2008 03:00:15 ext Marcel Holtmann wrote:
> Hi Siarhei,
>
> > > We had a talk with Jaska Uimonen here, and now I'm kind of delegated to
> > > finish the work on this filtering function for SBC encoder (including
> > > the final addition of ARM assembly optimizations).  He provided me with
> > > his last variant of code, which contains some more optimizations to
> > > reduce the number of operations and also loops unrolling. I will add
> > > his changes to the patch on next iteration.
> > >
> > > Now the question is how to best integrate a fixed filtering function to
> > > git repository? If I just continue adding changes to the patch in order
> > > to make it a faster, it will be also not so obvious to see how we got
> > > to these code transformations just from the commit log.
> >
> > Next iteration done.  Added support for 4 subbands, number of arithmetic
> > operations reduced (but without loop unrolling for better code
> > readability), precision improved for both 16-bit and 32-bit fixed point,
> > 'neginv' macro is now more portable and faster. The rest is in the code
> > comments.
>
> I don't mind having patches as attachment, but this makes it hard to
> review and comment on them.

I thought that as long as the attachments are plain text and 'suggest
automatic display' property is set, there should not be much problems
reviewing them.

I'm sorry for my incompetence in this part, but what do you recommend for
posting patches? A link to some guide is sufficient.

Well, it is good to always learn some new things.

> Especially when it comes to stuff like 
> coding style (since I have no ideas about the rest).
>
> +       t1[0] = t1[1] = t1[2] = t1[3] =
> +               (FIXED_A)1 << (SBC_PROTO_FIXED4_SCALE-1);
>
> Should be like this: (FIXED_A) 1 << (SBC_PROTO_FIXED4_SCALE - 1);

Do you have a reference to the coding style standard guide? This particular
requirement for casts and a space seems quite unusual and I have never seen
it before.

> Also do you need the (FIXED_A) cast?

Yes, it's good to have it for better portability. We need to make sure that
this bit is never shifted outside of the range of int type (constants have int
type by default). FIXED_A type can be 64-bit for high precision enabled build.
Even if SBC_FIXED8_EXTRA_BITS constant is currently set so that there is no
overflow, this kind of precaution is better to have in order not to have any
kind of unexpected nasty effect when experimenting with tuning various shift
values.

>
> +       for (hop = 0; hop < 40; hop += 8) {
> +               t1[0] +=  (FIXED_A)in[hop] * _sbc_proto_fixed4[hop];
>
> Same here. There has to be a space after every case.
>
> +               t1[i]  = (FIXED_A)1 <<
> (SBC_COS_TABLE_FIXED4_SCALE-1-SCALE_OUT_BITS);
>
> And between every operation there has to be a space: SCALE - 1 - SCALE.
> In this case I would actually put the - 1 at the end, but that is pure
> cosmetics and not a coding style violation.

This (SBC_COS_TABLE_FIXED4_SCALE-1-SCALE_OUT_BITS) expression can be
interpreted as ((SBC_COS_TABLE_FIXED4_SCALE - 1) - SCALE_OUT_BITS).
Putting -1 at the end is kind of obfuscation.

> Please fix all of these. There at least 8 or so.
>
> +#define neginv(x) ((-2 >> 1 == -1) ? \
> +                ((((int32_t)(x)) >> 31) ^ (int32_t)(x)) : \
> +                ((x >= 0) ? (x) : -(x)-1))
>
> Space after cast. Space before and after operator.
>
> +#ifdef SBC_HIGH_PRECISION
> +# define FIXED_A int64_t /* data type for fixed point accumulator */
> +# define FIXED_T int32_t /* data type for fixed point constants */
> +# define SBC_FIXED8_EXTRA_BITS 16
> +#else
> +# define FIXED_A int32_t /* data type for fixed point accumulator */
> +# define FIXED_T int16_t /* data type for fixed point constants */
> +# define SBC_FIXED8_EXTRA_BITS 0
> +#endif
>
> No space between # and define. I know that this is meant to improve
> readability, but I don't see it.

OK, I'll try to fix these. Getting rid of some spaces was done to try fitting 
some lines into 80 characters (that's also not always achieved yet).

Right now I'm also doublechecking correctness of the code to ensure that there
are no overflows of other problems related to audio quality.

-- 
Best regards,
Siarhei Siamashka
