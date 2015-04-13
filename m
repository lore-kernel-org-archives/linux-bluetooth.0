Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Apr 2015 08:39:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btbcm: Export patchram download as separate
 function
Message-ID: <20150413053942.GA5614@t440s.P-661HNU-F1>
References: <1428699740-32324-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428699740-32324-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Apr 10, 2015, Marcel Holtmann wrote:
> This isolates the Broadcom patchram download procedure as separate
> function so that it can be easily used from USB and UART based drivers.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btbcm.c | 148 +++++++++++++++++++++++++---------------------
>  drivers/bluetooth/btbcm.h |   6 ++
>  2 files changed, 85 insertions(+), 69 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
