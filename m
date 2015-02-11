Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJQf3CXJff=UfdTDh6eNU50VWu14BQ=3FTbsXR3jy7RbA@mail.gmail.com>
References: <1423599385-36295-1-git-send-email-jamuraa@chromium.org>
	<1423599385-36295-10-git-send-email-jamuraa@chromium.org>
	<CABBYNZJQf3CXJff=UfdTDh6eNU50VWu14BQ=3FTbsXR3jy7RbA@mail.gmail.com>
Date: Wed, 11 Feb 2015 15:47:14 +0200
Message-ID: <CABBYNZL-+ZTH9XhWA3vShh=3npJy2_Gx5U+UycB3qu_T-ZUrWg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/8] Implement Notification / Indication TS Tests
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Feb 11, 2015 at 3:30 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Michael,
>
> On Tue, Feb 10, 2015 at 10:16 PM, Michael Janssen <jamuraa@chromium.org> wrote:
>> Implements the four defined tests around the Notification and Indication
>> functionality in the unit tests.  Also includes some fixes to discovery when
>> no handles could be found (services with no handles).
>>
>> Also adds some functionality to the unit testing, to support when there is no
>> action required by the client and/or the server in a test, and checks for
>> post data transmission.
>>
>> --
>
> Applied, thanks.

I gather the following number from the latest TS:

Group                       Client                          Server
Configuration             100% (1 / 1)                100% (1 / 1)
Discovery                  75% (6 / 8)                  75% (6 / 8)
Read                         57.5% (23 / 40)           47.6% (20 / 42)
Write                        0% (0 / 40)                  0% (0 / 40)
Notification/Indication 50% (1 / 2)                  50% (1 / 2)
Services                    0% (0 / 1)                   0% (0 / 1)
Timeouts                   0% (0 / 2)                   0% (0 / 1)
Attributes                  0% (0 / 10)                  0% (0 / 10)
Total                         29.8% (31 / 104)         26.7% 28 / 105

*I did not compute any extra tests we are doing, like small vs large
databases, still these numbers are quite low.

-- 
Luiz Augusto von Dentz
