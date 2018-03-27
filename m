Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: Re: [v3] Bluetooth: btrsi: rework dependencies
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180315211904.2256817-1-arnd@arndb.de>
References: <20180315211904.2256817-1-arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Amitkumar Karwar <amit.karwar@redpinesignals.com>,
        Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <20180327071222.D744660AFB@smtp.codeaurora.org>
Date: Tue, 27 Mar 2018 07:12:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Arnd Bergmann <arnd@arndb.de> wrote:

> The linkage between the bluetooth driver and the wireless
> driver is not defined properly, leading to build problems
> such as:
> 
> warning: (BT_HCIRSI) selects RSI_COEX which has unmet direct dependencies (NETDEVICES && WLAN && WLAN_VENDOR_RSI && BT_HCIRSI && RSI_91X)
> drivers/net/wireless/rsi/rsi_91x_main.o: In function `rsi_read_pkt':
> (.text+0x205): undefined reference to `rsi_bt_ops'
> 
> As the dependency is actually the reverse (RSI_91X uses
> the BT_RSI driver, not the other way round), this changes
> the dependency to match, and enables the bluetooth driver
> from the RSI_COEX symbol.
> 
> Fixes: 38aa4da50483 ("Bluetooth: btrsi: add new rsi bluetooth driver")
> Acked-by; Marcel Holtmann <marcel@holtmann.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied to wireless-drivers-next.git, thanks.

255dd5b79d54 Bluetooth: btrsi: rework dependencies

-- 
https://patchwork.kernel.org/patch/10285795/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
