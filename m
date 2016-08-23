Return-Path: <szymon.janc@codecoup.pl>
MIME-Version: 1.0
In-Reply-To: <C0C54DF7-FFC1-45EC-B0FB-4823C02F016C@holtmann.org>
References: <1471953334-469-1-git-send-email-michal.narajowski@codecoup.pl> <C0C54DF7-FFC1-45EC-B0FB-4823C02F016C@holtmann.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
Date: Tue, 23 Aug 2016 14:20:52 +0200
Message-ID: <CAAEJBhK_Ttnbypf+T6H52OvN3MYsV6=Ptv3CuC0W5-9Dm9irpg@mail.gmail.com>
Subject: Re: [RFC PATCH] doc/mgmt-api: Add appearance command and event specification
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?UTF-8?Q?Micha=C5=82_Narajowski?= <michal.narajowski@codecoup.pl>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 23 August 2016 at 14:06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Michal,
>
>> ---
>> doc/mgmt-api.txt | 39 +++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 39 insertions(+)
>>
>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>> index 3f593f9..f7e760d 100644
>> --- a/doc/mgmt-api.txt
>> +++ b/doc/mgmt-api.txt
>> @@ -2811,6 +2811,31 @@ Start Limited Discovery Command
>>                               Invalid Index
>>
>>
>> +Set Appearance Command
>> +======================
>> +
>> +     Command Code:           0x0042
>> +     Controller Index:       <controller id>
>> +     Command Parameters:     Appearance (2 Octets)
>> +     Return Parameters:      Appearance (2 Octets)
>> +
>> +     This command is used to set the appearance value of a controller.
>> +
>> +     This command can be used when the controller is not
>> +     powered and all settings will be programmed once powered.
>> +
>> +     The value of appearance will be remembered when switching
>> +     the controller off and back on again. So the appearance only
>> +     have to be set once when a new controller is found and will
>> +     stay until removed.
>> +
>> +     This command generates a Command Complete event on success
>> +     or a Command Status event on failure.
>> +
>> +     Possible errors:        Invalid Parameters
>> +                             Invalid Index
>
> what is this good for?

This is needed to handle appearance flag in "Add Advertising" as well as
being able to generate LE OOB data with it.

-- 
pozdrawiam
Szymon K. Janc
