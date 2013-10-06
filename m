Return-Path: <cyrus@holtmann.org>
Date: Sun, 6 Oct 2013 11:14:27 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Simplify device type check for AMP
 discover response
Message-ID: <20131006091427.GA26445@x220.p-661hnu-f1>
References: <1381050516-44319-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381050516-44319-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 06, 2013, Marcel Holtmann wrote:
> When counting the number for AMP controllers, a positive check is
> used. To be consistent, use the same check when actually adding
> the data for the AMP contollers.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/a2mp.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)

Both patches in this set have been applied to bluetooth-next. Thanks.

Johan
