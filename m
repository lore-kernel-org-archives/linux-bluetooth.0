Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <30C3CB2E-2C64-4E1D-8C9F-B4F83704BA8D@holtmann.org>
References: <1400066794-12621-1-git-send-email-lukasz.rymanowski@tieto.com>
	<D2E1C6A3-BB46-4C9D-8603-241B6CF69EBE@holtmann.org>
	<CAN_7+YbccmQce05h4A_TGQGgOToJhxx1B=xU=egf76zsfS8vXQ@mail.gmail.com>
	<30C3CB2E-2C64-4E1D-8C9F-B4F83704BA8D@holtmann.org>
Date: Wed, 14 May 2014 19:54:49 +0200
Message-ID: <CAMudyAvYAwFQ1qvDGJBBjQhhJc5FszcwgtbHRhs7SHdA7WwyMA@mail.gmail.com>
Subject: Re: [PATCH] android/gatt: Fix handling advertising state
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Szymon Janc <szymon.janc@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel

On 14 May 2014 18:10, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Lukasz,
>
>>>> This patch fixes enabling advertising.
>>>> It was not possible to enable it if we had server registered
>>>> which is on listen_apps list but does not trigger advertising.
>>>
>>> does this mean we always advertise when registering GATT server?
>> No. We just put each server on the listen_apps queue and once remote
>> device connects to us, this server gets connection callback.
>
> this sounds all a bit weird. Did Android get this wrong. We can connect to a remote device and we can still receive GATT server exchange. It has really nothing to do with central or peripheral roles.

This is bit weird I agree.
The fact is that if we want to send any read/write request to Android
Server App we need to have connection id for the server. So probably
we need to invoke connection cb for all the servers on any
incoming/outgoing connections. For now we do it only for incoming
connections just for testing. There is no single app using Server HAL
so we don't know how this actually should work.

>
> Regards
>
> Marcel
>

BR
Lukasz
