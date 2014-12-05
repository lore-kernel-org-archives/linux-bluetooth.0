Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Dec 2014 13:37:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/7] Bluetooth: Add HCI_RSSI_INVALID for unknown RSSI
 value
Message-ID: <20141205113705.GA6745@t440s.lan>
References: <1417773359-122811-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417773359-122811-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Dec 05, 2014, Marcel Holtmann wrote:
> The Bluetooth core specification defines the value 127 as invalid for
> RSSI values. So instead of hard coding it, lets add a constant for it.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h | 1 +
>  1 file changed, 1 insertion(+)

All patches in this set have been applied to bluetooth-next. Thanks.

Johan
