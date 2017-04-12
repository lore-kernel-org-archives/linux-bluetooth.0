Return-Path: <linux-wpan-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/6] 6lowpan: Don't set IFF_NO_QUEUE
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170411192103.3209-1-luiz.dentz@gmail.com>
Date: Wed, 12 Apr 2017 21:58:45 +0200
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Patrik Flykt <patrik.flykt@linux.intel.com>,
        Alexander Aring <aar@pengutronix.de>,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        linux-wpan@vger.kernel.org
Message-Id: <CD68D4DF-AEF7-4142-9999-B2FDD0E9A44C@holtmann.org>
References: <20170411192103.3209-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> There is no point in setting IFF_NO_QUEUE should already have taken
> care of setting it if tx_queue_len is not set, in fact this may
> actually disable queue for interfaces that require it and do set
> tx_queue_len.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/6lowpan/core.c | 1 -
> 1 file changed, 1 deletion(-)

all 6 patches have been applied to bluetooth-next tree.

Regards

Marcel

