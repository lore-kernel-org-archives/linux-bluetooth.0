Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAOcK=CN5cnv7s7q1eHKXdkGz-+0Pan5iSBeHX_ad0kH6JdeZJg@mail.gmail.com>
References: <1326708715.3360.135.camel@pohly-mobl1.fritz.box>
	<1330903638.3392.141.camel@aeonflux>
	<CAMOw1v5mcoDbBo_yotfci6o+zak+9OjhTKUm134zj2YGHGVssQ@mail.gmail.com>
	<CAOcK=CO9au1DnBCw-9bik+nnuOdptNVBpStRVWjdOUaj55xHHg@mail.gmail.com>
	<1331229077.14217.9.camel@aeonflux>
	<CAOcK=CN5cnv7s7q1eHKXdkGz-+0Pan5iSBeHX_ad0kH6JdeZJg@mail.gmail.com>
Date: Fri, 9 Mar 2012 11:52:51 +0100
Message-ID: <CAOcK=COwfg0O5R48ObamX6cNDiz00yRHVvt-No62YKyQob8LwA@mail.gmail.com>
Subject: Re: [PATCH] bluetooth.h: fix compile issue when using in C++
From: Markus Rathgeb <maggu2810@googlemail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>, Patrick Ohly <patrick.ohly@intel.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

2012/3/8 Markus Rathgeb <maggu2810@googlemail.com>:
> 2012/3/8 Marcel Holtmann <marcel@holtmann.org>:
>> Hi Markus,
>>
>> please do not top post on this mailing list.
>>
>>> Why can't we get rid off the "typeof" keyword completely and using a
>>> template similar approach:
>>>
>>> =3D=3D=3D
>>>
>>> #define bt_get_unaligned_tmpl(type, ptr) =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
>>> ({ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 \
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct __p_s =C2=A0{ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type __v; =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 \
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0} __attribute__((packed)); =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct __p_s *__p =3D (struct __p_s*)(ptr); =
\
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0__p->__v; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 \
>>> })
>>>
>>> static inline uint64_t bt_get_le64(void *ptr)
>>> {
>>> =C2=A0 =C2=A0 =C2=A0 return bt_get_unaligned_tmpl(uint64_t, ptr);
>>> }
>>>
>>> static inline uint64_t bt_get_be64(void *ptr)
>>> {
>>> =C2=A0 =C2=A0 =C2=A0 return bswap_64(bt_get_unaligned_tmpl(uint64_t, pt=
r));
>>> }
>>>
>>> =3D=3D=3D
>>>
>>> Okay, the macro parameter type is not encapsulated by parenthesis, but
>>> it seems okay and working.
>>> So it seems to be a very more portable solution (IMHO).
>>
>> what does seems okay and working actually mean? Have you actually
>> verified on platform that require correct unaligned access to data?
>>
>> Regards
>>
>> Marcel
>>
>>
>
> Hi!
>
> Sorry for the top posting. I have forgotten, to not do that.
>
> I could check that on an ARM architecture, that needs correct
> unaligned access handling.
>
> What did I mean with "seems okay"?
> You could write code and test it if it is correct, if it fails, it is
> not correct, if it not fails, it could be correct.
> Or you can write code, think about what the code is doing, and say,
> this should be correct.
> Sorry, this should not be arrogant, just explain, that I see no
> different in the code (if I compare both).
>
> I will write a test suite after the weekend.
> But perhaps another one could have a look at.

#include <stdint.h>
#include <stdio.h>

#define DO_UNALIGNED 1

uint64_t bt_get_le64_old(void *ptr)
{
 return (
            {
                struct __attribute__((packed))
                {
                    typeof(*((uint64_t *) ptr)) __v;
                } *__p =3D (void *) ((uint64_t *) ptr);
                __p->__v;
            }
        );
}

uint64_t bt_get_le64_new(void *ptr)
{
 return (
            {
                struct __p_s
                {
                    uint64_t __v;
                } __attribute__((packed));
                struct __p_s *__p =3D (struct __p_s*)(ptr);
                __p->__v;
            }
        );
}


int main(int argc, char* argv[])
{
    int i, j;
    uint8_t data[2 * sizeof(uint64_t)];
    void* ptr;
    uint64_t result_old, result_new;

    for (i =3D 0; i < sizeof(data); ++i)
        data[i] =3D i;

    for (i =3D 0; i < sizeof(data) - sizeof(uint64_t); ++i)
    {
        ptr =3D data + i;

        printf("as is: ");

#if __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
        for (j =3D sizeof(uint64_t) - 1; j >=3D 0; --j)
#else
        for (j =3D 0; j < sizeof(uint64_t); ++j)
#endif
        {
            printf("%02X", *(data + i + j));
        }
        printf("\n");

#if DO_UNALIGNED
        printf("unali: %016llX\n", *((uint64_t*)ptr));
#endif

        result_old =3D bt_get_le64_old(ptr);
        result_new =3D bt_get_le64_new(ptr);
        printf("  old: %016llX\n  new: %016llX\n---\n", result_old, result_=
new);
    }

    return 0;
}

=3D=3D=3D

Running on
Processor       : ARM926EJ-S rev 5 (v5l)

Let's ignore alignment errors:
echo 0 > /proc/cpu/alignment

=3D=3D=3D

# ./unaligned_arm
as is: 0706050403020100
unali: 0706050403020100
  old: 0706050403020100
  new: 0706050403020100
---
as is: 0807060504030201
unali: 0706050403020100
  old: 0807060504030201
  new: 0807060504030201
---
as is: 0908070605040302
unali: 0706050403020100
  old: 0908070605040302
  new: 0908070605040302
---
as is: 0A09080706050403
unali: 0706050403020100
  old: 0A09080706050403
  new: 0A09080706050403
---
as is: 0B0A090807060504
unali: 0B0A090807060504
  old: 0B0A090807060504
  new: 0B0A090807060504
---
as is: 0C0B0A0908070605
unali: 0B0A090807060504
  old: 0C0B0A0908070605
  new: 0C0B0A0908070605
---
as is: 0D0C0B0A09080706
unali: 0B0A090807060504
  old: 0D0C0B0A09080706
  new: 0D0C0B0A09080706
---
as is: 0E0D0C0B0A090807
unali: 0B0A090807060504
  old: 0E0D0C0B0A090807
  new: 0E0D0C0B0A090807
---

=3D=3D=3D

I could also run a loop and break if result_new !=3D result_old...
