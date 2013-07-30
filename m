Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 30 Jul 2013 06:08:08 -0700
Message-ID: <CALvrRrayFrDqhm7hoDRpdnbaXhpzaSq9Q7+4GoXEnqBi82KcKQ@mail.gmail.com>
Subject: gatt advertising
From: Dirk-Jan Binnema <djcb.bulk@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I'm trying to build a GATT-based service that exposes some
characteristics that can be accessed by clients; I'm using
gatt_add_service_add for that, and the BLExplr app on the iPhone side.

The good news is that it seems to be possibly to do so :-) (I'm using
git master + the 128-bit uuid patch I wrote); however, it seems the
service is not advertised; I need to connect to the device first before
I can see it; at least when trying with an iPhone.

So, a few questions:

- Is any extra step is needed to advertise the service beyond
  gatt_service_add and 'hciconfig leadv'?

  (It seems that neither mine, nor any of the other services (proximity,
  time, alert, ...) are recognized until after I connect(*). After
  connection, I can see all of them.

- It also seems the device stops advertising after a while -- is there
  some way to programmatically put it in advertising mode (like
  hciconfig leadv) and keep it that way?

- Should the UUID of the service be part of the UUIDs property in
  org.Bluez.Adapter1 and org.bluez.Device1? (I tried 'btmgmt aad-uuid
  <uuid> 0' and then then <uuid> becomes visible in the
  org.bluez.Device1 UUIDs, but sadly, the iPhone still doesn't seem to
  see it, pre-connection).

I don't really know what to expect, what things I may be missing, and if
perhaps things are missing in Bluez implementation, so any help is
welcome!

Thanks in advance,
Dirk.

[ my apologies if you received this message more than once; it seems
the message didn't reach the mailing list, so I tried again... ]


(*) but for some reason, in the aforementioned app, I can see the 'Tx Power
Level' value before connection.

-- 
Dirk-Jan C. Binnema                  Helsinki, Finland
e:djcb@djcbsoftware.nl           w:www.djcbsoftware.nl
pgp: D09C E664 897D 7D39 5047 A178 E96A C7A1 017D DA3C
