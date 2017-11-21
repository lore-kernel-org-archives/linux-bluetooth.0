Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1511286499.16347.39.camel@hadess.net>
Subject: Re: Bluetooth LE mouse staying "connected"
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 21 Nov 2017 18:48:19 +0100
In-Reply-To: <CABBYNZLn=BGXKPRjyEYYP2X9+5LZ=mb1nBSA+ir6-1hccy23WQ@mail.gmail.com>
References: <1511261624.16347.29.camel@hadess.net>
         <CABBYNZLn=BGXKPRjyEYYP2X9+5LZ=mb1nBSA+ir6-1hccy23WQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2017-11-21 at 13:41 +0200, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Tue, Nov 21, 2017 at 12:53 PM, Bastien Nocera <hadess@hadess.net>
> wrote:
> > Hey,
> > 
> > I re-tested the battery support for Bluetooth LE, and I still have
> > my
> > mouse staying "connected" because the PropertiesChanged signal is
> > never
> > sent for it.
> > 
> > I believe the reason is that a btd_device reference is staying
> > around.
> > 
> > Reproducer:
> > 1. Launch bluetoothd
> > 2. Turn mouse on
> > 3. "disconnect" the device from the computer side
> > 4. Notice that the "Connected" property didn't change but the
> > device
> > will now appear disconnected in a properties dump
> > 
> > When connecting, the flow is:
> > - batt_probe() is called, I ref() the device
> > - batt_accept() is called
> > 
> > When disconnecting, the flow is:
> > - batt_disconnect() is called
> > 
> > Shouldn't batt_remove also be called in this case, so the refing is
> > symmetrical? If not, should I move the btd_device ref to
> > batt_accept()
> > and add a removal for batt_disconnect()? Or is the problem in the
> > core?
> 
> batt_probe and batt_remove are symmetrical, probe callback should be
> called just once per device when the UUID is discovered and then when
> it is removed. So if you are not seeing this happen then perhaps we
> have a bug somewhere.

The problem was that the code in gdbus/object.c was eating the property
changed signal inside the "pending" list of signal emissions.

The flow would have been:
- Connected changed, so add it to the pending list of properties
  (called as g_dbus_emit_property_changed() from
   device_remove_connection in src/device.c)
- The Battery1 interface gets removed by the battery plugin, so
remove_interface() gets called, so data->pending_prop gets set to
FALSE.

But none of the properties on the other interfaces have been processed.
So the property is never emitted.

I'll send a patch for this shortly.

Cheers
