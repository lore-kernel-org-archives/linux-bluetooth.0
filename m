Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 May 2013 19:08:23 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Alistair Buxton <a.j.buxton@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add Lite-On Technology Corp [04ca:3002] as
 AR3011.
Message-ID: <20130503220823.GA2311@joana>
References: <1367507755-25021-1-git-send-email-a.j.buxton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367507755-25021-1-git-send-email-a.j.buxton@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alistair,

* Alistair Buxton <a.j.buxton@gmail.com> [2013-05-02 16:15:55 +0100]:

> A user reported this device not working. After looking at the related IDs
> I took a shot in the dark, and the user reports it works with this patch.
> 
> The device is in an Asus K53U with internal bluetooth and ath9k wireless.

Please add the output of /sys/kernel/debug/usb/devices of this specific device
to the commit message. We need to log this properly. Also, a Tested-by tag by
the user would be helpful too. Thanks.

	Gustavo
