Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/4 v3] bluetooth: add btmrvl driver to support Marvell
 bluetooth devices
From: Marcel Holtmann <marcel@holtmann.org>
To: Bing Zhao <bzhao@marvell.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1243978178-3403-1-git-send-email-bzhao@marvell.com>
References: <1243978178-3403-1-git-send-email-bzhao@marvell.com>
Content-Type: text/plain
Date: Tue, 09 Jun 2009 17:20:07 +0200
Message-Id: <1244560807.3068.12.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> This driver provides basic definitions and library functions to
> support Marvell Bluetooth enabled devices, such as 88W8688 WLAN/BT
> combo chip.

so I created a bluetooth-mrvl-2.6 tree with your patches and already a
major collection of cleanup patches.

The biggest problem right now is that your driver spits out casting
warnings like crazy. This is not acceptable. So please send me a patch
to fix these based on bluetooth-mrvl-2.6.

I did fix the firmware non-sense you had in there, but I haven't had
time to test it with real hardware. So please do so.

Also I am considering to just remove all this Enter/Leave debug
non-sense since it makes the code really hard to read.

Regards

Marcel


