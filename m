Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: Fix clock (un)prepare
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170315122005.7702-2-john@metanate.com>
Date: Mon, 27 Mar 2017 16:07:25 +0200
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <7BBF08AA-EFD1-4330-BAA0-F6B2EEF5D63E@holtmann.org>
References: <20170315122005.7702-1-john@metanate.com>
 <20170315122005.7702-2-john@metanate.com>
To: John Keeping <john@metanate.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

> The hci_bcm driver currently does not prepare/unprepare the clock and
> goes directly to enable, but as the documentation for clk_enable says,
> clk_prepare must be called before clk_enable.
> 
> Signed-off-by: John Keeping <john@metanate.com>
> ---
> drivers/bluetooth/hci_bcm.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

