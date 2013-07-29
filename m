Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH] Bluetooth: btmrvl: add calibration data download support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1375126147-28642-1-git-send-email-bzhao@marvell.com>
Date: Mon, 29 Jul 2013 13:35:41 -0700
Cc: <linux-bluetooth@vger.kernel.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	<linux-wireless@vger.kernel.org>,
	Amitkumar Karwar <akarwar@marvell.com>
Message-Id: <39BF90E7-8341-412E-A372-6039B703980D@holtmann.org>
References: <1375126147-28642-1-git-send-email-bzhao@marvell.com>
To: Bing Zhao <bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> A text file containing calibration data in hex format can
> be provided while loading btmrvl module. The data will be
> downloaded to firmware.
> eg. insmod btmrvl.ko cal_data_cfg=mrvl/bt_cal_data.conf

why is this a module parameter and you do not just request a standard location via request_firmware(). I do not like the module parameter approach.

Regards

Marcel

