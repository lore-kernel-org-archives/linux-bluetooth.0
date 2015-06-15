Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: Build error -in -next due to 'Bluetooth: hci_uart: Support operational speed during setup'
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <557ED81D.7090908@roeck-us.net>
Date: Mon, 15 Jun 2015 15:58:46 +0200
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Frederic Danis <frederic.danis@linux.intel.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	linux-serial@vger.kernel.org
Message-Id: <7CF3D545-DAE4-4510-9726-5D40740DDC5D@holtmann.org>
References: <557ED81D.7090908@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Guenter,

> alpha:allmodconfig fails to build in -next with
> 
> drivers/bluetooth/hci_ldisc.c: In function 'hci_uart_set_baudrate':
> drivers/bluetooth/hci_ldisc.c:276:22: error: 'BOTHER' undeclared
> 
> BOTHER is not defined for all architectures and otherwise only
> used with '#ifdef BOTHER'.

thanks for the report. Is this something that should be #ifdef at the using side or maybe just fixed for the other architectures.

Regards

Marcel

