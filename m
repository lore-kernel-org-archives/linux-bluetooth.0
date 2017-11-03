Return-Path: <alan.martinovic@senic.com>
MIME-Version: 1.0
In-Reply-To: <A54DC2AB-C202-4EB9-A6FA-4C20272D0C63@holtmann.org>
References: <CAOT_U5Z0QanW-jMa6T4+b0aN+PjSwntBE8V1ZZ=_Qfb9X1p0HA@mail.gmail.com>
 <A54DC2AB-C202-4EB9-A6FA-4C20272D0C63@holtmann.org>
From: Alan Martinovic <alan.martinovic@senic.com>
Date: Fri, 3 Nov 2017 10:15:10 +0100
Message-ID: <CAOT_U5ZwkUBRgOynNVOL1n=wiX1HDXBOmnc5GaX_zQZafM+NRg@mail.gmail.com>
Subject: Re: BlueZ with HCI over SPI
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hey,
thanks for the reply and sorry for a vaguely posted question.
I didn't know it was sent incorrectly (I'm not getting the posts I
post from the mailing list).

I have found references that it isn't something standard:
https://www.spinics.net/lists/linux-bluetooth/msg71445.html
But there are all these BLE modules that interface through SPI.

Are those cases in which the host is implemented on the BLE module itself,
and SPI is used as a carrier between a host and an application, not
connecting the host and controller?

Be Well,
Alan


On Fri, Nov 3, 2017 at 9:59 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Alan,
>
>> anyone knows the state of BlueZ and bluetooth for HCI over SPI?
>>
>> Found a reference saying it isn't possible without doing kernel modifications:
>
> HCI over SPI is not a standard. So it needs to be done with a vendor protocol. If that protocol is defined somewhere, it will require a driver in drivers/bluetooth/ to work. Normally these drivers are pretty simple, but a driver is needed.
>
> Regards
>
> Marcel
>
