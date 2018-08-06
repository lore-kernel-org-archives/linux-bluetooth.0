Return-Path: <johan.hedberg@gmail.com>
Date: Mon, 6 Aug 2018 17:09:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: YueHaibing <yuehaibing@huawei.com>
Cc: marcel@holtmann.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, davem@davemloft.net,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: remove redundant variables 'adv_set' and 'cp'
Message-ID: <20180806140922.GA18195@x1c.home>
References: <20180806110851.8568-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180806110851.8568-1-yuehaibing@huawei.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi YueHaibing,

On Mon, Aug 06, 2018, YueHaibing wrote:
> Variables 'adv_set' and 'cp'  are being assigned but are never used hence
> they are redundant and can be removed.
> 
> Cleans up clang warnings:
> net/bluetooth/hci_event.c:1135:29: warning: variable 'adv_set' set but not used [-Wunused-but-set-variable]
> net/bluetooth/mgmt.c:3359:39: warning: variable 'cp' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/bluetooth/hci_event.c | 3 ---
>  net/bluetooth/mgmt.c      | 3 ---
>  2 files changed, 6 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
