Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Oct 2013 12:29:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove enable_hs declaration
Message-ID: <20131016092923.GA11537@x220.p-661hnu-f1>
References: <1381914541-48086-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381914541-48086-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 16, 2013, Marcel Holtmann wrote:
> This seems to be a left-over. The module parameter enable_hs has
> been removed, but its extern declaration is still present. It is
> not needed anymore, so just remove it.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h | 2 --
>  1 file changed, 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
