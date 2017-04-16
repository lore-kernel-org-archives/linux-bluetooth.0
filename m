Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: hci_ll: Fix NULL pointer deref on FW upload
 failure
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170415215413.15648-1-sre@kernel.org>
Date: Sun, 16 Apr 2017 20:32:39 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Message-Id: <FC7C39A6-71E0-4A1E-8E57-4D97B0ADB719@holtmann.org>
References: <20170415194854.byado7bxupbdhivp@earth>
 <20170415215413.15648-1-sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

> Avoid NULL pointer dereference occurring due to freeing
> skb containing an error pointer. It can easily be triggered
> by using the driver with broken uart (i.e. due to misconfigured
> pinmuxing).
> 
> Fixes: 371805522f87 ("bluetooth: hci_uart: add LL protocol serdev driver support")
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
> drivers/bluetooth/hci_ll.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

