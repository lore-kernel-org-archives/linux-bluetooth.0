Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] Bluetooth: btusb: Support for QCA61x4 on Samsung
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1432017670-6024-1-git-send-email-chanyeol.park@samsung.com>
Date: Tue, 19 May 2015 20:21:15 +0200
Cc: linux-bluetooth@vger.kernel.org,
	Chan-yeol Park <chanyeol.park@samsung.com>
Message-Id: <D5B20D85-8B5F-4694-8B5E-2BFC670BE85C@holtmann.org>
References: <1432017670-6024-1-git-send-email-chanyeol.park@samsung.com>
To: chanyeol.park@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-yeol,

> The previous commit(3267c88) regressed QCA61x4 BT on Samsung because
> its device info is missed in qca_devices_table[], so btusb_open()
> return error unexpectedly.

how does this regress. We never had QCA module support in the first place. The patch looks good, I was just wondering what the regression will be here?

Regards

Marcel

