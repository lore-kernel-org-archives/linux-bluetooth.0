Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Mar 2015 08:30:41 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix potential NULL dereference in SMP channel
 setup
Message-ID: <20150318063041.GA14795@t440s.P-661HNU-F1>
References: <1426617504-27460-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426617504-27460-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Mar 17, 2015, Marcel Holtmann wrote:
> When the allocation of the L2CAP channel for the BR/EDR security manager
> fails, then the smp variable might be NULL. In that case do not try to
> free the non-existing crypto contexts
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/smp.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
