Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ++wDB=Hy6YNXo-UU2xiVEazSHGKd60+=1XNk8yTWKcfw@mail.gmail.com>
References: <CABi8O6YW-wmG8xF5V7vkGJ8_3Wp98-b57L+1jJK_DxWjz=couQ@mail.gmail.com>
 <CABBYNZ++wDB=Hy6YNXo-UU2xiVEazSHGKd60+=1XNk8yTWKcfw@mail.gmail.com>
From: Ilya Averyanov <averyanovin@gmail.com>
Date: Thu, 4 Aug 2016 18:19:08 +0300
Message-ID: <CABi8O6ZVU5--Kd467Xcg0j-_9noSqXrdhiT=pDcMS3JQcN0eAQ@mail.gmail.com>
Subject: Re: [PATCH SBC] Fix for build on windows mingw
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Errors occur because mingw int32_t type and other types define only in stdint.h
make --no-print-directory all-am
  CC       sbc/sbc.lo
In file included from sbc/sbc.c:40:0:
sbc/sbc_math.h:42:9: error: unknown type name ‘int32_t’
 typedef int32_t sbc_fixed_t;
         ^
In file included from sbc/sbc.c:41:0:
sbc/sbc_tables.h:51:14: error: unknown type name ‘int32_t’
 static const int32_t sbc_proto_4_40m0[] = {
              ^
In file included from sbc/sbc.c:40:0:
sbc/sbc_math.h:31:6: error: ‘int32_t’ undeclared here (not in a function)
    ((int32_t)(val)) >> (bits) : ((int32_t) (val)) / (1 << (bits)))
      ^
sbc/sbc_tables.h:46:18: note: in expansion of macro ‘ASR’
 #define SS4(val) ASR(val, SCALE_SPROTO4_TBL)
                  ^
sbc/sbc_tables.h:52:2: note: in expansion of macro ‘SS4’
  SS4(0x00000000), SS4(0xffa6982f), SS4(0xfba93848), SS4(0x0456c7b8),
  ^
In file included from sbc/sbc.c:41:0:
sbc/sbc_tables.h:59:22: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or
‘__attribute__’ before ‘sbc_proto_4_40m1’
 static const int32_t sbc_proto_4_40m1[] = {
                      ^
sbc/sbc_tables.h:67:22: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or
‘__attribute__’ before ‘sbc_proto_8_80m0’
 static const int32_t sbc_proto_8_80m0[] = {
                      ^
sbc/sbc_tables.h:80:22: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or
‘__attribute__’ before ‘sbc_proto_8_80m1’
 static const int32_t sbc_proto_8_80m1[] = {
                      ^
sbc/sbc_tables.h:93:22: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or
‘__attribute__’ before ‘synmatrix4’
 static const int32_t synmatrix4[8][4] = {
                      ^
sbc/sbc_tables.h:104:22: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or
‘__attribute__’ before ‘synmatrix8’
 static const int32_t synmatrix8[16][8] = {
                      ^
sbc/sbc_tables.h:145:17: error: unknown type name ‘int16_t’
 #define FIXED_T int16_t /* data type for fixed point constants */
....

2016-08-03 13:21 GMT+03:00 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
> Hi Ilya,
>
> On Tue, Aug 2, 2016 at 6:14 PM, Ilya Averyanov <averyanovin@gmail.com> wrote:
>
> Please add some description, perhaps with the error caused by the lack
> of this include.
>
>> ---
>>  sbc/sbc_math.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/sbc/sbc_math.h b/sbc/sbc_math.h
>> index 5476860..25b08ea 100644
>> --- a/sbc/sbc_math.h
>> +++ b/sbc/sbc_math.h
>> @@ -24,6 +24,8 @@
>>   *
>>   */
>>
>> +#include <stdint.h>
>> +
>>  #define fabs(x) ((x) < 0 ? -(x) : (x))
>>  /* C does not provide an explicit arithmetic shift right but this will
>>     always be correct and every compiler *should* generate optimal code */
>> --
>> 2.7.4
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz
