Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: Sixaxis disconnection behaviours
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CACsJT9OjzHMrMm0Lh8wP--3Z9CD0B5OogFPRa+hEj+aLNfNnjg@mail.gmail.com>
Date: Wed, 29 Apr 2015 22:30:47 -0700
Cc: linux-bluetooth@vger.kernel.org,
	Tony Baltovski <tbaltovski@clearpathrobotics.com>
Message-Id: <358D02CA-D849-444D-8CEE-6595ED917BF8@holtmann.org>
References: <CACsJT9OjzHMrMm0Lh8wP--3Z9CD0B5OogFPRa+hEj+aLNfNnjg@mail.gmail.com>
To: Mike Purvis <mpurvis@clearpathrobotics.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

> Clearpath Robotics and other users of ROS are working with PlayStation
> Sixaxis bluetooth pads to teleoperate robotic systems, presently using
> the qtsixa/sixad utilities. We're contemplating a switch to BlueZ 5
> for this functionality, but tests are showing problematic behaviour
> when the controllers go out of range or lose power (battery, etc).
> 
> The behaviour which we are observing is that the controller goes out
> of range, and the BlueZ-created dev node continues persisting the last
> known joystick state--- an obvious safety problem. We would much
> prefer any (or some combination of) the following to be the behaviour
> under this circumstance:
> 
> - Publish nothing, such that a processing selecting on a joystick fd
> simply times out rather than receiving bogus data.
> - Remove the dev node.
> - Publish a known "safe state", such as all buttons unpressed, and
> axes in the positions they were in upon pairing.
> - Publish connection status/quality through some side channel.
> 
> I don't know how universal this is, but at least for the sixaxis,
> there's a known scheme for detecting disconnections, which you can see
> in sixad: https://github.com/falkTX/qtsixa/blob/master/sixad/sixad-sixaxis.cpp#L202
> 
> In the short term, we can continue using sixad, but for various
> reasons we'd like to be able to migrate to BlueZ 5, and this is a
> blocking issue on that path. We don't have a lot of resources to
> commit to this, but I would be willing to invest some effort given
> buy-in and design guidance.

if this is going through HID in the end, have you tried to use UserspaceHID=true in input.conf.

Regards

Marcel

