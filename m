Return-Path: <cyrus@holtmann.org>
Date: Mon, 19 Oct 2015 14:33:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btbcm: Fix firmware version number calculation
Message-ID: <20151019113308.GA16940@t440s.lan>
References: <1445200676-123943-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445200676-123943-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 18, 2015, Marcel Holtmann wrote:
> The calculation for the firmware version number is off by one bit.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btbcm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
