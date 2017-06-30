Return-Path: <ian@mnementh.co.uk>
Subject: Re: BCM43430 BT driver almost working...
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Loic Poulain <loic.poulain@intel.com>, linux-bluetooth@vger.kernel.org
References: <c4cf0689-d28e-492d-399e-968a70488e22@mnementh.co.uk>
 <d65a5225-84f5-11ae-d9ab-2175480552d8@intel.com>
 <d0c4a580-82ac-d710-8678-f147ce81a9ce@mnementh.co.uk>
 <F9B6438D-2D83-46BD-AE63-DBECB3A0B9A1@holtmann.org>
From: Ian Molton <ian@mnementh.co.uk>
Message-ID: <4078da55-c5d8-7c2d-d954-9da790982b22@mnementh.co.uk>
Date: Fri, 30 Jun 2017 18:14:46 +0100
MIME-Version: 1.0
In-Reply-To: <F9B6438D-2D83-46BD-AE63-DBECB3A0B9A1@holtmann.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 30/06/17 18:02, Marcel Holtmann wrote:
> If you have an embedded board with a proper DT definition, and the
> UART is hard-wired to the Bluetooth chip, then go for serdev. It
> means no btattach is needed. The kernel will enumerate this properly
> for you. That is the way forward. Someone needed to adapt the
> hci_bcm.c driver for this anyway. It just happens that you are the
> first one.

Right - I'll follow that route and add serdev support to hci_bcm.c then!

Thanks,

-Ian
