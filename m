Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2] bluetooth: Add support Bluetooth controller of
 MacbookPro 6,2
From: Marcel Holtmann <marcel@holtmann.org>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: linux-bluetooth@vger.kernel.org, stable@kernel.org
In-Reply-To: <1282197259-16609-1-git-send-email-iwamatsu@nigauri.org>
References: <1282197259-16609-1-git-send-email-iwamatsu@nigauri.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 19 Aug 2010 10:11:10 +0200
Message-ID: <1282205470.23399.156.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nobuhiro.

> Bluetooth controller of MacbookPro 6,2 does not work.
> Because Device Class of these controllers was set 255 (Vendor Sepecific Class).
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

it would be nice if you include the output from /proc/bus/usb/devices or
usb-devices.sh script to proof the different device class.

Regards

Marcel


