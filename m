Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Jun 2014 14:36:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add support LE slave connection update
 procedure
Message-ID: <20140623113632.GB24897@t440s>
References: <1403518731-16989-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403518731-16989-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jun 23, 2014, Marcel Holtmann wrote:
> When the current LE connection parameters of a slave connection do not
> match up with the controller defined values, then trigger the connection
> update procedure to allow adjusting them.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/l2cap_core.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
