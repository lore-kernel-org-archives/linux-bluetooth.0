Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH] hciattach: Add support for Marvell Bluetooth device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1453906359-13314-1-git-send-email-akarwar@marvell.com>
Date: Wed, 27 Jan 2016 16:21:04 +0100
Cc: linux-bluetooth@vger.kernel.org, Cathy Luo <cluo@marvell.com>,
	Nishant Sarmukadam <nishants@marvell.com>,
	Ganapathi Bhat <gbhat@marvell.com>
Message-Id: <0AD94556-3D4D-40E7-AB21-CAD84F8869FD@holtmann.org>
References: <1453906359-13314-1-git-send-email-akarwar@marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> This patch enables the Marvell Bluetooth device (UART sku)
> over the H4 protocol. It configures the baudrate and download
> firmware to bring up the device.
> 
> Command syntax: hciattach /dev/ttyUSB0 marvell
> 
> Make sure to place the marvell_hci_uart.conf file in
> /lib/firmware/mrvl/
> 
> This file should contain below info:
> HELPER_FILE_PATH=<full path of helper binary>
> FIRMWARE_FILE_PATH=<full path of firmware binary>
> FIRMWARE_DOWNLOAD_BAUD_RATE=<firmware download baud rate>

I would prefer if you create a drivers/bluetooth/hci_mrvl.c kernel driver that works with btattach. We are trying to phase out hciattach and not add more vendor specifics.

For at least Intel and Broadcom hardware we have full in kernel support for firmware loading and configuration. And the benefit is that code can be shared between UART and USB.

Regards

Marcel

