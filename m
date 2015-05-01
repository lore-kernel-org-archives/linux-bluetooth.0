Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: Sixaxis disconnection behaviours
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CACsJT9PhQuWQOokSdwMkJvAa1F6LyEMgNZe0JWzdEONYKPSrBg@mail.gmail.com>
Date: Fri, 1 May 2015 08:56:27 -0700
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>,
	Tony Baltovski <tbaltovski@clearpathrobotics.com>
Message-Id: <74342EA8-331E-43EB-BE38-456F9E64BA2E@holtmann.org>
References: <CACsJT9OjzHMrMm0Lh8wP--3Z9CD0B5OogFPRa+hEj+aLNfNnjg@mail.gmail.com> <358D02CA-D849-444D-8CEE-6595ED917BF8@holtmann.org> <CACsJT9PhQuWQOokSdwMkJvAa1F6LyEMgNZe0JWzdEONYKPSrBg@mail.gmail.com>
To: Mike Purvis <mpurvis@clearpathrobotics.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

please do not top post on this mailing list.

> I could be wrong, but my understanding of that option is that it
> simply pushes the joystick interpretation into userspace, allowing
> BlueZ 5 to coexist wit  other tools that manage the specifics of a
> particular joystick or other device.
> 
> This isn't what I want. I like that the sixaxis has first-class
> support including auto-pairing, under modern BlueZ. But I want to
> understand better what the intended disconnection behaviour is, and if
> there's room to make it do something that would be a better fit for
> the needs of those developing and using low-cost robotics.
> 
> To be clear, most users using a Bluetooth gamepad are doing so from
> the other side of the living room— they will never encounter the
> proposed disconnection behaviours. But for users controlling mobile
> robots, it would be helpful to have something a bit most rational than
> simply repeating the most recent command.

the UserspaceHID option means that the transport is done in userspace. The interpretation of HID packets is still done via the kernel HID subsystem. It is purely the transport that moved from kernel space into userspace.

This means actually that userspace can keep the HID device / input device actively while it tries to re-connect the transport. Our current kernel implementation does not allow this since the transport and the HID device are bundled together.

Regards

Marcel

