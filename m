Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: btmrvl: avoid sending data to firmware after hs_activated
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1405397137-19690-1-git-send-email-bzhao@marvell.com>
Date: Tue, 15 Jul 2014 11:01:28 +0200
Cc: Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Andrew Bresticker <abrestic@chromium.org>,
	Chin-Ran Lo <crlo@marvell.com>,
	Amitkumar Karwar <akarwar@marvell.com>,
	Avinash Patil <patila@marvell.com>,
	Xinming Hu <huxm@marvell.com>
Message-Id: <4CA5D7E5-433C-426D-9E4B-344EE052CD59@holtmann.org>
References: <1405397137-19690-1-git-send-email-bzhao@marvell.com>
To: Bing Zhao <bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> We should suspend hci device and purge remaining data in tx queue
> before enabling host sleep in firmware. If any data is sent to
> firmware after host sleep is activated, firmware may end up
> sending a TX_DONE interrupt to driver. If this interrupt gets
> delivered to host while the SDIO host controller is suspending,
> it may crash the system.
> 
> Conversely, in resume handler, we should resume hci device after
> host sleep is de-activated.
> 
> Signed-off-by: Chin-Ran Lo <crlo@marvell.com>
> Signed-off-by: Bing Zhao <bzhao@marvell.com>
> ---
> drivers/bluetooth/btmrvl_sdio.c | 16 ++++++++--------
> 1 file changed, 8 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

