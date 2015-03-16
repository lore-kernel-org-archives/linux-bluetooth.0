Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Mar 2015 06:56:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove unneeded HCI_CONN_REMOTE_OOB
 connection flag
Message-ID: <20150316045648.GB22800@t440s.P-661HNU-F1>
References: <1426464499-24874-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426464499-24874-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Mar 15, 2015, Marcel Holtmann wrote:
> The HCI_CONN_REMOTE_OOB connection flag is used to indicate if the
> pairing initiator has provided out-of-band data. However since that
> value is no longer used in any decision making, just remove it.
> 
> It is actually unclear what purpose the OOB data present field from
> the HCI IO Capability Response event serves in the first place. If
> either side provided out-of-band data, then that data will be used
> for pairing.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h | 1 -
>  net/bluetooth/hci_event.c        | 2 --
>  2 files changed, 3 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
