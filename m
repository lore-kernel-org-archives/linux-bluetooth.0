Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Ferdinand Rau <rauferd@web.de>
Subject: Typo in firmware file name for BCM4354A2?
To: linux-bluetooth@vger.kernel.org
Message-ID: <843b7b0e-03d5-c794-d372-860f99da6684@web.de>
Date: Thu, 7 Sep 2017 14:59:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have a Wortmann / Terra mobile 360-11 netbook with a Broadcom bluetooth/wifi chipset BCM4356A2, running Debian 10 buster (testing), linux kernel 4.11.0:
> $ lspci -nnn | grep Broadcom
> 02:00.0 Network controller [0280]: Broadcom Limited BCM4356 802.11ac Wireless Network Adapter [14e4:43ec] (rev 02)

When loading the appropriate kernel module, it complains about a missing firmware file called "BCM4354A2-13d3-3485.hcd" (note the 4354 instead of 4356!):
> bluetooth hci0: Direct firmware load for brcm/BCM4354A2-13d3-3485.hcd failed with error -2
To my knowledge, a file called "BCM4354A2-13d3-3485.hcd" does not exist.

The solution for me was to use (=rename) the file "BCM4356A2-13d3-3485.hcd" instead (note the 4356 vs. 4354!), which actually matches the device name as reported by lspci.

Could this be a typo in the kernel sources, requesting the wrong firmware file?
Please check/correct if necessary.


In case any further information is required to investigate this, feel free to contact me.


P.S.: For details on how to get bluetooth working with this chipset, see also this thread:
https://github.com/winterheart/broadcom-bt-firmware/issues/3
as well as the linux wireless page on the wifi 802.11 part of the same device (the NVRAM part is also required for blueetooth):
https://wireless.wiki.kernel.org/en/users/drivers/brcm80211#nvram_from_efi
