Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <358D02CA-D849-444D-8CEE-6595ED917BF8@holtmann.org>
References: <CACsJT9OjzHMrMm0Lh8wP--3Z9CD0B5OogFPRa+hEj+aLNfNnjg@mail.gmail.com>
 <358D02CA-D849-444D-8CEE-6595ED917BF8@holtmann.org>
From: Mike Purvis <mpurvis@clearpathrobotics.com>
Date: Fri, 1 May 2015 10:12:11 -0400
Message-ID: <CACsJT9PhQuWQOokSdwMkJvAa1F6LyEMgNZe0JWzdEONYKPSrBg@mail.gmail.com>
Subject: Re: Sixaxis disconnection behaviours
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	Tony Baltovski <tbaltovski@clearpathrobotics.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

I could be wrong, but my understanding of that option is that it
simply pushes the joystick interpretation into userspace, allowing
BlueZ 5 to coexist wit  other tools that manage the specifics of a
particular joystick or other device.

This isn't what I want. I like that the sixaxis has first-class
support including auto-pairing, under modern BlueZ. But I want to
understand better what the intended disconnection behaviour is, and if
there's room to make it do something that would be a better fit for
the needs of those developing and using low-cost robotics.

To be clear, most users using a Bluetooth gamepad are doing so from
the other side of the living room=E2=80=94 they will never encounter the
proposed disconnection behaviours. But for users controlling mobile
robots, it would be helpful to have something a bit most rational than
simply repeating the most recent command.

Mike

On 30 April 2015 at 01:30, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Mike,
>
>> Clearpath Robotics and other users of ROS are working with PlayStation
>> Sixaxis bluetooth pads to teleoperate robotic systems, presently using
>> the qtsixa/sixad utilities. We're contemplating a switch to BlueZ 5
>> for this functionality, but tests are showing problematic behaviour
>> when the controllers go out of range or lose power (battery, etc).
>>
>> The behaviour which we are observing is that the controller goes out
>> of range, and the BlueZ-created dev node continues persisting the last
>> known joystick state--- an obvious safety problem. We would much
>> prefer any (or some combination of) the following to be the behaviour
>> under this circumstance:
>>
>> - Publish nothing, such that a processing selecting on a joystick fd
>> simply times out rather than receiving bogus data.
>> - Remove the dev node.
>> - Publish a known "safe state", such as all buttons unpressed, and
>> axes in the positions they were in upon pairing.
>> - Publish connection status/quality through some side channel.
>>
>> I don't know how universal this is, but at least for the sixaxis,
>> there's a known scheme for detecting disconnections, which you can see
>> in sixad: https://github.com/falkTX/qtsixa/blob/master/sixad/sixad-sixax=
is.cpp#L202
>>
>> In the short term, we can continue using sixad, but for various
>> reasons we'd like to be able to migrate to BlueZ 5, and this is a
>> blocking issue on that path. We don't have a lot of resources to
>> commit to this, but I would be willing to invest some effort given
>> buy-in and design guidance.
>
> if this is going through HID in the end, have you tried to use UserspaceH=
ID=3Dtrue in input.conf.
>
> Regards
>
> Marcel
>
