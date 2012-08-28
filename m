Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Aug 2012 18:04:12 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Chen Ganir <chen.ganir@ti.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH v4 01/10] Battery: Add Battery Service Gatt Client
Message-ID: <20120828010412.GA10928@x220.sheraton.com>
References: <1345109702-5698-1-git-send-email-chen.ganir@ti.com>
 <1345109702-5698-2-git-send-email-chen.ganir@ti.com>
 <20120816113941.GA20887@x220>
 <502CE43C.7040804@ti.com>
 <20120816124410.GB24627@x220>
 <502CEDA7.2040908@ti.com>
 <20120816192440.GC25826@x220.P-661HNU-F1>
 <CABBYNZ+bn__fjNMSwix3J7ntRyTahEQca+z9EeWg2PPEwt3S1A@mail.gmail.com>
 <5039CA72.6090906@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5039CA72.6090906@ti.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Sun, Aug 26, 2012, Chen Ganir wrote:
> So what do you suggest here ? Calculating an average ? How shoudl it
> be done ? If 2 batteries are available, first is 100% and the second
> is 50%, we should simply set the value as 75%? I'm not so sure that we
> should make such decisions for the end user.
> 
> >Another thing that worth adding is that there are other profiles that
> >do support battery status such as HFP and AVRCP, so I think this
> >should be made generic enough so other sources could be supported.
> 
> The internal device API uses the device_add_battery(...) and
> device_remove_battery(...) to allow adding/removing batteries to the
> device battery list, but it is the responsibility of the profile to
> register a D-Bus interface, and update.
> 
> I could redesign this, to add a generic battery API, which will
> expose a new API, such as battery_add(battery_struct* batt),
> battery_remove(battery_struct* batt) and
> battery_update(battery_struct* batt) which will allow a more generic
> approach. This Battery module will be responsible for
> registering/unregistering the D-Bus API, and profiles which need to
> use it will simply use the exposed API to add/remove/update. The
> batt_structure will also include some callback functions to be
> called when a value is queried for example, or if a device is
> removed. The LE Battery plugin will use the GATT to
> read/write/receive notification, and use the Generic Battery
> interface to interface with the external world. What do you think
> about it ?

I had a brief chat with Marcel about this and the following were the
main conclusions:

1. It'd be nice to have support for this added to UPower so that it can
enumerate Bluetooth batteries.

2. The easiest way to do 1. would be to have this one D-Bus object per
battery.

3. Use uint16 instead of byte to keep our D-BUs API consistent wrt.
unsigned integers (byte is signed).

4. No Adapter property or interface needed once we've merged the object
manager patches.

5. (as you proposed) we'll probably want/need a src/device.c API for
device drivers to register batteries. Other profiles supporting battery
info (AVRCP, HFP, etc) could use the same API.

Johan
