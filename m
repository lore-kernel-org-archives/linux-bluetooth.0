Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] android/bluetooth: Make possible to start BlueZ in LE mode only
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAMudyAsrsnsSHkw-Nhz_Q2ooOtxL8ewW1AG+3-2bwp5LpReNZA@mail.gmail.com>
Date: Wed, 23 Apr 2014 01:31:38 -0700
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Szymon Janc <szymon.janc@tieto.com>
Message-Id: <0B821767-F4DC-4966-9D9B-E685D271115E@holtmann.org>
References: <1398204991-5165-1-git-send-email-lukasz.rymanowski@tieto.com> <F332EBA9-C4B5-43C1-B50C-48EB46AEFFC1@holtmann.org> <CAMudyAsrsnsSHkw-Nhz_Q2ooOtxL8ewW1AG+3-2bwp5LpReNZA@mail.gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

>>> This patch adds possibility to start BlueZ only in LE mode only.
>>> 
>>> It is useful for testing purpose, when you want test BlueZ in
>>> peripheral mode against any dual mode device.
>>> ---
>>> android/README          |  3 +++
>>> android/bluetooth.c     |  7 ++++++-
>>> android/hal-bluetooth.c | 15 ++++++++++++++-
>>> android/hal-msg.h       |  1 +
>>> 4 files changed, 24 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/android/README b/android/README
>>> index 6254d34..9b08610 100644
>>> --- a/android/README
>>> +++ b/android/README
>>> @@ -166,6 +166,9 @@ options.
>>> 
>>> Property      Value           Description
>>> -------------------------------------------
>>> +mode         le_only         Enable BlueZ in Low Energy mode only.
>>> +             <none>          Enable BlueZ in default mode - enable br/edr/le
>>> +                             if possible.
>> 
>> we better do “bredr” and “le” here.
> 
>> If left empty it will default to auto detect mode with BR/EDR and LE enabled if available with your kernel and supported by the controller.
>> 
> Yes this is exactly how it works.
> 
>> There might be actually an use case where you have a dual-mode controller, but want to just only use BR/EDR. It will be especially hard to fine BR/EDR only controllers.
>> 
> It's true.
> I started with le_only as I need that now. I left br/edr only case for
> the time somebody will need it as it is  easy to extend.
> If you want it now, I will add it.

lets do it now. 0x00 = default/auto, 0x01 = bredr, 0x02 = le.

Regards

Marcel

