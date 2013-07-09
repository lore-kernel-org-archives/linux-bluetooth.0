Return-Path: <cyrus@holtmann.org>
From: Julien COUVRAND <julien.couvrand@stericsson.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 9 Jul 2013 09:58:18 +0200
Subject: RE: Bluez with uclibc
Message-ID: <747C1E83C744F44E9ACFB89FAEEC2C7B2423BF98D1@EXDCVYMBSTM005.EQ1STM.local>
References: <747C1E83C744F44E9ACFB89FAEEC2C7B2414E86034@EXDCVYMBSTM005.EQ1STM.local>
 <601DC609-FB98-4A61-89E1-2EBC8639F667@holtmann.org>
In-Reply-To: <601DC609-FB98-4A61-89E1-2EBC8639F667@holtmann.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Sure.
As soon as i compile Buildroot deactivating MMU dependencies into Config.in=
 from bluez-utils package such as:

--
config BR2_PACKAGE_BLUEZ_UTILS
	bool "bluez-utils"
	depends on !BR2_avr32
	depends on BR2_USE_WCHAR # libglib2
	depends on BR2_TOOLCHAIN_HAS_THREADS # dbus, alsa-lib
	# depends on BR2_USE_MMU # dbus
	select BR2_PACKAGE_DBUS
	select BR2_PACKAGE_LIBGLIB2
	help
	  bluez utils
--

I have got following compilation errors:

--
../dbus/.libs/libdbus-internal.a(libdbus_internal_la-dbus-sysdeps-util-unix=
.o): In function `_dbus_become_daemon':
dbus-sysdeps-util-unix.c:(.text+0x530): undefined reference to `fork'
../dbus/.libs/libdbus-internal.a(libdbus_internal_la-dbus-spawn.o): In func=
tion `_dbus_spawn_async_with_babysitter':
dbus-spawn.c:(.text+0xe38): undefined reference to `fork'
dbus-spawn.c:(.text+0xea0): undefined reference to `fork'
collect2: error: ld returned 1 exit status
make[3]: *** [dbus-daemon] Error 1
make[3]: *** Waiting for unfinished jobs....
../dbus/.libs/libdbus-internal.a(libdbus_internal_la-dbus-sysdeps-util-unix=
.o): In function `_dbus_become_daemon':
dbus-sysdeps-util-unix.c:(.text+0x530): undefined reference to `fork'
collect2: error: ld returned 1 exit status
make[3]: *** [dbus-daemon-launch-helper] Error 1
--

So, currently, using uclibc for bluez, without MMU activation, I can't comp=
ile Buildroot due dBus and the "fork".


Julien


Julien COUVRAND
MOPI - 8540 SWPF Object Leader
---------------------------------------------------------------------------=
---------

Mailto:=A0=A0=A0=A0 11 rue Pierre-Felix Delarue
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 72100 Le Mans -=
=A0 FRANCE
Office:=A0=A0=A0=A0=A0 +33 2 44 02 71 07
Mobile: =A0=A0 +33 6 03 49 09 04=20
Emailto :=A0=A0 julien.couvrand@stericsson.com
---------------------------------------------------------------------------=
----------
This communication is confidential and intended solely for the addressee(s)=
. Any unauthorized review, use, disclosure or distribution is prohibited. I=
f you believe this message has been sent to you in error, please notify the=
 sender by replying to this transmission and delete the message without dis=
closing it. Thank you.

E-mail including attachments is susceptible to data corruption, interceptio=
n, unauthorized amendment, tampering and viruses, and we only send and rece=
ive emails on the basis that we are not liable for any such corruption, int=
erception, amendment, tampering or viruses or any consequences thereof.


-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]=20
Sent: lundi 8 juillet 2013 21:03
To: Julien COUVRAND
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Bluez with uclibc

Hi Julien,

> Today, I need to cross compile Bluez for arm with uclibc library into Bui=
ldroot environment.=20
> However, I meet some dependencies between bluez-utils package and MMU dea=
ctivation due to dBus.
>=20
> Do you know a way to use Bluez with uclibc library?

you need to be more specific. I know from projects successfully building Bl=
ueZ with uclibc in the past, but I am not doing such thing on a daily basis=
. So things might have changed. What are the logs or errors you see?

Regards

Marcel
