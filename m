Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <860df5d3-22cc-83b0-9d37-bfd035b81b49@felipetonello.com>
References: <20161226202634.28195-1-eu@felipetonello.com> <CABBYNZJoCOuiL1v8pc4gr4pN-Z-oC8FULG6Tn8PVnWw7tDhSOg@mail.gmail.com>
 <860df5d3-22cc-83b0-9d37-bfd035b81b49@felipetonello.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 2 Jan 2017 13:35:42 +0200
Message-ID: <CABBYNZ+JBoC1E=7x6eGmJApvW-BKpi_mCOHNtkCem0dt3wXB_w@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 0/2] MIDI over BLE implementation
To: Felipe Ferreri Tonello <eu@felipetonello.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        agoode@chromium.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felipe,

On Sun, Jan 1, 2017 at 5:21 PM, Felipe Ferreri Tonello
<eu@felipetonello.com> wrote:
> Hi Luiz,
>
> On 27/12/16 13:03, Luiz Augusto von Dentz wrote:
>> Hi Felipe,
>>
>> On Mon, Dec 26, 2016 at 10:26 PM, Felipe F. Tonello
>> <eu@felipetonello.com> wrote:
>>> This patchset implements the MIDI over BLE spec, more information on patch #1.
>>>
>>> Patch #2 is some unit-tests to make sure the MIDI parser works properly.
>>>
>>> Felipe F. Tonello (2):
>>>   profiles/midi: Added MIDI over BLE profile implementation
>>>   unit/test-midi: Added libmidi use-case tests
>>>
>>>  Makefile.am             |  14 +-
>>>  Makefile.plugins        |   8 +
>>>  configure.ac            |  11 +
>>>  profiles/midi/libmidi.c | 412 +++++++++++++++++++++++++++++++
>>>  profiles/midi/libmidi.h | 150 ++++++++++++
>>>  profiles/midi/midi.c    | 490 +++++++++++++++++++++++++++++++++++++
>>>  unit/test-midi.c        | 628 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>  7 files changed, 1712 insertions(+), 1 deletion(-)
>>>  create mode 100644 profiles/midi/libmidi.c
>>>  create mode 100644 profiles/midi/libmidi.h
>>>  create mode 100644 profiles/midi/midi.c
>>>  create mode 100644 unit/test-midi.c
>>>
>>> --
>>> 2.10.2
>>
>> Looks like there is something not quite rigth:
>>
>> https://paste.fedoraproject.org/513667/48284373/
>>
>
> Weird... What command did you run to get this?

Ive just run make check with --enable-midi.

> --
> Felipe



-- 
Luiz Augusto von Dentz
