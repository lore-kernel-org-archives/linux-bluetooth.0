Return-Path: <brn@deako.com>
Message-ID: <1481228034.32132.4.camel@deako.com>
Subject: Re: [RFC 0/3] core/adapter: Add disabling duplicate device
 filtering from d-bus
From: Brennan Ashton <brn@deako.com>
To: Northfield Stuart <stu@metanate.com>, Marcel Holtmann
 <marcel@holtmann.org>
Cc: Don Zickus <dzickus@redhat.com>, Luiz Augusto von Dentz
	 <luiz.dentz@gmail.com>, "linux-bluetooth@vger.kernel.org"
	 <linux-bluetooth@vger.kernel.org>
Date: Thu, 08 Dec 2016 12:13:54 -0800
In-Reply-To: <DB5F4EC2-F527-46C0-BC39-0FD2EE2BB8C1@metanate.com>
References: <1481060400-7088-1-git-send-email-dzickus@redhat.com>
	 <CABBYNZLdm5TsxZeCzS0S_7Xf0sfqYPNy8YrOMTpOsL3pNUO0jA@mail.gmail.com>
	 <20161207201642.GF35881@redhat.com>
	 <0551C6BD-7C6C-4929-AC5A-79A9ADB5176C@holtmann.org>
	 <DB5F4EC2-F527-46C0-BC39-0FD2EE2BB8C1@metanate.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2016-12-08 at 12:29 +0000, Northfield Stuart wrote:
> > 
> > On 8 Dec 2016, at 06:18, Marcel Holtmann <marcel@holtmann.org>
> > wrote:
> > 
> > Hi Don,
> > 
> > > 
> > > > 
> > > > > 
> > > > > Recent discussions on the bluez mailing list revealed it was
> > > > > not easy
> > > > > to disable duplicate device filtering from the d-bus
> > > > > interface.
> > > > > 
> > > > > As a result, if I wanted to monitor LE devices entering and
> > > > > leaving the
> > > > > adapters range (using RSSI data), it was difficult.
> > > > > 
> > > > > This patchset is a dirty hack to make this work. The first
> > > > > patch enables
> > > > > it on the kernel side, while the other two patches enable it
> > > > > from the bluez
> > > > > side.
> > > > > 
> > > > > I understand there are concerns about flooding the d-bus
> > > > > interface when
> > > > > enabling this.  I tried to write a throttling mechanism using
> > > > > the mainloop
> > > > > as my timer, but soon realized you can only have 1 device
> > > > > RSSI event
> > > > > per loop, so that wasn't going to work.  Open to suggestions
> > > > > if still a
> > > > > concern.
> > > > > 
> > > > > Posted as an RFC just to generate discussion.  I expect I
> > > > > missed a lot of
> > > > > little details here, but wanted to post my proof of concept
> > > > > to see if this
> > > > > is something to work with.
> > > > > 
> > > > > This patchset includes both the kernel and bluez patches.  I
> > > > > understand this is
> > > > > not recommended for normal practice.  But I thought for an
> > > > > RFC, it is nice to
> > > > > keep things together for now.
> > > > 
> > > > I would avoid adding a new MGMT command and instead disabled
> > > > duplicated filtering if RSSI filtering is set since anyway RSSI
> > > > filtering needs to disable duplicates in order to do any RSSI
> > > > filtering reliable. So this would mean that if the user wants
> > > > to see
> > > > to get duplicate filtering it needs to set a RSSI which should
> > > > rate
> > > > limit as we would use a threshold.
> > > 
> > > Hi Luiz,
> > > 
> > > Ok, fair enough.  I then simplified it down to a small kernel
> > > patch that
> > > seems to work if I set an RSSI threshold with SetDiscoveryFilter.
> > > 
> > > I only do this on an active_scan.  Not sure if I should do it for
> > > the
> > > passive scans too?
> > > 
> > > If this looks ok, I will resubmit properly.
> > 
> > I am not sure this is the best idea. So right now the kernel
> > restarts scanning to get new RSSI values when we have a quirk set
> > that strict scan filtering is performed by the controller (strict
> > means address only).
> > 
> > That is for discovery. Something started by the user and something
> > that does not last over long times. Discovery is using active
> > scanning which takes way more TX/RX time on air than passive
> > scanning. It is also known to be causing more problems then it
> > solves when run constantly. The reason is that it will interrupt
> > CONNECT_REQ since SCAN_REQ are more likely to win based on their
> > shorter packet size.
> > 
> > So the main question is if you are after a certain set of devices
> > (based on their address) and want to monitor their RSSI or are you
> > after any device and want to match based on advertising data?
> > 
> > The first one could be dealt with by using the whitelist, the
> > second one is nasty from a power consumption point of view. Any
> > long term operation there would be causing major headaches.
> > 
> > Keep in mind that besides the kernel waking up (and USB transport),
> > you also end up waking userspace all the time to process the
> > information and send out over D-Bus. Which means you might going to
> > wakeup even more processes.
> 
> Can I just leap in here, as this is extremely relevant to the project
> I am working on. Sometimes you need to step back from what the
> ‘average user’ needs, and consider whether should allow certain
> behaviours to be enabled, even if they are not the default. What is
> ‘nasty’ to you in the big picture, is perfectly normal for me in a
> dedicated use case.
> 
> Our application transfers data between devices (and there could be
> well over a thousand within range at a single time) and the central
> system using purely the MSD in the advertisements. Our linux
> ‘gateway’ boxes need to have continuous reception of advertisements,
> and we don’t care about the power consumption or processing
> implications - that is their dedicated job. We are currently unable
> to migrate our code from some older gatttool derived code to the
> modern APIs because it simply isn’t possible to work in the manner we
> need. (Note that our gateways use multiple BLE dongles, with at least
> one dedicated to receiving beacons while the others are used to
> connect to devices for archived data retrieval.)
> 
> Please give some consideration to the fact that not everybody is
> using bluetooth for simple end-user devices, and whilst these are
> clearly the dominant use case, being able to engage esoteric modes of
> operation allows those of us who need to to consciously engage them
> as necessary for bespoke scenarios/applications. BLE is not just a
> desktop/peripheral technology :)
> 
> Hope you don’t mind the interjection…
> 
> Regards
> 
> Stu

I want to second this as well.  I have a device that always scans and
processes all advertisement packets with manufacture specific data.  I
also constantly am updating the advertisement packets.  Power really is
not a worry here.  In the current design I have I switch between modes
where I use the management interface to perform GATT connections and
then fall back to raw HCI to process the packets.

--Brennan
