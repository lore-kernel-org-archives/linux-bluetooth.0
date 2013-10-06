Return-Path: <cyrus@holtmann.org>
Date: Sun, 6 Oct 2013 15:13:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Set LE advertising parameters before enabling
 it
Message-ID: <20131006131358.GE32754@x220.p-661hnu-f1>
References: <1381054676-15507-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381054676-15507-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 06, 2013, Marcel Holtmann wrote:
> The LE advertising parameters can only be modified when advertising
> is disabled. So before enabling it, make sure the controller has all
> the right parameters.
> 
> Right now all default values are used and thus this does no change
> any existing behavior. One minor exception is that in case of single
> mode LE-only controllers without a public address, now the random
> address is used for advertising.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)

Applied. Thanks.

Johan
