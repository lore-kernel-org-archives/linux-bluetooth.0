Return-Path: <cyrus@holtmann.org>
Date: Sun, 13 Jul 2014 21:40:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Remove unneeded forward declaration of
 __sco_chan_add
Message-ID: <20140713184041.GB3344@t440s.P-661HNU-F1>
References: <1405274089-22043-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405274089-22043-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jul 13, 2014, Marcel Holtmann wrote:
> The forward declaration of __sco_chan_add is not needed and thus just
> remove it. Move __sco_chan_add into the proper location.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/sco.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)

Both patches have been applied to bluetooth-next. Thanks.

Johan
