Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CALvrRrayFrDqhm7hoDRpdnbaXhpzaSq9Q7+4GoXEnqBi82KcKQ@mail.gmail.com>
References: <CALvrRrayFrDqhm7hoDRpdnbaXhpzaSq9Q7+4GoXEnqBi82KcKQ@mail.gmail.com>
Date: Tue, 30 Jul 2013 11:03:12 -0400
Message-ID: <CAJdJm_NX2YopqON=Szv3X2DuuYhrGZcRPcNrE=BjdV+NVQtEnA@mail.gmail.com>
Subject: Re: gatt advertising
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Dirk-Jan Binnema <djcb.bulk@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dirk,

On Tue, Jul 30, 2013 at 9:08 AM, Dirk-Jan Binnema <djcb.bulk@gmail.com> wrote:
> Hi all,
>
> I'm trying to build a GATT-based service that exposes some
> characteristics that can be accessed by clients; I'm using
> gatt_add_service_add for that, and the BLExplr app on the iPhone side.
>
> The good news is that it seems to be possibly to do so :-) (I'm using
> git master + the 128-bit uuid patch I wrote); however, it seems the
> service is not advertised; I need to connect to the device first before
> I can see it; at least when trying with an iPhone.

First of all, BlueZ (and the Linux kernel) does not support the
"Peripheral" role fully yet, which is what you want here.

Therefore, you need to do a few things by hand.

> - Is any extra step is needed to advertise the service beyond
>   gatt_service_add and 'hciconfig leadv'?

You need to manually add the UUIDs on the LE advertising data. For
this, currently you need to send the "LE Set Advertising Data" HCI
command manually to the controller (e.g. using "hcitool cmd"). See the
Core Spec page 1062 for the HCI command format, and Section 11
"Advertising and Scan Response Data Format (page 1735), and Appendix C
"EIR and AD Formats" (page 1762) for the Advertising Data format
specifically.

>   (It seems that neither mine, nor any of the other services (proximity,
>   time, alert, ...) are recognized until after I connect(*). After
>   connection, I can see all of them.

They are only visible after connection probably because iPhone
triggers a Service discovery when BlueZ connects to it.

> - It also seems the device stops advertising after a while -- is there
>   some way to programmatically put it in advertising mode (like
>   hciconfig leadv) and keep it that way?

Actually, advertising stops as soon as a connection is established.
This is a controller feature, not controllable by BlueZ. You need to
enable advertising again manually.

Note that most controllers on the market (if not all of them) obey the
LE topology, so when they are slave in a connection, they will
probably not be able to send connectable advertisements. You will only
be able to enable advertising again once the link is disconnected.

> - Should the UUID of the service be part of the UUIDs property in
>   org.Bluez.Adapter1 and org.bluez.Device1? (I tried 'btmgmt aad-uuid
>   <uuid> 0' and then then <uuid> becomes visible in the
>   org.bluez.Device1 UUIDs, but sadly, the iPhone still doesn't seem to
>   see it, pre-connection).

As BlueZ does not support peripheral role yet, the D-Bus API does not
have any effect on this situation.

> (*) but for some reason, in the aforementioned app, I can see the 'Tx Power
> Level' value before connection.

This app is most likely reading the TX Power value which is inserted
on the LE Advertising Data by the kernel. BlueZ does not have a
working TX Power service yet.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
