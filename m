Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTimQeQ-XoM5yuWQYx5_1-xWf1H0ax_J=BbtDfG2T@mail.gmail.com>
References: <AANLkTimA4dnDeoZVX1N4c=2sR1JkgAFWb4d0-0K+8S1C@mail.gmail.com>
	<1280764595.12579.19.camel@localhost.localdomain>
	<AANLkTimQeQ-XoM5yuWQYx5_1-xWf1H0ax_J=BbtDfG2T@mail.gmail.com>
Date: Mon, 2 Aug 2010 21:12:53 +0300
Message-ID: <AANLkTimExH027cpFPmMS8vd7be9HkBWzok9tzWqNJFeP@mail.gmail.com>
Subject: Re: Getting link quality or RSSI
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Davide Pesavento <davidepesa@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Aug 2, 2010 at 7:34 PM, Davide Pesavento <davidepesa@gmail.com> wrote:
> "using a connection" means pushing some traffic over it?
> Is there no other way to prevent the kernel from terminating idle connections?

You should really think twice if you are creating a connection just to
see the link quality, it really doesn't worth.

> By the way, I've read in the Bluetooth specs that there exists an
> extended inquiry mode which allows the host to gather the RSSI of
> available devices too. How can I perform such kind of inquiry from my
> application using bluez?

We do expose the RSSI when doing the device discovery, take a look at
DeviceFound documentation under doc/adapter-api.txt, as for link
quality maybe it can be made as a Property of device object, but as
Marcel said this is vendor specific so the use cases are very limited.
In the other hand it would be very nice if ui could show the link
quality and we could possible use it to route the audio back to the
speaker if the connection quality is too low.


-- 
Luiz Augusto von Dentz
Computer Engineer
