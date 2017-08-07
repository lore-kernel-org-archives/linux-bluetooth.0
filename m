Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] bluecard_cs: blink LED during continuous activity
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170807173549.527-1-linux@rainbow-software.org>
Date: Mon, 7 Aug 2017 19:46:38 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4A6C94E7-8AE1-4F91-B0D3-7924AFEF4D6B@holtmann.org>
References: <20170807173549.527-1-linux@rainbow-software.org>
To: Ondrej Zary <linux@rainbow-software.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ondrej,

> Currently the activity LED is solid on during continuous activity.
> Blink the LED during continuous activity to match Windows driver
> behavior.
> 
> Cards with activity LED:
> power LED = solid on when up, off when down
> activity LED = blinking during activity, off when idle
> 
> Cards without activity LED:
> power LED = solid on when up, off when down, blinking during activity
> (don't have such a card so I don't know if Windows driver does the same
> thing)
> 
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
> ---
> drivers/bluetooth/bluecard_cs.c | 33 +++++++++++++++++++--------------
> 1 file changed, 19 insertions(+), 14 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

