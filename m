Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Improve the throughput by increasing the
 frame size
From: Marcel Holtmann <marcel@holtmann.org>
To: Vikram Kandukuri <vkandukuri@atheros.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20090702090147.GA9790@atheros-laptop>
References: <20090702090147.GA9790@atheros-laptop>
Content-Type: text/plain
Date: Sat, 04 Jul 2009 11:43:02 -0700
Message-Id: <1246732982.12994.211.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikram,

> Subject: [PATCH] Bluetooth: Improve the throughput by increasing the frame size
> 
> This patch increases the receive buffer size to HCI_MAX_FRAME_SIZE
> which improves the Rx throughput considerably.
> 
> Tested against BRM/Atheros/CSR USB Dongles with PAN profile using
> iperf and chariot. This gave significant (around 40%) increase
> in performance (increased from 0.8 to 1.5 Mb/s in Sheld room)

patch has been applied. Thanks.

Regards

Marcel


