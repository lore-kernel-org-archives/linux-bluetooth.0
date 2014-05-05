Return-Path: <cyrus@holtmann.org>
Date: Mon, 5 May 2014 10:37:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sejo Ruiz <sejoruiz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Problems running the tests in BlueZ 5.18
Message-ID: <20140505073728.GA24502@t440s.lan>
References: <1399056781.24457.6.camel@SejoLaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399056781.24457.6.camel@SejoLaptop>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sejo,

On Fri, May 02, 2014, Sejo Ruiz wrote:
> This is the first mail that I write to this mailing list, so I'm not
> sure how this works exactly. I need to develop an application with a
> bluetooth dongle that makes use of the thermometer profile. The thing is
> that, after succesfully pair and connect with the device, whenever I try
> to run the test-therometer file, I obtain the following error:
> 
> dbus.exceptions.DBusException: org.freedesktop.DBus.Error.UnknownMethod:
> Method "RegisterWatcher" with signature "s" on interface
> "org.bluez.ThermometerManager1" doesn't exist
> 
> I have also tested the test-heartrate, and I obtain something similar:
> 
> dbus.exceptions.DBusException: org.freedesktop.DBus.Error.UnknownMethod:
> Method "RegisterWatcher" with signature "s" on interface
> "org.bluez.HeartRateManager1" doesn't exist
> 
> I have succesfully tested the dongle with bluetoothctl, so I can discard
> hardware compatibilities issues.
> I'd like to know if I'm missing something while running the tests. If
> you need more data, like some configuration files or logs, you can ask
> for it and i'll provide it ASAP.
> Thank you very much for your help.

First thing that comes to mind: have you passed --enable-experimental to
configure when building BlueZ, and have you passed -E to bluetoothd when
running it? At least the former is needed for the thermometer plugin
(about the latter I'm not completely sure).

Johan
