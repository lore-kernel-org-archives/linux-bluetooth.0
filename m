Return-Path: <cyrus@holtmann.org>
Date: Mon, 15 Sep 2014 07:17:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add BUILD_BUG_ON check for SKB control buffer
 size
Message-ID: <20140915041703.GA722@t440s.P-661HNU-F1>
References: <1410727846-61438-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410727846-61438-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Sep 14, 2014, Marcel Holtmann wrote:
> The struct bt_skb_cb size needs to stay within the limits of skb->cb
> at all times and to ensure that add a BUILD_BUG_ON to check for it at
> compile time.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/af_bluetooth.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
