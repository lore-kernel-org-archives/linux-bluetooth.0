Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Aug 2012 15:44:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Chen Ganir <chen.ganir@ti.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 01/10] Battery: Add Battery Service Gatt Client
Message-ID: <20120816124410.GB24627@x220>
References: <1345109702-5698-1-git-send-email-chen.ganir@ti.com>
 <1345109702-5698-2-git-send-email-chen.ganir@ti.com>
 <20120816113941.GA20887@x220>
 <502CE43C.7040804@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <502CE43C.7040804@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Thu, Aug 16, 2012, Chen Ganir wrote:
> >I don't think it's ok to pollute the Device interface or src/device.c
> >with profile-specific details. That should happen in profile-specific
> >plugins and interfaces. Since we're switching over to object manager
> >maybe an interface/property like this isn't needed at all? (even if it
> >would be needed the type should be array{object} and not array{string}
> 
> You are correct, the array should be object instead of string.
> However, i fail to understand why the object manager prevents this
> from getting accepted - do you have a time estimation when the
> object manager should be active or available ?

By the time of our next release (as per the content under the BlueZ 5
section in our TODO file).

> I prefer this way of putting the batteries below the device, since it
> is obvious which battery belongs to each device.

I fully agree with this. It's not what I had an issue with. However, if
we really want to make this clear you could additionally have a "Device"
property for each battery object pointing back to the parent object.

> The other option i can think of is to have another interface
> registered on the device object path:
> 
> Service		org.bluez
> Interface	org.bluez.Batteries
> Object path	[variable prefix]/{hci0,..}/dev_XX_XX_XX_XX_XX_XX
> 
> Methods	dict GetProperties()
> 
> 		Returns all properties for the interface. See the
> 		Properties section for the available properties.
> 
> Signals		ProperyChanged(string name, variant value)
> 
> 		This signal indicates a changed value of the given
> 		property.
> 
> Properties	array{object} Batteries [readonly]
> 
> 		List of device battery object paths that represents the available
> batteries on the remote devices.
> 
> 
> Service		org.bluez
> Interface	org.bluez.Battery
> Object path	[variable prefix]/{hci0,..}/dev_XX_XX_XX_XX_XX_XX/BATT-NN-DDDD
> 
> 
> Methods	dict GetProperties()
> 
> 		Returns all properties for the interface. See the
> 		Properties section for the available properties.
> 
> Signals		PropertyChanged(string name, variant value)
> 
> 		This signal indicates a changed value of the given
> 		property.
> 
> Properties	byte Level [readonly]
> 
> 			Battery level (0-100).
> 
> Any other suggestion ?

That would work, although both of these interfaces are rather
light-weight in that they only contain a single property which begs the
question whether this is a bit over-kill.

Another option is to do away with the per-battery object somehow and
expose all batteries through a single interface. I'm not so sure that's
a good idea though since it could prevent future extensibility of the
API and doesn't reuse the common tools we have for object-like
abstractions (which a battery certainly is).

Johan
