Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170313171952.sqmm6fhqranalkf7@Tal>
References: <20170313171952.sqmm6fhqranalkf7@Tal>
From: Barry Byford <31baz66@gmail.com>
Date: Mon, 13 Mar 2017 18:33:23 +0000
Message-ID: <CAAu3APZTmCs8iFWTOEaF8Z-9p+wnUHc5744MS+Th3bBVWC3eTw@mail.gmail.com>
Subject: Re: Integration (-ish) testing with BlueZ D-Bus API
To: Tal <jkarni@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Julian,

On 13 March 2017 at 17:19, Tal <jkarni@gmail.com> wrote:
>
> Hey list,
>
>   I just wrote a little Haskell library wrapping the GATT API [0]. It's been a
> surprisingly smooth experience - thanks for the API and documentation!
>
>   One issue that remains, though, is decent testing. Right now the tests limit
> themselves to calling d-bus methods and just checking that they don't throw an
> error. I don't see how I can do more than that - check that BlueZ in fact
> registered an application with the data I'm expecting, or check that it's
> handling notifications, etc. (Without, that is, pulling out my phone and trying
> it manually.) Tapping into dbus-monitor in some cases would provide some help,
> but everyone who wants to run the tests would need there dbus config files, the
> tests would have to run as root, I'd have to do fairly fragile parsing of the
> logs that would still only approximate the properties I really want to check
> for.
>
>   If I could register an application on a computer and interact with it as if
> it were a remote peripheral (essentially having the computer be both the
> central and the peripheral), then testing would be much easier and more
> comprehensive. In this particular case, I know the communication would only go
> as far as DBus, and not through the hardware layers of the bluetooth stack, but
> that's okay.
>
>   Is this at all possible?

This sounds like the functionality of the DBUS Mock library.
https://github.com/martinpitt/python-dbusmock

There is a BlueZ example/template in the library although they are
slightly out of date with the latest BlueZ.
I have started to work on updating and adding some GATT functionality
although have not got that far.
However it does allow me to run integration tests on GitHub.

>
> [0] http://hackage.haskell.org/package/ble
>
> --
> Julian K. Arni
> Haskell Consultant, Turing Jump
> https://turingjump.com
>
