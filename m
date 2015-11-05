Return-Path: <johan.hedberg@gmail.com>
Date: Thu, 5 Nov 2015 08:49:56 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Add hci_skb_* helper wrappers for
 bt_cb(skb) access
Message-ID: <20151105064956.GA25182@t440s.P-661HNU-F1>
References: <1446703801-30566-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446703801-30566-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Nov 05, 2015, Marcel Holtmann wrote:
> For all the HCI driver related variables accesssed via bt_cb(skb),
> provide helper wrappers.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/bluetooth.h | 4 ++++
>  1 file changed, 4 insertions(+)

All three patches have been applied to bluetooth-next. Thanks.

Johan
