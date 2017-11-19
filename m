Return-Path: <martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
In-Reply-To: <56889A64-AFB2-454C-9889-FAA4C051168A@holtmann.org>
References: <20171117223543.32429-1-martin.blumenstingl@googlemail.com>
 <20171117223543.32429-8-martin.blumenstingl@googlemail.com> <56889A64-AFB2-454C-9889-FAA4C051168A@holtmann.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 19 Nov 2017 21:24:20 +0100
Message-ID: <CAFBinCC_G845v4cZW9hvwYEDQhTCLW1iG_JWzAz9Gu42rM4_Zg@mail.gmail.com>
Subject: Re: [RFC v1 7/8] Bluetooth: hci_serdev: remove the
 HCI_UART_INIT_PENDING check
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree <devicetree@vger.kernel.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>, "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, linux-sunxi@googlegroups.com,
	linux-amlogic@lists.infradead.org, Larry.Finger@lwfinger.net
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

thank you for going through my patches!

On Sun, Nov 19, 2017 at 9:21 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Martin,
>
>> The three-wire (H5) protocol is the only protocol which uses
>> HCI_UART_INIT_PENDING.
>> Unfortunately the protocol implementation never receives data with this
>> check still in place. For the H5 protocol this means that the
>> initialization never completes and thus the firmware download never
>> starts. Even if the initialization would succeed later on the drivers
>> would call hci_uart_init_ready() which schedules the registration which
>> is currently not implemented by hci_serdev.c.
>>
>> Removing the HCI_UART_INIT_PENDING check makes the code easier to read
>> and also fixes the initalization of devices (implemented with the serdev
>> library) which use the H5 protocol.
>>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> ---
>> drivers/bluetooth/hci_serdev.c | 3 ---
>> 1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
>> index e0e6461b9200..fe67eb6d4278 100644
>> --- a/drivers/bluetooth/hci_serdev.c
>> +++ b/drivers/bluetooth/hci_serdev.c
>> @@ -333,9 +333,6 @@ int hci_uart_register_device(struct hci_uart *hu,
>>       else
>>               hdev->dev_type = HCI_PRIMARY;
>>
>> -     if (test_bit(HCI_UART_INIT_PENDING, &hu->hdev_flags))
>> -             return 0;
>> -
>
> then lets also remove the flag definition itself. Or if that is still needed for some legacy operation, then describe this. For example I also see it used in hci_serdev.c and main question would be if it is used there as well or some legacy cruft.
this flag is still used in hci_ldisc.c (if that's what you mean
instead of hci_serdev.c):
as far as I understand the code it's used to postpone the
hci_register_dev() call until the sync response is received

Johan Hedberg added this code in 9f2aee848fe6 ("Bluetooth: Add delayed
init sequence support for UART controllers") - it would be great if he
could comment on this (he is CC'ed on this mail)


Regards
Martin
