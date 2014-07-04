Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Jul 2014 15:00:35 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix constant for public address configuration
Message-ID: <20140704120035.GA30698@t440s.lan>
References: <1404473018-18975-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404473018-18975-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jul 04, 2014, Marcel Holtmann wrote:
> The public address configuration option is value 0x02 since the generic
> external configuration is value 0x01. So adjust this accordingly and
> also add the value 0x01 to the list.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/mgmt.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
