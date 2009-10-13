Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4AD430D0.3010109@pardus.org.tr>
References: <4AB94E32.8060703@pardus.org.tr> <4AD2D155.8040008@pardus.org.tr>
	 <8b5debfa0910120137o70880775le9dfcdede454d40f@mail.gmail.com>
	 <4AD430D0.3010109@pardus.org.tr>
Date: Tue, 13 Oct 2009 15:53:05 +0530
Message-ID: <8b5debfa0910130323t2a470e2alfef9c4ea79b0eeb5@mail.gmail.com>
Subject: Re: Undefined symbols in netlink plugin
From: alok barsode <alokbarsode@gmail.com>
To: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ozan,

On Tue, Oct 13, 2009 at 1:18 PM, Ozan =C3=87a=C4=9Flayan <ozan@pardus.org.t=
r> wrote:
> alok barsode wrote On 12-10-2009 11:37:
>> The following patch fixes this issue but I am not sure if its the right =
way.
>> Let Marcel take a call on this.
>>
>>
> Yes that fixed it. BTW, is it normal to get messages like
>
> Failed to find Bluetooth netlink family
> Failed to init netlink plugin
>
At this point, yes. There in no netlink support in the kernel as of now.

> Does the netlink support really exist?
>
Not right now. But we are working on it.

Cheers,
Alok.
