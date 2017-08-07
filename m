Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/2] bluecard_cs: fix LED behavior
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170805193445.16411-2-linux@rainbow-software.org>
Date: Mon, 7 Aug 2017 08:37:29 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0AA773B0-D4CC-4150-95AC-6A74D3BADB0C@holtmann.org>
References: <20170805193445.16411-1-linux@rainbow-software.org>
 <20170805193445.16411-2-linux@rainbow-software.org>
To: Ondrej Zary <linux@rainbow-software.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ondrej,

> Keep power LED on during activity.
> 
> LED timer races with power LED disabling in hci_close(), resulting in
> power LED left on after closing.
> Stop LED timer before disabling power LED.
> 
> BTW. On cards without an activity LED, the behavior is a bit weird:
> The LED is on after hci_open() but only until the first data transfer.
> Then it's off in idle and on during activity.
> It could be improved by keeping the LED on in idle and flashing during
> activity.
> 
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
> ---
> drivers/bluetooth/bluecard_cs.c | 13 ++++++++-----
> 1 file changed, 8 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

