Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v5mcoDbBo_yotfci6o+zak+9OjhTKUm134zj2YGHGVssQ@mail.gmail.com>
References: <1326708715.3360.135.camel@pohly-mobl1.fritz.box>
	<1330903638.3392.141.camel@aeonflux>
	<CAMOw1v5mcoDbBo_yotfci6o+zak+9OjhTKUm134zj2YGHGVssQ@mail.gmail.com>
Date: Thu, 8 Mar 2012 14:22:10 +0100
Message-ID: <CAOcK=CO9au1DnBCw-9bik+nnuOdptNVBpStRVWjdOUaj55xHHg@mail.gmail.com>
Subject: Re: [PATCH] bluetooth.h: fix compile issue when using in C++
From: Markus Rathgeb <maggu2810@googlemail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: Marcel Holtmann <marcel@holtmann.org>, Patrick Ohly <patrick.ohly@intel.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Why can't we get rid off the "typeof" keyword completely and using a
template similar approach:

=3D=3D=3D

#define bt_get_unaligned_tmpl(type, ptr)         \
({                                               \
       struct __p_s  {                           \
               type __v;                         \
       } __attribute__((packed));                \
       struct __p_s *__p =3D (struct __p_s*)(ptr); \
       __p->__v;                                 \
})

static inline uint64_t bt_get_le64(void *ptr)
{
	return bt_get_unaligned_tmpl(uint64_t, ptr);
}

static inline uint64_t bt_get_be64(void *ptr)
{
	return bswap_64(bt_get_unaligned_tmpl(uint64_t, ptr));
}

=3D=3D=3D

Okay, the macro parameter type is not encapsulated by parenthesis, but
it seems okay and working.
So it seems to be a very more portable solution (IMHO).

2012/3/5 Lucas De Marchi <lucas.demarchi@profusion.mobi>:
> On Sun, Mar 4, 2012 at 8:27 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
>> Hi Patrick,
>>
>>> The compiler error is:
>>> =C2=A0/usr/include/bluetooth/bluetooth.h::131:9:=E2=80=82error:=E2=80=
=82invalid=E2=80=82conversion from=E2=80=82'void*'=E2=80=82to=E2=80=82'bt_g=
et_le64(void*)::<anonymous=E2=80=82struct>*'
>>> =C2=A0...
>>>
>>> The reason is that C++, in contrast to C, does not allow conversion of
>>> void * to anything, and this code gets compiled as C++ when the app is
>>> written in C++. The macro with the assignment itself is older, but only
>>> recent Bluez starts to use it in inline functions, thus triggering the
>>> problem.
>>>
>>> This patch keeps the "struct __attribute__((packed))" magic and merely
>>> changes the typecast so that it works in C and C++. Like the existing
>>> macro this patch relies on support for typeof.
>>
>> so I am applying this patch now, but I still have no idea what kind of
>> stupid C++ compiler you are using. The section of this include is
>> clearly marked as C code:
>>
>> #ifdef __cplusplus
>> extern "C" {
>> #endif
>
> This only tells the compiler that this part has C linkage and not C++
>
>
> Lucas De Marchi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
