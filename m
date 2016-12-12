Return-Path: <dzickus@redhat.com>
Date: Mon, 12 Dec 2016 14:12:56 -0500
From: Don Zickus <dzickus@redhat.com>
To: Brennan Ashton <brn@deako.com>, Marcel Holtmann <marcel@holtmann.org>
Cc: Northfield Stuart <stu@metanate.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 0/3] core/adapter: Add disabling duplicate device filtering
 from d-bus
Message-ID: <20161212191256.GS35881@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <43177B7B-FB86-4899-B9B6-AAD4B7EA0B78@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

(I just subscribed to the bluetooth mailing list, but I don't have Marcel's
reply, so I am copying-n-pasting it here for a reply.  Sorry about the
ugliness of it)


Hi Marcel,

(copy-n-pasted response)

>> 
>> Can I just leap in here, as this is extremely relevant to the project I
>> am working on. Sometimes you need to step back from what the â€˜average
>> userâ€™ needs, and consider whether should allow certain behaviours to be
>> enabled, even if they are not the default. What is â€˜nastyâ€™ to you in
>> the big picture, is perfectly normal for me in a dedicated use case.
>> 
>> Our application transfers data between devices (and there could be well
>> over a thousand within range at a single time) and the central system
>> using purely the MSD in the advertisements. Our linux â€˜gatewayâ€™ boxes
>> need to have continuous reception of advertisements, and we donâ€™t care
>> about the power consumption or processing implications - that is their
>> dedicated job. We are currently unable to migrate our code from some
>> older gatttool derived code to the modern APIs because it simply isnâ€™t
>> possible to work in the manner we need. (Note that our gateways use
>> multiple BLE dongles, with at least one dedicated to receiving beacons
>> while the others are used to connect to devices for archived data
>> retrieval.)
> 
> Hi,
> 
> I want to echo Stu's application.  The idea is to use bluetooth to
> constantly scan the area for devices coming and going as a way to track
> them (for IoT purposes).  Scanning for advertisement data seems to make
> things easier for bluetooth tags to transmit for tracking as we don't have
> to make connections are really gather any data other than address and
> maybe
> RSSI.
> 
> I understand the power implications but the machine is plugged into the
> wall
> and acts more like a server, so it is expected to consume lots of power.
> It's the beacons that I would like to consume as little power as possible
> (trying to figure out a good update frequency).
> 
> I really don't care how the scanning is done (active or passive), just as
> long as I can detect devices in the area within a reasonable time slice.

actually I care about active scan mainly since that causes disturbance for
everybody around you. As I said, that is a big deal if you go for active
scanning (in our case discovery).

That said, if people want such an interface, then we have to build one.
However it needs to be a separate and dedicated interface. It also needs to
be flexible enough that when some sort of filtering exists, it can be
offloaded into the controller. I think the difference between scanning for
discovery and this is that you are expecting it to run all the time.

> I am happy to code up any suggestions, just looking for guidance. :-)

What we need is an extra set management APIs that allow for telling the
kernel what you are looking for and how long. The filtered discovery is
nice, but I doubt it is what you are looking for. The only real question to
answer is what is the refresh time expected of advertising data and RSSI
changes. New devices are found quickly since that can be done by duplicate
filtering, but if you want to monitor the RSSI or look for changed
advertising data, we need to do things differently.

So before anybody starts coding, I think we need to figure out what we want
and define the mgmt API to do this. The coding part will be relatively
simple in the end.

Regards

Marcel

---------my response----

I am not entirely sure how to design it or provide the exact answers you are
looking for, but here is my initial thoughts if that helps.

- I wasn't looking for a 100% sampling, far less is fine as long as I can
  determine every second?? or so, if the device is still sending anything
  (adv.?)

- iBeacons supposedly broadcast every 100ms 3 packets?, so sampling 1/second
  for 100-200ms long is a good start?  that should be able to pick up one
  round.

- I really don't need to 'add a device' to any tables as this table will
  grow to be very huge unless we have rules to 'remove a device' rather
  quickly.

- so instead of 'discovering a new device' and registering a callback on
  that device's changing properties, just a generic interface to provide
  updated info as it becomes available?

- ability to tweak the above scan settings (frequency/duration)?

Just my initial thoughts.  Is there more specific info you need?

I am not sure if the above meets Stu's or Brennan's needs.

Cheers,
Don
