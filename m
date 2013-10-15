Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Oct 2013 21:38:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Update class of device on discoverable
 timeout
Message-ID: <20131015183856.GE31747@x220.p-661hnu-f1>
References: <1381859860-59886-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381859860-59886-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Oct 15, 2013, Marcel Holtmann wrote:
> When the discoverable timeout triggers and limited discoverable mode
> was used, then the class of device needs to be updated to remove
> the limited discoverable bit.
> 
> To keep the class of device logic in a central place, expose a new
> function mgmt_discoverable_timeout that can be called from the
> timeout callback. In case the class of device value needs updating,
> it will add the HCI command to the transaction.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_core.c         | 19 +------------------
>  net/bluetooth/mgmt.c             | 24 ++++++++++++++++++++++++
>  3 files changed, 26 insertions(+), 18 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
