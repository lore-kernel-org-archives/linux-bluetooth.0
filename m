Return-Path: <cyrus@holtmann.org>
Date: Sun, 15 Feb 2015 10:16:34 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] Bluetooth: Move A2MP_FEAT_EXT declaration into A2MP
 source
Message-ID: <20150215081634.GA4786@t440s.P-661HNU-F1>
References: <1423949767-8669-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423949767-8669-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Feb 14, 2015, Marcel Holtmann wrote:
> The A2MP_FEAT_EXT declaration has a single user in a2mp.c and thus
> just move it there.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/a2mp.c | 2 ++
>  net/bluetooth/a2mp.h | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)

All five patches in this set have been applied to bluetooth-next.
Thanks.

Johan
