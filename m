Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: Connection failures on Ubuntu
To: Mark Spruiell <mes@zeroc.com>, linux-bluetooth@vger.kernel.org
References: <CABOZqnh3p4NXcGMyeT3UjYH+OdU4phV0bGPtoUJa2KzEZjp5iw@mail.gmail.com>
From: Felipe Ferreri Tonello <eu@felipetonello.com>
Message-ID: <56431E41.6030404@felipetonello.com>
Date: Wed, 11 Nov 2015 10:53:53 +0000
MIME-Version: 1.0
In-Reply-To: <CABOZqnh3p4NXcGMyeT3UjYH+OdU4phV0bGPtoUJa2KzEZjp5iw@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------050309030808010306010006"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------050309030808010306010006
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit

Hi Mark,

On 10/11/15 17:20, Mark Spruiell wrote:
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

I had this type of problem on Ubuntu when trying to register master's
build of bluetoothd to D-Bus on Ubuntu as well and not on Fedora.

Try to tweak /etc/dbus-1/system.d/bluetooth.conf user permissions just
for development.

-- 
Felipe

--------------050309030808010306010006
Content-Type: application/pgp-keys;
 name="0x92698E6A.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0x92698E6A.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2

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3D=3D
=3DVNJV
-----END PGP PUBLIC KEY BLOCK-----

--------------050309030808010306010006--
