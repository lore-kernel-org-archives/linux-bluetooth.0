Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Feb 2014 08:32:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Track the current configured random address
Message-ID: <20140220063230.GD3739@x220.p-661hnu-f1>
References: <1392868333-37479-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392868333-37479-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Feb 19, 2014, Marcel Holtmann wrote:
> For Bluetooth controllers with LE support, track the value of the
> currently configured random address. It is important to know what
> the current random address is to avoid unneeded attempts to set
> a new address. This will become important when introducing the
> LE privacy support in the future.
> 
> In addition expose the current configured random address via
> debugfs for debugging purposes.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_core.c         | 26 ++++++++++++++++++++++++++
>  net/bluetooth/hci_event.c        | 24 ++++++++++++++++++++++++
>  3 files changed, 51 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
