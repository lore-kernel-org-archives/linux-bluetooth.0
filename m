Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: Add clarifying comment for conn->auth_type
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1402314085-6155-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 10 Jun 2014 11:15:58 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1D29B295-3466-4B21-AB62-BC5946145453@holtmann.org>
References: <1402314085-6155-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When responding to an IO capability request when we're the initiators of
> the pairing we will not yet have the remote IO capability information.
> Since the conn->auth_type variable is treated as an "absolute"
> requirement instead of a hint of what's needed later in the user
> confirmation request handler it's important that it doesn't have the
> MITM bit set if there's any chance that the remote device doesn't have
> the necessary IO capabilities.
> 
> This patch adds a clarifying comment so that conn->auth_type is left
> untouched in this scenario.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

