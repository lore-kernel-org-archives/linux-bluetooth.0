Return-Path: <cyrus@holtmann.org>
Date: Thu, 1 Jan 2015 10:59:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix for a leftover debug of pairing
 credentials
Message-ID: <20150101085948.GB13261@t440s.P-661HNU-F1>
References: <1420084882-7554-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1420084882-7554-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Dec 31, 2014, Marcel Holtmann wrote:
> One of the LE Secure Connections security credentials was still using
> the BT_DBG instead of SMP_DBG.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
