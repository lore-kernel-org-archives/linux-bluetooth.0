Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Feb 2012 23:11:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Restrict access to management interface
Message-ID: <20120220211130.GB20660@x220.ger.corp.intel.com>
References: <1329767650-6355-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329767650-6355-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Feb 20, 2012, Marcel Holtmann wrote:
> The management interface on the HCI control channel should be restricted
> to applications with CAP_NET_ADMIN permission.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_sock.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)

Applied to my bluetooth-next tree. Thanks.

Johan
