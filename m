Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Oct 2013 10:14:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: L2CAP connectionless channels are only valid
 for BR/EDR
Message-ID: <20131003071423.GA29448@x220.p-661hnu-f1>
References: <1380783819-47726-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380783819-47726-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 03, 2013, Marcel Holtmann wrote:
> When receiving connectionless packets on a LE connection, just drop
> the packet. There is no concept of connectionless channels for LE.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/l2cap_core.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
