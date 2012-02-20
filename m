Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Feb 2012 13:50:02 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/8] Bluetooth: Use GFP_KERNEL for HCI socket allocations
Message-ID: <20120220115002.GA4060@x220.P-661HNU-F1>
References: <1329735520-23539-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329735520-23539-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Feb 20, 2012, Marcel Holtmann wrote:
> For all HCI socket allocations it is safe to use GFP_KERNEL since they
> are processed in process context now.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_sock.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

All 8 patches have been applied to my bluetooth-next tree. Thanks.

Johan
