Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331229077.14217.9.camel@aeonflux>
References: <1326708715.3360.135.camel@pohly-mobl1.fritz.box>
	<1330903638.3392.141.camel@aeonflux>
	<CAMOw1v5mcoDbBo_yotfci6o+zak+9OjhTKUm134zj2YGHGVssQ@mail.gmail.com>
	<CAOcK=CO9au1DnBCw-9bik+nnuOdptNVBpStRVWjdOUaj55xHHg@mail.gmail.com>
	<1331229077.14217.9.camel@aeonflux>
Date: Thu, 8 Mar 2012 21:59:43 +0100
Message-ID: <CAOcK=CN5cnv7s7q1eHKXdkGz-+0Pan5iSBeHX_ad0kH6JdeZJg@mail.gmail.com>
Subject: Re: [PATCH] bluetooth.h: fix compile issue when using in C++
From: Markus Rathgeb <maggu2810@googlemail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>, Patrick Ohly <patrick.ohly@intel.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

2012/3/8 Marcel Holtmann <marcel@holtmann.org>:
> Hi Markus,
>
> please do not top post on this mailing list.
>
>> Why can't we get rid off the "typeof" keyword completely and using a
>> template similar approach:
>>
>> =3D=3D=3D
>>
>> #define bt_get_unaligned_tmpl(type, ptr) =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
>> ({ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct __p_s =C2=A0{ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type __v; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0} __attribute__((packed)); =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct __p_s *__p =3D (struct __p_s*)(ptr); \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0__p->__v; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 \
>> })
>>
>> static inline uint64_t bt_get_le64(void *ptr)
>> {
>> =C2=A0 =C2=A0 =C2=A0 return bt_get_unaligned_tmpl(uint64_t, ptr);
>> }
>>
>> static inline uint64_t bt_get_be64(void *ptr)
>> {
>> =C2=A0 =C2=A0 =C2=A0 return bswap_64(bt_get_unaligned_tmpl(uint64_t, ptr=
));
>> }
>>
>> =3D=3D=3D
>>
>> Okay, the macro parameter type is not encapsulated by parenthesis, but
>> it seems okay and working.
>> So it seems to be a very more portable solution (IMHO).
>
> what does seems okay and working actually mean? Have you actually
> verified on platform that require correct unaligned access to data?
>
> Regards
>
> Marcel
>
>

Hi!

Sorry for the top posting. I have forgotten, to not do that.

I could check that on an ARM architecture, that needs correct
unaligned access handling.

What did I mean with "seems okay"?
You could write code and test it if it is correct, if it fails, it is
not correct, if it not fails, it could be correct.
Or you can write code, think about what the code is doing, and say,
this should be correct.
Sorry, this should not be arrogant, just explain, that I see no
different in the code (if I compare both).

I will write a test suite after the weekend.
But perhaps another one could have a look at.
