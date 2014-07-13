Return-Path: <cyrus@holtmann.org>
Date: Sun, 13 Jul 2014 22:33:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Convert L2CAP ident spinlock into a mutex
Message-ID: <20140713193330.GA7341@t440s.P-661HNU-F1>
References: <1405277415-30653-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405277415-30653-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jul 13, 2014, Marcel Holtmann wrote:
> The spinlock protecting the L2CAP ident number can be converted into
> a mutex since the whole processing is run in a workqueue. So instead
> of using a spinlock, just use a mutex here.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/l2cap.h | 3 +--
>  net/bluetooth/l2cap_core.c    | 6 +++---
>  2 files changed, 4 insertions(+), 5 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
