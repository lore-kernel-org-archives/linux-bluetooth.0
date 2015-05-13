Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: John Carter <john.carter@taitradio.com>
Date: Wed, 13 May 2015 15:50:29 +1200
Message-ID: <CAFD1m3E73juA0LTUWq7-rt2W0OxdGy7cONMv2e5VRs5zsg_rww@mail.gmail.com>
Subject: Arm compilation error in tools/test-runner.c error: impossible
 constraint in 'asm'
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Building bluez out of git within OpenEmbedded for ARM results in the
following compilation "error impossible constraint in 'asm'"

arm-poky-linux-gnueabi-gcc  -march=armv7-a -marm -mthumb-interwork
-mfloat-abi=hard -mfpu=neon -mtune=cortex-a8
--sysroot=/home/johnc/tt/ViciaHeinox/build/tmp/sysroots/trex
-DHAVE_CONFIG_H -I.  -I./lib
-I/home/johnc/tt/ViciaHeinox/build/tmp/sysroots/trex/usr/include/dbus-1.0
-I/home/johnc/tt/ViciaHeinox/build/tmp/sysroots/trex/usr/lib/dbus-1.0/include
 -I/home/johnc/tt/ViciaHeinox/build/tmp/sysroots/trex/usr/include/glib-2.0
-I/home/johnc/tt/ViciaHeinox/build/tmp/sysroots/trex/usr/lib/glib-2.0/include
  -O2 -pipe -g -feliminate-unused-debug-types -c -o
tools/test-runner.o tools/test-runner.c


| tools/test-runner.c: In function 'start_qemu':
| tools/test-runner.c:224:2: error: impossible constraint in 'asm'
|   __asm__ __volatile__("cpuid" : "=c" (ecx) : "a" (1) : "memory");
|   ^


I believe this was introduced with this commit....

commit a0a03828fbc49db9f0926cee87d53d627d69bac2
Author: Marcel Holtmann <marcel@holtmann.org>
Date:   Mon Apr 6 20:45:39 2015 -0700

    tools: Add fallback if KVM support is not available

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 407a985..163b610 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -195,7 +195,7 @@ static char *const qemu_argv[] = {
        "-no-user-config",
        "-monitor", "none",
        "-display", "none",
-       "-machine", "type=q35,accel=kvm",
+       "-machine", "type=q35,accel=kvm:tcg",
        "-m", "192M",
        "-nographic",
        "-vga", "none",
@@ -215,6 +215,16 @@ static char *const qemu_envp[] = {
        NULL
 };

+static void check_virtualization(void)
+{
+       uint32_t ecx;
+
+       __asm__ __volatile__("cpuid" : "=c" (ecx) : "a" (1) : "memory");
+
+       if (!!(ecx & (1 << 5)))
+               printf("Found support for Virtual Machine eXtensions\n");
+}
+



-- 
John Carter
Phone : (64)(3) 358 6639
Tait Electronics
PO Box 1645 Christchurch
New Zealand

-- 

------------------------------
This email, including any attachments, is only for the intended recipient. 
It is subject to copyright, is confidential and may be the subject of legal 
or other privilege, none of which is waived or lost by reason of this 
transmission.
If you are not an intended recipient, you may not use, disseminate, 
distribute or reproduce such email, any attachments, or any part thereof. 
If you have received a message in error, please notify the sender 
immediately and erase all copies of the message and any attachments.
Unfortunately, we cannot warrant that the email has not been altered or 
corrupted during transmission nor can we guarantee that any email or any 
attachments are free from computer viruses or other conditions which may 
damage or interfere with recipient data, hardware or software. The 
recipient relies upon its own procedures and assumes all risk of use and of 
opening any attachments.
------------------------------
