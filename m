Return-Path: <cyrus@holtmann.org>
From: Randy Yates <yates@digitalsignallabs.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: bluez 5.2 build problem
References: <87d2w9zsnw.fsf@randy.site>
Date: Sat, 09 Feb 2013 05:31:42 -0500
In-Reply-To: <87d2w9zsnw.fsf@randy.site> (Randy Yates's message of "Sat, 09
	Feb 2013 05:29:55 -0500")
Message-ID: <8738x5zskx.fsf@randy.site>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PS: The target kernel is a patched 3.7.4 from Robert Nelson's
distribution.

--Randy

Randy Yates <yates@digitalsignallabs.com> writes:

> After configuring with the attached config.log, I'm getting the
> following error during build:
>
>   CC     btio/bluetoothd-btio.o
> btio/btio.c: In function 'bt_io_get_type':
> btio/btio.c:109:35: error: 'SO_DOMAIN' undeclared (first use in this function)
> btio/btio.c:109:35: note: each undeclared identifier is reported only once for each function it appears in
> btio/btio.c:123:35: error: 'SO_PROTOCOL' undeclared (first use in this function)
> make[3]: *** [btio/bluetoothd-btio.o] Error 1
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/home/embedded-linux/tool/ti-sdk/bluez/bluez-5.2'
> make[1]: *** [make] Error 2
> make[1]: Leaving directory `/home/embedded-linux/tool/ti-sdk/bluez'
> make: *** [bluez] Error 2
>
> I checked the kernel/usr/include/sys/socket.h and it does not have
> SO_DOMAIN defined. I am using a fresh (cross-)build of glibc-2.17.
>
> Note that I am cross-compiling for the beagle-board xm using TI's Arago
> cross-compiler tools.
>
> Am I missing something obvious, or is this a build bug?

-- 
Randy Yates
Digital Signal Labs
http://www.digitalsignallabs.com
