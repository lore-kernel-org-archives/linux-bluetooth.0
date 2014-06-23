Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Jun 2014 14:36:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Set default min/max connection interval for
 LE slaves
Message-ID: <20140623113621.GA24897@t440s>
References: <1403518492-14548-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403518492-14548-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jun 23, 2014, Marcel Holtmann wrote:
> For all incoming LE connections, the minimum and maximum connection
> interval is a value that should be copied from the controller default
> values. This allows to properly check if the resulting connection
> interval of a newly established connection is in the range we are
> expecting.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_event.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
