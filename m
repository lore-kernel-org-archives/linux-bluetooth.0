Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Oct 2013 21:36:53 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Check that scan window is smaller or equal
 than scan interval
Message-ID: <20131014183653.GA14748@x220.p-661hnu-f1>
References: <1381769732-19707-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381769732-19707-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Oct 14, 2013, Marcel Holtmann wrote:
> The scan window parameter for connection establishment and passive
> scanning needs to be smaller or equal than the scan interval.
> 
> Instead of waiting for a controller to reject these values later on,
> just reject them right away.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
