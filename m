Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Jul 2014 11:19:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix enabling Authenticated Payload Timeout
 Expired event
Message-ID: <20140709081958.GA7133@t440s.P-661HNU-F1>
References: <1404892145-4242-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404892145-4242-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jul 09, 2014, Marcel Holtmann wrote:
> The Authenticated Payload Timeout Expired event is valid for
> controllers with BR/EDR Secure Connections support, but also for
> LE only controllers supporting LE Ping feature. When either of them
> is available enable this event. Previous it was not enabled when
> the controller was only supporting LE operation.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h | 1 +
>  net/bluetooth/hci_core.c    | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
