Return-Path: <cyrus@holtmann.org>
Subject: Re: question on btusb_open()
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <200808191425.50406.oliver@neukum.org>
References: <200808191425.50406.oliver@neukum.org>
Content-Type: text/plain
Date: Tue, 19 Aug 2008 14:36:14 +0200
Message-Id: <1219149374.7591.132.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> if this function is reentered there's a race with the error path. Can
> it be reentered?

no. The Bluetooth core will protect against it. The open callback will
be triggered by "hciconfig hci0 up" or hcid/bluetoothd.

Regards

Marcel


