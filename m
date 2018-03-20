Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] Bluetooth: btusb: Add USB ID 7392:a611 for Edimax
 EW-7611ULB
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180316214537.1540-1-vicencb@gmail.com>
Date: Tue, 20 Mar 2018 09:42:06 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <CA64719F-6732-4683-ACC6-AF82733384C3@holtmann.org>
References: <20180316214537.1540-1-vicencb@gmail.com>
To: Vicente Bergas <vicencb@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vicente,

> This WiFi/Bluetooth USB dongle uses a Realtek chipset, so, use btrtl for it.
> 
> Product information:
> https://wikidevi.com/wiki/Edimax_EW-7611ULB

please include the content of /sys/kernel/debug/usb/devices for this device in the commit message.

Regards

Marcel

