Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] Bluetooth: btusb: Add additional device ID for RTL8822BE
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180527214402.12831-1-velemas@gmail.com>
Date: Wed, 30 May 2018 08:17:17 +0200
Cc: Hon Weng Chong <honwchong@gmail.com>, Larry.Finger@lwfinger.net,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <6BC33699-4306-4EE9-A290-B5845A402C4C@holtmann.org>
References: <20180527214402.12831-1-velemas@gmail.com>
To: Artiom Vaskov <velemas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Artiom,

> The Asus ROG GL702ZC laptop contains a Realtek RTL8822BE device with
> an associated BT chip using a USB ID of 13d3:3526. This ID is added
> to the driver.

please include the /sys/kernel/debug/usb/devices portion for this device in the commit messages.

Regards

Marcel
