Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 30 Aug 2017 17:10:31 +0200
From: Konrad Zapalowicz <konrad.zapalowicz@canonical.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Read by Group Type is denied when issued before Pairing is
 finsihed
Message-ID: <20170830151031.GA32280@annapurna>
References: <20170823193838.GD7309@annapurna>
 <CABBYNZ+6Rnb8PYKwDv-ObaaZsQn8-h_iVM2hP1dvSHzf5q7a0w@mail.gmail.com>
 <20170824082419.GE7309@annapurna>
 <CABBYNZK1pQgC7rSp2WNA=d5Gh50A2NZ4Sjnd05xYb2_xO8_7vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZK1pQgC7rSp2WNA=d5Gh50A2NZ4Sjnd05xYb2_xO8_7vg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/24, Luiz Augusto von Dentz wrote:
> Hi Konrad,
> 
> On Thu, Aug 24, 2017 at 11:24 AM, Konrad Zapalowicz
> <konrad.zapalowicz@canonical.com> wrote:
> > On 08/24, Luiz Augusto von Dentz wrote:
> >> Hi Konrad,
> >>
> >> On Wed, Aug 23, 2017 at 10:38 PM, Konrad Zapalowicz
> >> <konrad.zapalowicz@canonical.com> wrote:
> >> > Hey,
> >> >
> >> > I have stumbled upon a problem with one of the BLE devices that I have
> >> > on my desk. BlueZ (bluetoothctl) failed to discover the primary services
> >> > and the error returned by the Read by Group type request was
> >> > "Insufficient Authentication". It did work when using gatttool though.
> >> >
> >> > I have tracked it down and realized that if calling the
> >> > bt_gatt_discover_all_primary_services is delayed until after the pairing
> >> > is finished then the primary services are discovered without any issues.
> >> >
> >> > The simplified bt for bt_gatt_discover_all_primary_services is:
> >> >
> >> > (gdb) bt
> >> > #0  discover_services
> >> > #1  bt_gatt_discover_primary_services
> >> > #2  bt_gatt_discover_all_primary_services
> >> > #3  exchange_mtu_cb
> >> >
> >> > Now, what would be the best way of approaching this. Calling it could be
> >> > delayed with a timer but would it be an optimal solution - thoughts?
> >>
> >> Sounds to me that the device is requiring authentication for primary
> >> services which is not following the spec:
> >
> > Yes, this is true as well and it is also my concern. Yet at the same
> > time I would love to get this device operational. This is a Transport
> > Data Logger btw that I'm playing with.
> >
> >>
> >> 4.4.1 Discover All Primary Services
> >> ...
> >> Note: The service declaration described in Section 3.1 specifies that the
> >> service declaration is readable and requires no authentication or authorization,
> >> therefore insufficient authentication or read not permitted errors
> >> shall not occur.
> >>
> >> Is this a device already on the market? Perhaps we should contact the
> >> manufacturer since it seems to not comply to the spec when it comes to
> >> discovery.
> >>
> >> Delaying is never a nice thing since it affects all devices, but we
> >> could perhaps attempt to pair if that happens, actually, we usually do
> >> this for regular Read/Write procedures so in case there is an
> >> authentication error we pair and try again which might work here as
> >> well despite not following the spec.
> >
> > In the meantime I have cross-checked with the Android code and it does
> > things differently. So the services discovery is started in pairing_cb
> > that is being called when the pairing is done. I can't tell however if
> > this affects interoperability in any way, i.e. has a negative impact
> > over Linux implementation.
> 
> Not sure how Android would determine if it needs pairing before
> discovering the services, in GATT the pairing is normally done on
> demand when there is an authentication error. Though perhaps Android
> pairs with any device capable of pairing, anyway the same could be
> done with bluetoothctl> pair instead of connect command.

So I have investigated further and realized that there is an incomming
ATT connection that I have missed for the first time. As a result the
connect_cb from gatt-database.c is execued which calls the
device_attach_att that ultimately leads to gatt_client_init being
called.

The device_attach_att would be called anyway through the
new_long_term_key_callback and device_browse_gatt however since the
services are already discovered it never happens. Which is perfecly fine
btw.

I'm thinking however though if this is sane to make sure that the
services are discovered only through the new_long_term_key_callback
path. Something which would happen after the device_bonding_complete
thus would be a little bit more forgiving for devices that behave like
the described one.

Does it make sense?

> 
> Btw, even for profiles requiring pairing, like HoG, it hasn't been a
> problem to pair on demand though it is probably recommended to pair
> first so we don't lose a round trip while accessing the attributes
> that would cause the authentication error.
> 
> > Thanks,
> > K
> >
> >>
> >> > Thanks,
> >> > K
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> >> > the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> >>
> >> --
> >> Luiz Augusto von Dentz
> 
> 
> 
> -- 
> Luiz Augusto von Dentz
