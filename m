Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_NX2YopqON=Szv3X2DuuYhrGZcRPcNrE=BjdV+NVQtEnA@mail.gmail.com>
References: <CALvrRrayFrDqhm7hoDRpdnbaXhpzaSq9Q7+4GoXEnqBi82KcKQ@mail.gmail.com>
	<CAJdJm_NX2YopqON=Szv3X2DuuYhrGZcRPcNrE=BjdV+NVQtEnA@mail.gmail.com>
Date: Tue, 30 Jul 2013 15:50:36 -0700
Message-ID: <CALvrRrZxEZRuohxeeuTqU1VE9TfBHudwH9LL_1v3-oG+DNojMQ@mail.gmail.com>
Subject: Re: gatt advertising
From: Dirk-Jan Binnema <djcb.bulk@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

anderson.lizardo@openbossa.org writes:

First of all, thank you for your extremely helpful reply!

> On Tue, Jul 30, 2013 at 9:08 AM, Dirk-Jan Binnema <djcb.bulk@gmail.com> wrote:
>> Hi all,
>>

> First of all, BlueZ (and the Linux kernel) does not support the
> "Peripheral" role fully yet, which is what you want here.
>
> Therefore, you need to do a few things by hand.
>
>> - Is any extra step is needed to advertise the service beyond
>>   gatt_service_add and 'hciconfig leadv'?
>
> You need to manually add the UUIDs on the LE advertising data. For
> this, currently you need to send the "LE Set Advertising Data" HCI
> command manually to the controller (e.g. using "hcitool cmd"). See the
> Core Spec page 1062 for the HCI command format, and Section 11
> "Advertising and Scan Response Data Format (page 1735), and Appendix C
> "EIR and AD Formats" (page 1762) for the Advertising Data format
> specifically.

Yes, this seems to work. For other people trying the same:

hcitool -i hci0 cmd 0x08 0x0008 12 11 07 xx xx xx xx xx xx xx xx \
       xx xx xx xx xx xx xx xx 00 00 00 00 00 00 00 00 00 00 00 00 00

will do the advertisement when using a 128-bit UUID (the xx part,
'MY_SERVICE_ID') -- and importantly, this needs to be encoded, basically
the bytes you get from the following:

    bt_string_to_uuid (&srv_uuid, MY_SERVICE_UUID);
    for (u = 0; u != 16; ++u)
         printf ("%x ", ((uint8_t*)&srv_uuid.value)[u]);


For 16-bit UUIDs, you need to change the length bytes (the 12 and 11),
see the docs above for the details.

>>   (It seems that neither mine, nor any of the other services (proximity,
>>   time, alert, ...) are recognized until after I connect(*). After
>>   connection, I can see all of them.
>
> They are only visible after connection probably because iPhone
> triggers a Service discovery when BlueZ connects to it.
>
>> - It also seems the device stops advertising after a while -- is there
>>   some way to programmatically put it in advertising mode (like
>>   hciconfig leadv) and keep it that way?
>
> Actually, advertising stops as soon as a connection is established.
> This is a controller feature, not controllable by BlueZ. You need to
> enable advertising again manually.

Okay, that's good to know!

One other thing I've hit upon is that apparently, long-writes/reads are
supported by ATT yet (looking at channel_handler, and seeing some
'Unsupported request 0x16'), although it seems Bluez can do long-writes
itself.

Are there plans to add long-writes/reads to ATT? Or would this be very
easy to add? (I suppose not!).

Thanks,
Dirk.


-- 
Dirk-Jan C. Binnema                  Helsinki, Finland
e:djcb@djcbsoftware.nl           w:www.djcbsoftware.nl
pgp: D09C E664 897D 7D39 5047 A178 E96A C7A1 017D DA3C

On Tue, Jul 30, 2013 at 8:03 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Dirk,
>
> On Tue, Jul 30, 2013 at 9:08 AM, Dirk-Jan Binnema <djcb.bulk@gmail.com> wrote:
>> Hi all,
>>
>> I'm trying to build a GATT-based service that exposes some
>> characteristics that can be accessed by clients; I'm using
>> gatt_add_service_add for that, and the BLExplr app on the iPhone side.
>>
>> The good news is that it seems to be possibly to do so :-) (I'm using
>> git master + the 128-bit uuid patch I wrote); however, it seems the
>> service is not advertised; I need to connect to the device first before
>> I can see it; at least when trying with an iPhone.
>
> First of all, BlueZ (and the Linux kernel) does not support the
> "Peripheral" role fully yet, which is what you want here.
>
> Therefore, you need to do a few things by hand.
>
>> - Is any extra step is needed to advertise the service beyond
>>   gatt_service_add and 'hciconfig leadv'?
>
> You need to manually add the UUIDs on the LE advertising data. For
> this, currently you need to send the "LE Set Advertising Data" HCI
> command manually to the controller (e.g. using "hcitool cmd"). See the
> Core Spec page 1062 for the HCI command format, and Section 11
> "Advertising and Scan Response Data Format (page 1735), and Appendix C
> "EIR and AD Formats" (page 1762) for the Advertising Data format
> specifically.
>
>>   (It seems that neither mine, nor any of the other services (proximity,
>>   time, alert, ...) are recognized until after I connect(*). After
>>   connection, I can see all of them.
>
> They are only visible after connection probably because iPhone
> triggers a Service discovery when BlueZ connects to it.
>
>> - It also seems the device stops advertising after a while -- is there
>>   some way to programmatically put it in advertising mode (like
>>   hciconfig leadv) and keep it that way?
>
> Actually, advertising stops as soon as a connection is established.
> This is a controller feature, not controllable by BlueZ. You need to
> enable advertising again manually.
>
> Note that most controllers on the market (if not all of them) obey the
> LE topology, so when they are slave in a connection, they will
> probably not be able to send connectable advertisements. You will only
> be able to enable advertising again once the link is disconnected.
>
>> - Should the UUID of the service be part of the UUIDs property in
>>   org.Bluez.Adapter1 and org.bluez.Device1? (I tried 'btmgmt aad-uuid
>>   <uuid> 0' and then then <uuid> becomes visible in the
>>   org.bluez.Device1 UUIDs, but sadly, the iPhone still doesn't seem to
>>   see it, pre-connection).
>
> As BlueZ does not support peripheral role yet, the D-Bus API does not
> have any effect on this situation.
>
>> (*) but for some reason, in the aforementioned app, I can see the 'Tx Power
>> Level' value before connection.
>
> This app is most likely reading the TX Power value which is inserted
> on the LE Advertising Data by the kernel. BlueZ does not have a
> working TX Power service yet.
>
> Best Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil
