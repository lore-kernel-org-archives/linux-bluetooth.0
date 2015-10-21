Return-Path: <cyrus@holtmann.org>
Date: Wed, 21 Oct 2015 07:32:05 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Introduce driver specific post init callback
Message-ID: <20151021043205.GB12268@t440s.P-661HNU-F1>
References: <1445376342-94161-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445376342-94161-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Oct 20, 2015, Marcel Holtmann wrote:
> Some drivers might have to restore certain settings after the init
> procedure has been completed. This driver callback allows them to hook
> into that stage. This callback is run just before the controller is
> declared as powered up.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h | 1 +
>  net/bluetooth/hci_core.c         | 5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
