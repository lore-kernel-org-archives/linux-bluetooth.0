Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 31 Jul 2017 13:28:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Loic Poulain <loic.poulain@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_uart: Fix uninitialized alignment value
Message-ID: <20170731102858.GA25797@x1c>
References: <1501349551-4678-1-git-send-email-loic.poulain@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1501349551-4678-1-git-send-email-loic.poulain@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

On Sat, Jul 29, 2017, Loic Poulain wrote:
> Force alignment value to the default one (1 byte) if uninitialized.
> This fixes hci_ll serdev driver (alignment = 0) and avoid any further
> issues with upcoming drivers.
> 
> Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
> ---
>  drivers/bluetooth/hci_h4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
