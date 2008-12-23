Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC/PATCH] sbc: new filtering function for 8 band fixed point encoding
Date: Tue, 23 Dec 2008 10:20:25 +0200
Message-ID: <701586182114824C876BD526F939600A0118BEEB@vaebe103.NOE.Nokia.com>
In-Reply-To: <1229994015.8047.27.camel@californication>
References: <1227879337.20555.12.camel@esdhcp03999.research.nokia.com> <200812170037.48141.siarhei.siamashka@nokia.com> <200812200012.08430.siarhei.siamashka@nokia.com> <200812230130.43968.siarhei.siamashka@nokia.com> <1229994015.8047.27.camel@californication>
From: <Jaska.Uimonen@nokia.com>
To: <marcel@holtmann.org>, <siarhei.siamashka@nokia.com>
Cc: <bmidgley@gmail.com>, <linux-bluetooth@vger.kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Guys,

As Siarhei said, we had a talk last week about=20
The optimizations to the code.=20

I added the modifications to the code, which reduce=20
The amount of operations quite a lot. The problem=20
With this modification is that it also reduces the=20
Readability of the code.=20

So because of the redundancy in the cosine transform=20
it is possible to reduce the number of variables=20
and operations in the preceding filtering.=20
This is very hard to explain with comments in the code=20
(so you would write something like "here should be t[12], but=20
The table goes only to 8 because of redundancy in the following=20
Cosine transform). To really make the stuff=20
Understandable one should write some small=20
Wikipage or extensive comments to the code.=20

So this is the path the previous code also took, but=20
At some point there was a mistake. I really don't still=20
Get how the anamatrix stuff was calculated, but as=20
You see it takes time to reverse engineer :)=20

But I suggest me and Siarhei clean the code internally=20
And try really hard to follow the conventions. It starts=20
To get little bit messy, because we both have many=20
Versions of the code.

Br,
Jaska



>-----Original Message-----
>From: ext Marcel Holtmann [mailto:marcel@holtmann.org]=20
>Sent: 23 December, 2008 03:00
>To: Siamashka Siarhei (Nokia-D/Helsinki)
>Cc: ext Brad Midgley; Uimonen Jaska (Nokia-D/Helsinki);=20
>linux-bluetooth@vger.kernel.org
>Subject: Re: [RFC/PATCH] sbc: new filtering function for 8=20
>band fixed point encoding
>
>Hi Siarhei,
>
>> > We had a talk with Jaska Uimonen here, and now I'm kind of=20
>delegated=20
>> > to finish the work on this filtering function for SBC encoder=20
>> > (including the final addition of ARM assembly optimizations).  He=20
>> > provided me with his last variant of code, which contains=20
>some more=20
>> > optimizations to reduce the number of operations and also loops=20
>> > unrolling. I will add his changes to the patch on next iteration.
>> >
>> > Now the question is how to best integrate a fixed=20
>filtering function=20
>> > to git repository? If I just continue adding changes to=20
>the patch in=20
>> > order to make it a faster, it will be also not so obvious=20
>to see how=20
>> > we got to these code transformations just from the commit log.
>>=20
>> Next iteration done.  Added support for 4 subbands, number of=20
>> arithmetic operations reduced (but without loop unrolling for better=20
>> code readability), precision improved for both 16-bit and=20
>32-bit fixed=20
>> point, 'neginv' macro is now more portable and faster. The=20
>rest is in the code comments.
>
>I don't mind having patches as attachment, but this makes it=20
>hard to review and comment on them. Especially when it comes=20
>to stuff like coding style (since I have no ideas about the rest).
>
>+       t1[0] =3D t1[1] =3D t1[2] =3D t1[3] =3D
>+               (FIXED_A)1 << (SBC_PROTO_FIXED4_SCALE-1);
>
>Should be like this: (FIXED_A) 1 << (SBC_PROTO_FIXED4_SCALE - 1);
>
>Also do you need the (FIXED_A) cast?
>
>+       for (hop =3D 0; hop < 40; hop +=3D 8) {
>+               t1[0] +=3D  (FIXED_A)in[hop] * _sbc_proto_fixed4[hop];
>
>Same here. There has to be a space after every case.
>
>+               t1[i]  =3D (FIXED_A)1 <<=20
>+ (SBC_COS_TABLE_FIXED4_SCALE-1-SCALE_OUT_BITS);
>
>And between every operation there has to be a space: SCALE - 1 - SCALE.
>In this case I would actually put the - 1 at the end, but that=20
>is pure cosmetics and not a coding style violation.
>
>Please fix all of these. There at least 8 or so.
>
>+#define neginv(x) ((-2 >> 1 =3D=3D -1) ? \
>+                ((((int32_t)(x)) >> 31) ^ (int32_t)(x)) : \
>+                ((x >=3D 0) ? (x) : -(x)-1))
>
>Space after cast. Space before and after operator.
>
>+#ifdef SBC_HIGH_PRECISION
>+# define FIXED_A int64_t /* data type for fixed point=20
>accumulator */ #=20
>+define FIXED_T int32_t /* data type for fixed point constants */ #=20
>+define SBC_FIXED8_EXTRA_BITS 16 #else # define FIXED_A=20
>int32_t /* data=20
>+type for fixed point accumulator */ # define FIXED_T int16_t /* data=20
>+type for fixed point constants */ # define SBC_FIXED8_EXTRA_BITS 0=20
>+#endif
>
>No space between # and define. I know that this is meant to=20
>improve readability, but I don't see it.
>
>Regards
>
>Marcel
>
>
>
