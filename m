Return-Path: <cyrus@holtmann.org>
Date: Wed, 14 Jan 2015 10:02:18 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: Add internal recv_event callback for
 event processing
Message-ID: <20150114080218.GA19106@t440s.P-661HNU-F1>
References: <1421099470-21771-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421099470-21771-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jan 12, 2015, Marcel Holtmann wrote:
> Some new upcoming drivers need to process HCI events or take extra
> actions based on them before handing the event to the Bluetooth core
> for processing. The new recv_event callback allows exactly such an
> internal behavior.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
