Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: Fix autosuspend PM for Lenovo
 ThinkPad 8
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20161009135105.7970-1-jerome.debretagne@gmail.com>
Date: Sun, 9 Oct 2016 21:48:00 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <CDF002FD-84E8-4805-80CB-54D7D5BA9442@holtmann.org>
References: <20161009135105.7970-1-jerome.debretagne@gmail.com>
To: =?utf-8?Q?J=C3=A9r=C3=B4me_de_Bretagne?=
        <jerome.debretagne@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerome,

> ACPI table for BCM2E55 of Lenovo ThinkPad 8 is not correct.
> Set correctly IRQ polarity for this device, fixing the issue of bluetooth
> never resuming after autosuspend PM.
> 
> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> ---
> drivers/bluetooth/hci_bcm.c | 8 ++++++++
> 1 file changed, 8 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

