Return-Path: <cyrus@holtmann.org>
Date: Sat, 12 Oct 2013 18:32:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: The L2CAP fixed channel connectionless
 data is supported
Message-ID: <20131012153207.GA26826@x220.p-661hnu-f1>
References: <1381591099-13207-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381591099-13207-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Oct 12, 2013, Marcel Holtmann wrote:
> The implementation actually supports the L2CAP connectionless data
> channel. So set it as supported in the fixed channels bitmask.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/l2cap.h | 1 +
>  net/bluetooth/l2cap_core.c    | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
