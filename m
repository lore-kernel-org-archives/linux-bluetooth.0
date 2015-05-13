Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: Arm compilation error in tools/test-runner.c error: impossible constraint in 'asm'
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAFD1m3E73juA0LTUWq7-rt2W0OxdGy7cONMv2e5VRs5zsg_rww@mail.gmail.com>
Date: Wed, 13 May 2015 15:42:50 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <DE23B8FA-28E3-4E55-AB1E-6FBD552881E2@holtmann.org>
References: <CAFD1m3E73juA0LTUWq7-rt2W0OxdGy7cONMv2e5VRs5zsg_rww@mail.gmail.com>
To: John Carter <john.carter@taitradio.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

> Building bluez out of git within OpenEmbedded for ARM results in the
> following compilation "error impossible constraint in 'asm'"
> 
> arm-poky-linux-gnueabi-gcc  -march=armv7-a -marm -mthumb-interwork
> -mfloat-abi=hard -mfpu=neon -mtune=cortex-a8
> --sysroot=/home/johnc/tt/ViciaHeinox/build/tmp/sysroots/trex
> -DHAVE_CONFIG_H -I.  -I./lib
> -I/home/johnc/tt/ViciaHeinox/build/tmp/sysroots/trex/usr/include/dbus-1.0
> -I/home/johnc/tt/ViciaHeinox/build/tmp/sysroots/trex/usr/lib/dbus-1.0/include
> -I/home/johnc/tt/ViciaHeinox/build/tmp/sysroots/trex/usr/include/glib-2.0
> -I/home/johnc/tt/ViciaHeinox/build/tmp/sysroots/trex/usr/lib/glib-2.0/include
>  -O2 -pipe -g -feliminate-unused-debug-types -c -o
> tools/test-runner.o tools/test-runner.c
> 
> 
> | tools/test-runner.c: In function 'start_qemu':
> | tools/test-runner.c:224:2: error: impossible constraint in 'asm'
> |   __asm__ __volatile__("cpuid" : "=c" (ecx) : "a" (1) : "memory");
> |   ^
> 
> 
> I believe this was introduced with this commit....
> 
> commit a0a03828fbc49db9f0926cee87d53d627d69bac2
> Author: Marcel Holtmann <marcel@holtmann.org>
> Date:   Mon Apr 6 20:45:39 2015 -0700
> 
>    tools: Add fallback if KVM support is not available
> 
> diff --git a/tools/test-runner.c b/tools/test-runner.c
> index 407a985..163b610 100644
> --- a/tools/test-runner.c
> +++ b/tools/test-runner.c
> @@ -195,7 +195,7 @@ static char *const qemu_argv[] = {
>        "-no-user-config",
>        "-monitor", "none",
>        "-display", "none",
> -       "-machine", "type=q35,accel=kvm",
> +       "-machine", "type=q35,accel=kvm:tcg",
>        "-m", "192M",
>        "-nographic",
>        "-vga", "none",
> @@ -215,6 +215,16 @@ static char *const qemu_envp[] = {
>        NULL
> };
> 
> +static void check_virtualization(void)
> +{
> +       uint32_t ecx;
> +
> +       __asm__ __volatile__("cpuid" : "=c" (ecx) : "a" (1) : "memory");
> +
> +       if (!!(ecx & (1 << 5)))
> +               printf("Found support for Virtual Machine eXtensions\n");
> +}
> +

just make this check IA specific so that on ARM architectures it compiles to nothing.

Regards

Marcel

