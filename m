Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Feb 2014 08:55:17 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use same LE min/max connection event length
 during update
Message-ID: <20140219065517.GB3178@x220.p-661hnu-f1>
References: <1392791234-43343-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392791234-43343-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Feb 18, 2014, Marcel Holtmann wrote:
> During LE connection establishment the value 0x0000 is used for min/max
> connection event length. So use the same value when the peripheral is
> requesting an update of the the connection paramters.
> 
> For some reason the value 0x0001 got used in the connection update and
> 0x0000 in the connection creation. Using the same value for both just
> makes sense.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_conn.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
