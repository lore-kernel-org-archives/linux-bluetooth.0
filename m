Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Feb 2014 08:51:18 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Store current RPA and update it if needed
Message-ID: <20140224065118.GC16823@x220.p-661hnu-f1>
References: <1393216763-14836-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393216763-14836-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Feb 23, 2014, Marcel Holtmann wrote:
> The RPA needs to be stored to know which is the current one. Otherwise
> it is impossible to ensure that always the correct RPA can be programmed
> into the controller when it is needed.
> 
> Current code checks if the address in the controller is a RPA, but that
> can potentially lead to using a RPA that can not be resolved with the
> IRK that has been distributed.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_core.c         | 11 +++++------
>  2 files changed, 6 insertions(+), 6 deletions(-)

Both patches have been applied to bluetooth-next. Thanks.

Johan
