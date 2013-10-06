Return-Path: <cyrus@holtmann.org>
Date: Sun, 6 Oct 2013 15:14:18 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove no longer needed mgmt_new_settings()
 function
Message-ID: <20131006131418.GG32754@x220.p-661hnu-f1>
References: <1381057872-35309-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381057872-35309-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 06, 2013, Marcel Holtmann wrote:
> The mgmt_new_settings() function was only needed to handle the
> error case when re-enabling advertising failed. Since that is
> now handled internally inside the management core, this function
> is not needed anymore. So just remove it.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h | 1 -
>  net/bluetooth/mgmt.c             | 9 ++-------
>  2 files changed, 2 insertions(+), 8 deletions(-)

Applied. Thanks.

Johan
