Return-Path: <cyrus@holtmann.org>
Message-ID: <4D6D04A6.2090300@nokia.com>
Date: Tue, 01 Mar 2011 16:37:26 +0200
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
To: ext Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
Subject: Re: [PATCH 1/2] Move pcsuite drivers to its own plugin
References: <1298749782-24129-1-git-send-email-luiz.dentz@gmail.com>	<1298749782-24129-3-git-send-email-luiz.dentz@gmail.com>	<4D6D016B.8010308@nokia.com> <AANLkTimu8tZT8BzycJ8ROFynrLgbHMfEK3JqU0PbkGuQ@mail.gmail.com>
In-Reply-To: <AANLkTimu8tZT8BzycJ8ROFynrLgbHMfEK3JqU0PbkGuQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  Hi Luiz,

On 03/01/2011 04:31 PM, ext Luiz Augusto von Dentz wrote:
> Hi Radek,
>
> On Tue, Mar 1, 2011 at 11:23 AM, Radoslaw Jablonski
> <ext-jablonski.radoslaw@nokia.com>  wrote:
>>
>> I've applied this patch and suddenly PC Suite stopped to discover if usb
>> cable is connected (no possibility to take backup/restore via usb cable).
>> In syslog there is no obexd logs in that scenario so hard to tell what
>> went wrong:) After reverting to obexd release, based on upstream,
>> everything started to work normally again.
>>
>> So, does other components (which are using this backup functionality)
>> need to make some changes to their code or something is wrong
>> with that patch?
> Did you remember to add --enable-pcsuite to rules, otherwise pcsuite
> plugin won't compile.
>
No, I haven't touched rules so that was source of my problems:)
Many thanks for quick response.

Radek
