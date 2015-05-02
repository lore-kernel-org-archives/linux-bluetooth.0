Return-Path: <cyrus@holtmann.org>
Message-ID: <554504B2.1050404@gmail.com>
Date: Sat, 02 May 2015 20:09:06 +0300
From: Dmitry Tunin <hanipouspilot@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: No firmware for some AR3012 chips
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Please look at https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1024884

It looks like ath3k is looking for some different firmware files.
AthrBT_0x11020100.dfu
ramps_0x11020100_40.dfu

Linux-firmware does not contain these files. It must be some new version of the firmware.
And should a patch for this device is sent?

Regards,

Dmitry
