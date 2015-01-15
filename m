Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Jan 2015 13:07:15 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Fix LE SMP channel source address and
 source address type
Message-ID: <20150115110715.GA26087@t440s.lan>
References: <1421278991-4169-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421278991-4169-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jan 14, 2015, Marcel Holtmann wrote:
> The source address and source address type of the LE SMP channel can
> either be the public address of the controller or the static random
> address configured by the host.
> 
> Right now the public address is used for the LE SMP channel and
> obviously that is not correct if the controller operates with the
> configured static random address.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/smp.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)

All three patches in this set have been applied to bluetooth-next.
Thanks.

Johan
