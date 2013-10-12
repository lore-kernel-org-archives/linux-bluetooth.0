Return-Path: <cyrus@holtmann.org>
Date: Sat, 12 Oct 2013 17:35:55 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix PSM value for L2CAP connectionless data
 packets
Message-ID: <20131012143555.GA8354@x220.p-661hnu-f1>
References: <1381582886-43884-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381582886-43884-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Oct 12, 2013, Marcel Holtmann wrote:
> The put_unaligned() for setting the PSM is missing the (__le16 *)
> cast. Without this, the PSM information transmitted over the air
> are bogus.
> 
> In addition, print the used PSM value in the debug message so this
> becomes easier to debug in the future.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/l2cap_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
