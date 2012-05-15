Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANT-zCVAD0H7akcDZSeNaPjJ3u9Vbw9BEKm-A08Rva9M7ACCSw@mail.gmail.com>
References: <1337009699-19831-1-git-send-email-mikel.astiz.oss@gmail.com>
	<CAJdJm_MVPxMp9QG9_CBmGn0YeMc_Hbhiipy+brSXsqjMzFuRjA@mail.gmail.com>
	<CANT-zCVAD0H7akcDZSeNaPjJ3u9Vbw9BEKm-A08Rva9M7ACCSw@mail.gmail.com>
Date: Tue, 15 May 2012 11:24:22 -0400
Message-ID: <CAJdJm_ODjiGv2-OTXpxA51+jkafbvWLcrSWLpvaa-UcL5G1fHA@mail.gmail.com>
Subject: Re: [RFC v0] Bluetooth: mgmt: Add device disconnect reason
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, May 15, 2012 at 11:03 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> Hi Lizardo,
>
> On Tue, May 15, 2012 at 4:15 PM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
>> Hi Mikel,
>>
>> On Mon, May 14, 2012 at 11:34 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
>>> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>>>
>>> MGMT_EV_DEVICE_DISCONNECTED should expose the disconnection reason to
>>> userland.
>>
>> There is "getsockopt(sock, SOL_SOCKET, SO_ERROR, &sk_err, &len)". Why
>> is it not enough?
>
> Could you please be more specific? Which socket type exposes this
> disconnect reason?

It's L2CAP. Not sure about other socket types (I didn't check them).
BlueZ already uses it in some places (grep for "SO_ERROR"), and we use
it on GATT code for exactly the same reason you describe (many GATT
profiles describe specific behavior depending on disconnect reason
being timeout or not)

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
