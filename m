Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTimExH027cpFPmMS8vd7be9HkBWzok9tzWqNJFeP@mail.gmail.com>
References: <AANLkTimA4dnDeoZVX1N4c=2sR1JkgAFWb4d0-0K+8S1C@mail.gmail.com>
	<1280764595.12579.19.camel@localhost.localdomain>
	<AANLkTimQeQ-XoM5yuWQYx5_1-xWf1H0ax_J=BbtDfG2T@mail.gmail.com>
	<AANLkTimExH027cpFPmMS8vd7be9HkBWzok9tzWqNJFeP@mail.gmail.com>
Date: Mon, 2 Aug 2010 23:55:19 +0200
Message-ID: <AANLkTinyONY41Dm77VgUJy9dZa=5E5iO+4zBc6EDePHt@mail.gmail.com>
Subject: Re: Getting link quality or RSSI
From: Davide Pesavento <davidepesa@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Aug 2, 2010 at 20:12, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Mon, Aug 2, 2010 at 7:34 PM, Davide Pesavento <davidepesa@gmail.com> wrote:
>> "using a connection" means pushing some traffic over it?
>> Is there no other way to prevent the kernel from terminating idle connections?
>
> You should really think twice if you are creating a connection just to
> see the link quality, it really doesn't worth.
>

OK, thanks for the advice.

>> By the way, I've read in the Bluetooth specs that there exists an
>> extended inquiry mode which allows the host to gather the RSSI of
>> available devices too. How can I perform such kind of inquiry from my
>> application using bluez?
>
> We do expose the RSSI when doing the device discovery, take a look at
> DeviceFound documentation under doc/adapter-api.txt, as for link
> quality maybe it can be made as a Property of device object, but as
> Marcel said this is vendor specific so the use cases are very limited.
> In the other hand it would be very nice if ui could show the link
> quality and we could possible use it to route the audio back to the
> speaker if the connection quality is too low.
>

What I'm trying to accomplish is indeed similar to that: I'd like to
re-route some audio streams based on RSSI or link quality.

>
> --
> Luiz Augusto von Dentz
> Computer Engineer
>

Regards,
Davide
