Return-Path: <johan.hedberg@gmail.com>
Date: Fri, 3 Aug 2018 14:15:51 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: Use bt_dev_err for Intel firmware
 loading errors
Message-ID: <20180803111551.GA21756@x1c.home>
References: <20180803092049.14837-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180803092049.14837-1-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Aug 03, 2018, Marcel Holtmann wrote:
> Replace the BT_ERR functions with bt_dev_err to get a consistent error
> printout that always prefixes the HCI device identifier.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 77 +++++++++++++++++++--------------------
>  1 file changed, 37 insertions(+), 40 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
