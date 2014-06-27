Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <90AEC8D9-5894-4083-AD82-F8D9A8DC1000@holtmann.org>
References: <1403896589-6135-1-git-send-email-scott@netsplit.com>
	<90AEC8D9-5894-4083-AD82-F8D9A8DC1000@holtmann.org>
Date: Fri, 27 Jun 2014 13:49:08 -0700
Message-ID: <CA+bD78gN-9XUHr+kvLCPrt_XmPttkdSH75N-8Cuh9pLuEdOKZA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] doc: Add StartDiscoveryWithOptions
From: Scott James Remnant <scott@netsplit.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jun 27, 2014 at 1:15 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:

>> Rationale is to permit an application, only interested in an LE device
>> with intent on using GATT to not cause the large power drain of
>> performing BR/EDR Inquiry.

> If I take one step back and look from an application point of view, then =
I might actually want something totally different. I think what really want=
 is a FindDevices method that will return a list of objects that fulfill my=
 search pattern. So each application can start their own FindDevices method=
 and bluetoothd will take care of making sure that each application is serv=
ed properly.
>

This kind of API makes sense too.

Would you just want the method to return a list of objects, in which
case what would the timeout be? Or would you want a session-like API
as with discovery?

It seems to fit typical use cases:

 - FindDevices( { health heart rate profile } ) -> list of nearby
heart rate monitors

 - FindDevices( { BR/EDR profile } ) -> list of paired devices that support=
 it

What about the "I lost my keys" use case?

 1. FindDevices( { profile id of stickies } ) -> list of nearby stickies
 2. Check objects EIR for the specific UUID of the beacon attached to
your keys, repeat until it's visible
 3. Watch for DeviceChanged notifications on that object, checking the
RSSI property each time, until you're on top of them

If the beacon-ish profile the particular sticky you're using has
decided to just use a completely custom field in the AD with no
standard fields (who'd do that, I mean, seriously?!), I guess you'd
just FindDevices() and filter them all by hand.

> Keep also in mind that it might be neat to have a feature where you regis=
ter an observer like agent that gets notified when a device with certain pa=
ttern is found. Once we have all the background scanning figured out in the=
 kernel, this becomes a possibility. And that is a better approach than alw=
ays triggering active scanning. The simplest pattern could just be the iden=
tity address of a device. With all this beacon stuff you might want to find=
 a device, but have no need to connect since all the data is present the ad=
vertising data. Or it could be simply that the service data contains a sequ=
ence counter that allows you to tell if connection is required or not.
>

This would suggest more of an observer API, than a method call to
return devices. The thing I like here is that it could even map
directly to controller methods, so for certain searches the controller
could remain in passive scan even while the host is in a sleep state,
and wake the host using the usual mechanisms when found.

e.g. this would be more like

  <- org.bluez.Search1.RegisterSearch(object searcher, dict search)

  -> org.bluez.Search1.DeviceFound(object device)
  -> org.bluez.Search1.DeviceFound(object device)
  -> org.bluez.Search1.DeviceFound(object device)

than

 <- org.bluez.Adapter1.FindDevices(dict search)
 -> object[]


If the search dictionary has the option to search by address, e.g. :

  <- org.bluez.Search1.RegisterSearch(this, { address: "addr" })

then that would cutely map to:

  HCI LE Set Scan Parameters( ScanningFilter=3D0x01 )
  HCI LE Add Device To White List( address=3Daddr )

if no other searches were ongoing, and assumedly just extend the white
list for paired HoG devices if those were already being passively
scanned that way.

Scott
--=20
Have you ever, ever felt like this?
Had strange things happen?  Are you going round the twist?
