Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Jul 2014 13:12:51 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove sco_chan_get helper function
Message-ID: <20140714101251.GA29451@t440s.lan>
References: <1405294215-43683-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405294215-43683-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jul 14, 2014, Marcel Holtmann wrote:
> The sco_chan_get helper function is only used in two places and really
> only protects conn->sk with a lock. So instead of hiding that fact,
> just put the actual code in place where it is used.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/sco.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
