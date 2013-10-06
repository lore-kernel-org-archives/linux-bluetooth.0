Return-Path: <cyrus@holtmann.org>
Date: Sun, 6 Oct 2013 11:05:14 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use explicit check for BR/EDR device type
Message-ID: <20131006090514.GB22667@x220.p-661hnu-f1>
References: <1381047382-37225-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381047382-37225-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 06, 2013, Marcel Holtmann wrote:
> The BR/EDR and LE setup procedures apply only to BR/EDR device types
> and so check for that explicitly. Checking that it is not an AMP
> controller is dangerous in case there will be ever a third device
> type.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
