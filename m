Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJLTA8gawvTAU5xG6=_A=2NEDLTPL3_GRALUdUs-aW0DzXgbbQ@mail.gmail.com>
References: <1423599385-36295-1-git-send-email-jamuraa@chromium.org>
	<1423599385-36295-10-git-send-email-jamuraa@chromium.org>
	<CABBYNZJQf3CXJff=UfdTDh6eNU50VWu14BQ=3FTbsXR3jy7RbA@mail.gmail.com>
	<CABBYNZL-+ZTH9XhWA3vShh=3npJy2_Gx5U+UycB3qu_T-ZUrWg@mail.gmail.com>
	<CAJLTA8gawvTAU5xG6=_A=2NEDLTPL3_GRALUdUs-aW0DzXgbbQ@mail.gmail.com>
Date: Thu, 12 Feb 2015 15:38:53 +0200
Message-ID: <CABBYNZ+ccNzOHpAgj+3dCO6uyS_ZgH6GqGi-dh57vT1r+BpMrA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/8] Implement Notification / Indication TS Tests
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Thu, Feb 12, 2015 at 12:20 AM, Michael Janssen <jamuraa@chromium.org> wrote:
> Hi Luiz,
>
> On Wed, Feb 11, 2015 at 5:47 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi,
>>
>> On Wed, Feb 11, 2015 at 3:30 PM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Michael,
>>>
>>> On Tue, Feb 10, 2015 at 10:16 PM, Michael Janssen <jamuraa@chromium.org> wrote:
>>>> Implements the four defined tests around the Notification and Indication
>>>> functionality in the unit tests.  Also includes some fixes to discovery when
>>>> no handles could be found (services with no handles).
>>>>
>>>> Also adds some functionality to the unit testing, to support when there is no
>>>> action required by the client and/or the server in a test, and checks for
>>>> post data transmission.
>>>>
>>>> --
>>>
>>> Applied, thanks.
>>
>> I gather the following number from the latest TS:
>>
>> Group                       Client                          Server
>> Configuration             100% (1 / 1)                100% (1 / 1)
>> Discovery                  75% (6 / 8)                  75% (6 / 8)
>> Read                         57.5% (23 / 40)           47.6% (20 / 42)
>> Write                        0% (0 / 40)                  0% (0 / 40)
>> Notification/Indication 50% (1 / 2)                  50% (1 / 2)
>> Services                    0% (0 / 1)                   0% (0 / 1)
>> Timeouts                   0% (0 / 2)                   0% (0 / 1)
>> Attributes                  0% (0 / 10)                  0% (0 / 10)
>> Total                         29.8% (31 / 104)         26.7% 28 / 105
>>
>> *I did not compute any extra tests we are doing, like small vs large
>> databases, still these numbers are quite low.
>>
>> --
>> Luiz Augusto von Dentz
>
> How do you obtain these numbers?  I would like to fix the tests that
> are not showing up.  All four of the Notification / Indication ones
> for example were just committed, so two are not tracking in this
> report.  I believe the read and Discovery ones are low as well.

Yep, I had not realize the group actually have two different suffixes,
GAN and GAI, anyway that adds just 2 test to the coverage.

> Also, theoretically all the server tests should be run against as many
> of the 4 databases that are specified in the TS.  I was planning on
> only the small and single large to start, and come back to the other
> two large databases later if possible.

That are duplicates, Im not taking into account them here since I want
to know how much the TS we are covering not the total number of tests.


-- 
Luiz Augusto von Dentz
