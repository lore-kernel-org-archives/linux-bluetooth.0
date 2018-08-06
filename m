Return-Path: <johan.hedberg@gmail.com>
Date: Mon, 6 Aug 2018 21:27:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btqca: Introduce HCI_EV_VENDOR and use it
Message-ID: <20180806182731.GA19441@x1c.home>
References: <20180806155840.30737-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180806155840.30737-1-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Aug 06, 2018, Marcel Holtmann wrote:
> Using HCI_VENDOR_PKT for vendor specific events does work since it has
> also the value 0xff, but it is actually the packet type indicator
> constant and not the event constant. So introduce HCI_EV_VENDOR and
> use it.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btqca.c   | 6 +++---
>  include/net/bluetooth/hci.h | 2 ++
>  2 files changed, 5 insertions(+), 3 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
