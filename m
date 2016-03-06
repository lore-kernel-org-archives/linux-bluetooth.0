Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Mike <mailinglists@in-box.at>
Subject: Using bluez 5.37 with Raspberry Pi 3
Message-ID: <56DCA644.5070806@in-box.at>
Date: Sun, 6 Mar 2016 22:51:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I tried using bluez 5.37 and compiled it from source. I found that when
hciattach is used, it obviously refers to the wrong firmware directory
when using the BCM43xx chipset. Which is /etc/firmware and should be
/lib/firmware.

I was wondering and downloaded the source of bluez from the distribution
package and took a look at hciattach_bcm43xx.c and found that it was not
patched. And I couldn't find any other definition of FIRMWARE_DIR, that
would point to /lib/firmware.

So how was it done? Since the distribution package of bluez loads the
firmware from /lib/firmware. And then, how can I solve this? Do I have
to patch/change the source code before compiling, or is there a
configure switch (couldn't find something with --help), or would you
suggest to put a symbolic link in /etc/firmware?

Best regards
Mike
