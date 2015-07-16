Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20150716105937.GA18341@t440s.lan>
References: <CANzaTi6_OF9C6DjPeRqaoUBKqdJZSQ+0k0cJLodWS3o5LzTsbw@mail.gmail.com>
	<20150716105937.GA18341@t440s.lan>
Date: Thu, 16 Jul 2015 14:49:09 +0200
Message-ID: <CANzaTi5gK457ZJP5V_ty6ufSzm2LmX6wsfVracqR0MwDZS6jyg@mail.gmail.com>
Subject: Re: Advertising API, possible to set LE only?
From: dogan yazar <doganyazar@gmail.com>
To: dogan yazar <doganyazar@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks a lot for the answer. That is exactly what I need.  However
putting in the main.conf did not really make any reference and trying
the btmgmt returns "Rejected"
[mgmt]# bredr off
Set BR/EDR for hci0 failed with status 0x0b (Rejected)

Any idea why? Is it controller related?

On Thu, Jul 16, 2015 at 12:59 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi dogan,
>
> On Thu, Jul 16, 2015, dogan yazar wrote:
>> In the Advertising API, org.bluez.LEAdvertisement1 has Type field
>> which can be "broadcast" or "peripheral".
>> When I set it to be peripheral, the outgoing advertisement packets has
>> the advertisement flags:
>> 0x02 (BLE_GAP_ADV_FLAG_LE_GENERAL_DISC_MODE) and I guess that is why
>> when I try to connect the peripheral from my Android, I get a pairing
>> request back.
>>
>> Is there a way to set BLE_GAP_ADV_FLAG_BR_EDR_NOT_SUPPORTED on the
>> flags as well to show I only support LE and so I can also skip the
>> pairing requests.
>
> You could try setting ControllerMode=le in the [General] section of
> /etc/bluetooth/main.conf and restart bluetoothd. Another option is to
> disable BR/EDR manually with btmgmt ("btmgmt bredr off").
>
> Johan
