Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [BUG] unit/test-midi spurious failure
To: Felipe Tonello <eu@felipetonello.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
References: <2992e569-78e1-ea64-52b5-a2df11a6c948@message-id.googlemail.com>
 <dca64414-003d-235e-0cb8-d6b706f00f83@message-id.googlemail.com>
 <CAGrhNMwEi+sHSs2zDVT2PL8HsxEWTthNJSvgO5Qo4+7Paf2OQA@mail.gmail.com>
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
Message-ID: <36c05dca-c388-17dd-77cf-1e5b0a0822a3@message-id.googlemail.com>
Date: Sun, 28 May 2017 22:11:47 +0200
MIME-Version: 1.0
In-Reply-To: <CAGrhNMwEi+sHSs2zDVT2PL8HsxEWTthNJSvgO5Qo4+7Paf2OQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felipe,

Am 28.05.2017 um 19:55 schrieb Felipe Tonello:
> Hi Stefan,
> 
> On Fri, May 26, 2017 at 9:17 AM, Stefan Seyfried
> <stefan.seyfried@googlemail.com> wrote:
>> Hi all,
>>
>> I get spurious failures in unit/test-midi

>> ERROR:unit/test-midi.c:287:compare_events: assertion failed (ev1->data.ext.len == ev2->data.ext.len): (5 == 4)

>> ERROR:unit/test-midi.c:287:compare_events: assertion failed (ev1->data.ext.len == ev2->data.ext.len): (1024 == 1023)
>> Aborted (core dumped)
>> ERROR:unit/test-midi.c:287:compare_events: assertion failed (ev1->data.ext.len == ev2->data.ext.len): (5 == 4)
>> Aborted (core dumped)
>>
>> About one in four runs fails:
>>
>> #!/bin/bash
>> G=0; B=0;
>> for i in `seq 1 1000`; do
>>   if unit/test-midi; then
>>     G=$((G+1)
>>   else
>>     B=$((B+1))
>>   fi
>> done
>> echo "good: $G bad: $B"
>>
>> good: 730 bad: 270
>>
>> I have no idea what this means, if this is an error in the
>> test code or a sign something is wrong with the testing system.
>>
>> It started to happen with bluez-5.45, still happens with git master.
> 
> Does it happen on BlueZ 5.44? If so, then I believe it is a bug in the
> MIDI code.

I have not seen it in BlueZ 5.44, only in 5.45 and master.
But because it is a spurious failure, I might have just been lucky (I
only notice failing builds in the openSUSE Build Service if I actively
look for them, but if some dependencies are rebuilt, then the bluez
package also gets automatically rebuilt and the spurious failure might
"fix" itself)

> Thanks for finding it out.

"make check" is part of the openSUSE RPM packaging process, to find such
things, so I did not have to do any real work to find this :-)

Best regards,

	Stefan
-- 
Stefan Seyfried

"For a successful technology, reality must take precedence over
 public relations, for nature cannot be fooled." -- Richard Feynman
