Return-Path: <cyrus@holtmann.org>
Date: Sat, 12 Oct 2013 18:32:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Unicast connectionless data reception is
 supported
Message-ID: <20131012153224.GB26826@x220.p-661hnu-f1>
References: <1381591099-13207-2-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381591099-13207-2-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Oct 12, 2013, Marcel Holtmann wrote:
> The unicast connectionless data reception feature is actually support
> and has been supported all along. Mark it as supported in the L2CAP
> features bitmask.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/l2cap_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
