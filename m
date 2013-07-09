Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: Bluez with uclibc
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <747C1E83C744F44E9ACFB89FAEEC2C7B2423BF98D1@EXDCVYMBSTM005.EQ1STM.local>
Date: Tue, 9 Jul 2013 01:37:21 -0700
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <6A113901-6E17-4A10-8E5A-9F89E81C3021@holtmann.org>
References: <747C1E83C744F44E9ACFB89FAEEC2C7B2414E86034@EXDCVYMBSTM005.EQ1STM.local> <601DC609-FB98-4A61-89E1-2EBC8639F667@holtmann.org> <747C1E83C744F44E9ACFB89FAEEC2C7B2423BF98D1@EXDCVYMBSTM005.EQ1STM.local>
To: Julien COUVRAND <julien.couvrand@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Julien,

please do not top post on this mailing list.

> Sure.
> As soon as i compile Buildroot deactivating MMU dependencies into Config.in from bluez-utils package such as:
> 
> --
> config BR2_PACKAGE_BLUEZ_UTILS
> 	bool "bluez-utils"
> 	depends on !BR2_avr32
> 	depends on BR2_USE_WCHAR # libglib2
> 	depends on BR2_TOOLCHAIN_HAS_THREADS # dbus, alsa-lib
> 	# depends on BR2_USE_MMU # dbus
> 	select BR2_PACKAGE_DBUS
> 	select BR2_PACKAGE_LIBGLIB2
> 	help
> 	  bluez utils
> --
> 
> I have got following compilation errors:
> 
> --
> ../dbus/.libs/libdbus-internal.a(libdbus_internal_la-dbus-sysdeps-util-unix.o): In function `_dbus_become_daemon':
> dbus-sysdeps-util-unix.c:(.text+0x530): undefined reference to `fork'
> ../dbus/.libs/libdbus-internal.a(libdbus_internal_la-dbus-spawn.o): In function `_dbus_spawn_async_with_babysitter':
> dbus-spawn.c:(.text+0xe38): undefined reference to `fork'
> dbus-spawn.c:(.text+0xea0): undefined reference to `fork'
> collect2: error: ld returned 1 exit status
> make[3]: *** [dbus-daemon] Error 1
> make[3]: *** Waiting for unfinished jobs....
> ../dbus/.libs/libdbus-internal.a(libdbus_internal_la-dbus-sysdeps-util-unix.o): In function `_dbus_become_daemon':
> dbus-sysdeps-util-unix.c:(.text+0x530): undefined reference to `fork'
> collect2: error: ld returned 1 exit status
> make[3]: *** [dbus-daemon-launch-helper] Error 1
> --
> 
> So, currently, using uclibc for bluez, without MMU activation, I can't compile Buildroot due dBus and the "fork".

you might want to check with the D-Bus people since this is not a BlueZ issue.

Regards

Marcel

