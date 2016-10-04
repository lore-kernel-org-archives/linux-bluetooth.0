Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABi8O6ZVU5--Kd467Xcg0j-_9noSqXrdhiT=pDcMS3JQcN0eAQ@mail.gmail.com>
References: <CABi8O6YW-wmG8xF5V7vkGJ8_3Wp98-b57L+1jJK_DxWjz=couQ@mail.gmail.com>
 <CABBYNZ++wDB=Hy6YNXo-UU2xiVEazSHGKd60+=1XNk8yTWKcfw@mail.gmail.com> <CABi8O6ZVU5--Kd467Xcg0j-_9noSqXrdhiT=pDcMS3JQcN0eAQ@mail.gmail.com>
From: Ilya Averyanov <averyanovin@gmail.com>
Date: Tue, 4 Oct 2016 17:09:36 +0300
Message-ID: <CABi8O6a+tKHXNqvM43RFuc4TYgpB3tHmaALEtJXXutkZDWS2-w@mail.gmail.com>
Subject: Re: [PATCH SBC] Fix for build on windows mingw
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

What about the patch?

2016-08-04 18:19 GMT+03:00 Ilya Averyanov <averyanovin@gmail.com>:
> Errors occur because mingw int32_t type and other types define only in st=
dint.h
> make --no-print-directory all-am
>   CC       sbc/sbc.lo
> In file included from sbc/sbc.c:40:0:
> sbc/sbc_math.h:42:9: error: unknown type name =E2=80=98int32_t=E2=80=99
>  typedef int32_t sbc_fixed_t;
>          ^
> In file included from sbc/sbc.c:41:0:
> sbc/sbc_tables.h:51:14: error: unknown type name =E2=80=98int32_t=E2=80=
=99
>  static const int32_t sbc_proto_4_40m0[] =3D {
>               ^
> In file included from sbc/sbc.c:40:0:
> sbc/sbc_math.h:31:6: error: =E2=80=98int32_t=E2=80=99 undeclared here (no=
t in a function)
>     ((int32_t)(val)) >> (bits) : ((int32_t) (val)) / (1 << (bits)))
>       ^
> sbc/sbc_tables.h:46:18: note: in expansion of macro =E2=80=98ASR=E2=80=99
>  #define SS4(val) ASR(val, SCALE_SPROTO4_TBL)
>                   ^
> sbc/sbc_tables.h:52:2: note: in expansion of macro =E2=80=98SS4=E2=80=99
>   SS4(0x00000000), SS4(0xffa6982f), SS4(0xfba93848), SS4(0x0456c7b8),
>   ^
> In file included from sbc/sbc.c:41:0:
> sbc/sbc_tables.h:59:22: error: expected =E2=80=98=3D=E2=80=99, =E2=80=98,=
=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or
> =E2=80=98__attribute__=E2=80=99 before =E2=80=98sbc_proto_4_40m1=E2=80=99
>  static const int32_t sbc_proto_4_40m1[] =3D {
>                       ^
> sbc/sbc_tables.h:67:22: error: expected =E2=80=98=3D=E2=80=99, =E2=80=98,=
=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or
> =E2=80=98__attribute__=E2=80=99 before =E2=80=98sbc_proto_8_80m0=E2=80=99
>  static const int32_t sbc_proto_8_80m0[] =3D {
>                       ^
> sbc/sbc_tables.h:80:22: error: expected =E2=80=98=3D=E2=80=99, =E2=80=98,=
=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or
> =E2=80=98__attribute__=E2=80=99 before =E2=80=98sbc_proto_8_80m1=E2=80=99
>  static const int32_t sbc_proto_8_80m1[] =3D {
>                       ^
> sbc/sbc_tables.h:93:22: error: expected =E2=80=98=3D=E2=80=99, =E2=80=98,=
=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or
> =E2=80=98__attribute__=E2=80=99 before =E2=80=98synmatrix4=E2=80=99
>  static const int32_t synmatrix4[8][4] =3D {
>                       ^
> sbc/sbc_tables.h:104:22: error: expected =E2=80=98=3D=E2=80=99, =E2=80=98=
,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or
> =E2=80=98__attribute__=E2=80=99 before =E2=80=98synmatrix8=E2=80=99
>  static const int32_t synmatrix8[16][8] =3D {
>                       ^
> sbc/sbc_tables.h:145:17: error: unknown type name =E2=80=98int16_t=E2=80=
=99
>  #define FIXED_T int16_t /* data type for fixed point constants */
> ....
>
> 2016-08-03 13:21 GMT+03:00 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
>> Hi Ilya,
>>
>> On Tue, Aug 2, 2016 at 6:14 PM, Ilya Averyanov <averyanovin@gmail.com> w=
rote:
>>
>> Please add some description, perhaps with the error caused by the lack
>> of this include.
>>
>>> ---
>>>  sbc/sbc_math.h | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/sbc/sbc_math.h b/sbc/sbc_math.h
>>> index 5476860..25b08ea 100644
>>> --- a/sbc/sbc_math.h
>>> +++ b/sbc/sbc_math.h
>>> @@ -24,6 +24,8 @@
>>>   *
>>>   */
>>>
>>> +#include <stdint.h>
>>> +
>>>  #define fabs(x) ((x) < 0 ? -(x) : (x))
>>>  /* C does not provide an explicit arithmetic shift right but this will
>>>     always be correct and every compiler *should* generate optimal code=
 */
>>> --
>>> 2.7.4
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetoo=
th" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Luiz Augusto von Dentz
