Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <799E44F0-0095-4281-9850-5A5A53C3D413@holtmann.org>
References: <1457106781-8566-1-git-send-email-szymon.janc@codecoup.pl>
	<1457106781-8566-2-git-send-email-szymon.janc@codecoup.pl>
	<799E44F0-0095-4281-9850-5A5A53C3D413@holtmann.org>
Date: Sun, 6 Mar 2016 16:34:53 +0200
Message-ID: <CABBYNZKK6eCVouvsQMGfQdYA-6RY02O05q7yMsjtHfPL1kBu7A@mail.gmail.com>
Subject: Re: [RFC] doc: Add DeviceClassic1 and DeviceSmart1 interfaces
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Szymon Janc <szymon.janc@codecoup.pl>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Mar 4, 2016 at 7:32 PM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Szymon,
>
>> This interfaces will provide per tranport capabilities of remote
>> devices. Eventually leading to deprecation of Device1 interface.
>
> so I not like the naming DeviceClassic1 and DeviceSmart1 at all. Nobody u=
ses these terms widely that they are easily recognizable and can be associa=
ted. I also do not want to follow Bluetooth SIG marketing and logo terms. T=
hey might change and then we are stuck with it.

IMO they are better than LE and BR/EDR, but perhaps you have something
better in mind. Btw, this does bring the question if we should do
something similar to the Adapter interface, although there are a
little less conflicts because there more LE specific interfaces.

--=20
Luiz Augusto von Dentz
