Return-Path: <johan.hedberg@gmail.com>
Date: Tue, 20 Mar 2018 11:21:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_ll: Use skb_put_u8 instead of struct
 hcill_cmd
Message-ID: <20180320092148.GA29216@x1c.lan>
References: <20180320083104.9243-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180320083104.9243-1-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Mar 20, 2018, Marcel Holtmann wrote:
> The struct hcill_cmd to create an skb with a single u8 is pointless. So
> just use skb_put_u8 instead.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_ll.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
