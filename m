Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH] Bluetooth: Fix incorrect alignment in Marvell
 BT-over-SDIO driver
From: Marcel Holtmann <marcel@holtmann.org>
To: Bing Zhao <bzhao@marvell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <477F20668A386D41ADCC57781B1F704306CCBCD429@SC-VEXCH1.marvell.com>
References: <1247078654-8666-1-git-send-email-bzhao@marvell.com>
	 <1247079256.9709.2.camel@localhost.localdomain>
	 <477F20668A386D41ADCC57781B1F704306CCBCD429@SC-VEXCH1.marvell.com>
Content-Type: text/plain
Date: Tue, 14 Jul 2009 04:26:44 +0200
Message-Id: <1247538404.4549.15.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

not top-posting please. This is an open source mailing list. We do
things the right way.

> This patch fixed the alignment issue and the compilation warnings on 64-bit system.
> I also tested some basic commands (scan, l2ping, etc.) on my 64-bit HP laptop and they seem working fine.
> 
> Should you have any other commands for testing/verification, or items for cleanup please let me know.

I pushed bluetooth-mrvl-2.6 into bluetooth-next-2.6 to see if any build
fallouts come up.

Regards

Marcel


