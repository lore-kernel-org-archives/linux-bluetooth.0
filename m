Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Sep 2014 10:27:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove exported hci_recv_fragment function
Message-ID: <20140917072716.GA7640@t440s.lan>
References: <1410896169-28726-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410896169-28726-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Sep 16, 2014, Marcel Holtmann wrote:
> The hci_recv_fragment function is no longer used by any driver and thus
> do not export it. In fact it is not even needed by the core and it can
> be removed altogether.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |  1 -
>  net/bluetooth/hci_core.c         | 20 --------------------
>  2 files changed, 21 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
