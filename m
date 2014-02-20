Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Feb 2014 08:32:17 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Replace own_address_type with
 force_static_address debugfs
Message-ID: <20140220063217.GC3739@x220.p-661hnu-f1>
References: <1392867086-23388-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392867086-23388-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Feb 19, 2014, Marcel Holtmann wrote:
> The own_address_type debugfs option does not providing enough
> flexibity for interacting with the upcoming LE privacy support.
> 
> What really is needed is an option to force using the static address
> compared to the public address. The new force_static_address debugfs
> option does exactly that. In addition it is also only available when
> the controller does actually have a public address. For single mode
> LE only controllers this option will not be available.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h |  1 +
>  net/bluetooth/hci_core.c    | 95 +++++++++++++++++++++++++++++----------------
>  2 files changed, 63 insertions(+), 33 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
