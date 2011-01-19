Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1295436312.3873.240.camel@aeonflux>
References: <1295377703.1774.6.camel@ubuntuLab1>
	<1295436312.3873.240.camel@aeonflux>
Date: Wed, 19 Jan 2011 14:17:13 +0200
Message-ID: <AANLkTi=GcxQJFGfkv8fbLN4PCGsUXLCr=9=q5VsfUEQR@mail.gmail.com>
Subject: Re: -DG_DISABLE_DEPRECATED and g_io_channel_*()
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Brian Gix <bgix@codeaurora.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jan 19, 2011 at 1:25 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Brian,
>
>> There appears to be a number of deprecated g_io_channel_* functions
>> being called from the bluez tip, which are breaking the build due to
>> Marcel's latest commit today:
>>
>> commit effe770cd43cf53fa5842291941dbfc82beab645
>> Author: Marcel Holtmann <marcel@holtmann.org>
>> Date: =A0 Tue Jan 18 14:56:31 2011 +0100
>>
>> =A0 =A0 Use -DG_DISABLE_DEPRECATED compiler define
>>
>>
>> Should this commit be backed out until these deprecated usages have been
>> fixed, or is this the general way that the issue is forced?
>>
>> Obviously deprecated functions should not be used, but it creates an
>> unbuildable bluez in the meantime.
>
> I broke it on purpose to draw some attention to this ;)

I have just send a pull request to fix those problems.


--=20
Luiz Augusto von Dentz
Computer Engineer
