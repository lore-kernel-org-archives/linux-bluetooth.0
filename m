Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <6905BCAA-E12E-4650-8D4B-823B0A63659E@holtmann.org>
References: <20171003122556.18437-1-luiz.dentz@gmail.com> <6905BCAA-E12E-4650-8D4B-823B0A63659E@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 5 Oct 2017 12:34:48 +0300
Message-ID: <CABBYNZJvTBUJ3GSs2KdFtK5uNY8wriq1xQrOW0PiwfzYVxnARQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt: Remove support of ATT over BR/EDR
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 4, 2017 at 10:03 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Luiz,
>
>> ATT over BR/EDR requires bearer specific access types in order to pass
>> tests such as:
>>
>>  4.5.71 TP/GAR/CL/BI-34-C [Read Characteristic Value =E2=80=93 Invalid T=
ransport
>>  Access over BR/EDR]
>>  Verify Generic Attribute Profile client behavior when an attempt to use
>>  BR/EDR transport to execute the Read Characteristic Value procedure on
>>  a characteristic contained within a service defined for use only over
>>  LE transport.
>>
>> On top of that the CCC are considerer bearer specific so for each bearer
>> supported we would have to maintain different storages:
>>
>>  In the case where multiple ATT bearers from the same device are support=
ed
>>  by the GATT server, each ATT bearer shall be considered to have a separ=
ate
>>  GATT client instance. Therefore each GATT client shall have a separate
>>  Client Characteristic Configuration.
>> ---
>> src/gatt-database.c | 120 ----------------------------------------------=
------
>> 1 file changed, 120 deletions(-)
>
> I do not understand this patch. Why would we be removing support for GATT=
 over BR/EDR?

Both the spec and the testing spec, quoted above, impose API
requirements to add bearer detail onto the attributes themselves. In
the other hand, this only affects 4.0 devices which were unable to
connect LE alongside BR/EDR.

--=20
Luiz Augusto von Dentz
