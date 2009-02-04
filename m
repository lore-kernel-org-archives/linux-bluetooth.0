Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] hci_usb: Add support for OQO Model 01+
From: Marcel Holtmann <marcel@holtmann.org>
To: Jamie Lentin <jm@lentin.co.uk>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <alpine.DEB.2.00.0902041341380.16577@localhost.localdomain>
References: <alpine.DEB.2.00.0902041341380.16577@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 04 Feb 2009 19:30:22 +0100
Message-Id: <1233772222.12562.1.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jamie,

> Add USB device ID for OQO 01+'s internal USB bluetooth

please proof that you really need this by sending in the content
of /proc/bus/usb/devices. Normally Bluetooth devices get identified by
its class descriptor.

Also the hci_usb driver has been replaced by btusb. So please send
patches against that kernel.

Regards

Marcel


