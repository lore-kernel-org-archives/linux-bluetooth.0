Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <D2E1C6A3-BB46-4C9D-8603-241B6CF69EBE@holtmann.org>
References: <1400066794-12621-1-git-send-email-lukasz.rymanowski@tieto.com>
	<D2E1C6A3-BB46-4C9D-8603-241B6CF69EBE@holtmann.org>
Date: Wed, 14 May 2014 18:02:17 +0200
Message-ID: <CAN_7+YbccmQce05h4A_TGQGgOToJhxx1B=xU=egf76zsfS8vXQ@mail.gmail.com>
Subject: Re: [PATCH] android/gatt: Fix handling advertising state
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Szymon Janc <szymon.janc@tieto.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, May 14, 2014 at 5:12 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Lukasz,
>
>> This patch fixes enabling advertising.
>> It was not possible to enable it if we had server registered
>> which is on listen_apps list but does not trigger advertising.
>
> does this mean we always advertise when registering GATT server?
No. We just put each server on the listen_apps queue and once remote
device connects to us, this server gets connection callback.

> If so, then this is wrong. The GATT server has nothing to do with advertising.
>
> Regards
>
> Marcel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

BR
Lukasz
