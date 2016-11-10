Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAGXr9JFjURuq0brgMGYYU+r_5XedXm4WgS_B-vKLZiWS4WKbrA@mail.gmail.com>
References: <CAGXr9JFjURuq0brgMGYYU+r_5XedXm4WgS_B-vKLZiWS4WKbrA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 10 Nov 2016 16:17:40 +0200
Message-ID: <CABBYNZ+yMwgGN4+pv7dyog0P8LyME5zVz=RuD=sqXs6csYQBAQ@mail.gmail.com>
Subject: Re: BlueZ 5.43: HoG peripheral services re-discovered again and again
 on every reconnect
To: Petri Gynther <pgynther@google.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

On Wed, Nov 9, 2016 at 9:39 PM, Petri Gynther <pgynther@google.com> wrote:
> Hi linux-bluetooth:
>
> I'm seeing the following issue with BlueZ 5.43 and Linux 4.4.30.
>
> When a previously bonded HoG remote control reconnects to BlueZ 5.43
> host, BlueZ goes ahead and re-discovers the primary services of the
> bonded remote again and again on every reconnect.
>
> Why is this necessary? Shouldn't this information be cached on the
> initial pairing/bonding, and a reconnect can get this information from
> the relevant persistent file, rather than wasting BLE airtime and
> delaying the reconnect?
>

IF, and only if, the cache is restored properly then yes it will work
as you said, but bt_hog is not yet using the gatt_db so it might
rediscover the handles anyway, this happens only once though.

>
>
> In the above log, I see that MTU exchange takes place:
> 15,148467,14484676000,-;bluez: bluetoothd[1985]:
> src/device.c:gatt_debug() MTU exchange complete, with MTU: 23
>
> Looking at the relevant code in src/shared/gatt-client.c, function
> exchange_mtu_cb():
>
>         util_debug(client->debug_callback, client->debug_data,
>                                         "MTU exchange complete, with MTU: %u",
>                                         bt_att_get_mtu(client->att));
>
> discover:
>         client->discovery_req = bt_gatt_discover_all_primary_services(
>                                                         client->att, NULL,
>                                                         discover_primary_cb,
>                                                         discovery_op_ref(op),
>                                                         discovery_op_unref);
>
>
> The call to bt_gatt_discover_all_primary_services() is unconditional,
> whether the device was previously bonded or not.

This does range validation in case service changed is not properly
implemented this will attempt to figure out if there are any changes
in the database, but note that it will stop in here:

attr = gatt_db_insert_service(client->db, start, &uuid, true,
end - start + 1);
if (!attr) {

So if the database already contain all the services it will no do more
than one Read By Group Type.

-- 
Luiz Augusto von Dentz
