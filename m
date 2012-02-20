Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Feb 2012 23:11:47 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Always enable management interface
Message-ID: <20120220211147.GC20660@x220.ger.corp.intel.com>
References: <1329769477-11242-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329769477-11242-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Feb 20, 2012, Marcel Holtmann wrote:
> The management interface API has reached stable version 1.0 and thus
> it can now be always enabled. All future changes will be made backwards
> compatible.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_sock.c |    7 +------
>  1 files changed, 1 insertions(+), 6 deletions(-)

Applied to my bluetooth-next tree. Thanks.

Johan
