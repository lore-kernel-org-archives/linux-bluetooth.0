Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABOZqnh3p4NXcGMyeT3UjYH+OdU4phV0bGPtoUJa2KzEZjp5iw@mail.gmail.com>
References: <CABOZqnh3p4NXcGMyeT3UjYH+OdU4phV0bGPtoUJa2KzEZjp5iw@mail.gmail.com>
Date: Fri, 13 Nov 2015 16:51:54 -0800
Message-ID: <CABOZqngFWY77qM3-cjFxmSjZ=gZekbqD+Ow3Z3koqTjrhQRvLQ@mail.gmail.com>
Subject: Re: Connection failures on Ubuntu
From: Mark Spruiell <mes@zeroc.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Just to follow up on my own post...

On Tue, Nov 10, 2015 at 9:20 AM, Mark Spruiell <mes@zeroc.com> wrote:
> I'm not able to connect to a service running on Ubuntu 15.10. The
> system-provided BlueZ version is 5.35.
>
> I can reproduce it using the test scripts. On Ubuntu:
>
> ./test-profile -s -u b85280dd-b78a-4a45-be4b-b6fec4abd86f -n "Test Server" -C 5
>
> sdptool shows the service:
>
> Service Name: Test Server
> Service RecHandle: 0x10009
> Service Class ID List:
>   UUID 128: b85280dd-b78a-4a45-be4b-b6fec4abd86f
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>   "RFCOMM" (0x0003)
>     Channel: 5
>
> On a different host (this one running Fedora 22 with BlueZ 5.29), I
> start a client:
>
> ./test-profile -u b85280dd-b78a-4a45-be4b-b6fec4abd86f -c
>
> and then
>
> ./test-device connect <ubuntu-addr> b85280dd-b78a-4a45-be4b-b6fec4abd86f
> Traceback (most recent call last):
>   File "./test-device", line 104, in <module>
>     device.ConnectProfile(args[2])
>   File "/usr/lib64/python2.7/site-packages/dbus/proxies.py", line 70,
> in __call__
>     return self._proxy_method(*args, **keywords)
>   File "/usr/lib64/python2.7/site-packages/dbus/proxies.py", line 145,
> in __call__
>     **keywords)
>   File "/usr/lib64/python2.7/site-packages/dbus/connection.py", line
> 651, in call_blocking
>     message, timeout)
> dbus.exceptions.DBusException: org.bluez.Error.Failed: Connection refused
>
> Other times I will get:
>
> dbus.exceptions.DBusException: org.bluez.Error.Failed: Resource
> temporarily unavailable
>
> These hosts are already paired. Things work fine when both hosts are
> using Fedora 22.
>
> Any suggestions on how I can diagnose this further?
>
> Thanks,
> Mark

When attempting to connect the profile, I noticed messages in the
Ubuntu system log such as:

bluetoothd[65069]: Authentication attempt without agent
bluetoothd[65069]: Test Server rejected <fedora-bdaddr>:
org.bluez.Error.Rejected

So I used bluetoothctl to configure the <fedora-bdaddr> device as
trusted. Instead of 'Connection refused' messages, the Fedora client
would now get 'Connection reset by peer'. There was nothing obvious in
the logs on either machine but I can post them if necessary.

I decided to try other versions of BlueZ to see if it made any
difference. I built and installed the following from source on Ubuntu
15.10:

v5.36: segfault on bluetoothd startup
v5.34: same failure behavior as 5.35 above
v5.33: same failure behavior as 5.35 above
v5.32: same failure behavior as 5.35 above
v5.31: same failure behavior as 5.35 above
v5.30: works!

I compared the v5.30 and v5.31 sources to see if anything stood out. I
noticed this entry in the ChangeLog:

> Fix issue with profile connections from remote devices.

Sounds like it might be relevant to my situation. Is there any more
information on this issue?

Mark
