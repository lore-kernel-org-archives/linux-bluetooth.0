Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1248074063.4549.88.camel@violet>
References: <dd18b0c30907192036r477c9637x450562df605294e8@mail.gmail.com>
	<1248074063.4549.88.camel@violet>
From: Kay Sievers <kay.sievers@vrfy.org>
Date: Mon, 20 Jul 2009 18:44:25 +0200
Message-ID: <ac3eb2510907200944g285fb7dqf44eb6e3cdcc82ef@mail.gmail.com>
Subject: Re: bluetooth works with udev-145 but had some weired issues with it
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Justin Mattock <justinmattock@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jul 20, 2009 at 09:14, Marcel Holtmann<marcel@holtmann.org> wrote:
>> For some reason in rules.d
>> for the permission setting:
>>
>> #ACTION=="add", SUBSYSTEM=="bluetooth", RUN+="/usr/sbin/bluetoothd --udev"
>> to
>> RUN+="/usr/sbin/bluetoothd --udev"
>> gets this working for me.
>> prior to this, udev just would not activate
>> bluetoothd
>> Anyways thought it would be good to let people know.
>
> this is pretty much strange. What kernel version are you using?
>
> Kay, do you have any idea why such a simple rule would not work?

No, no idea. It works fine here to start bluetoothd from udev.

Kay
