Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Oct 2013 10:10:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Don't copy L2CAP LE signalling to raw sockets
Message-ID: <20131003071017.GB26026@x220.p-661hnu-f1>
References: <1380783109-37739-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380783109-37739-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 02, 2013, Marcel Holtmann wrote:
> The L2CAP raw sockets are only used for BR/EDR signalling. Packets
> on LE links should not be forwarded there.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/l2cap_core.c | 2 --
>  1 file changed, 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
