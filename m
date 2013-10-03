Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Oct 2013 10:10:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: SMP packets are only valid on LE connections
Message-ID: <20131003071032.GC26026@x220.p-661hnu-f1>
References: <1380783657-45553-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380783657-45553-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 03, 2013, Marcel Holtmann wrote:
> When receiving SMP packets on a BR/EDR connection, then just drop
> the packet and do not try to process it.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/smp.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
