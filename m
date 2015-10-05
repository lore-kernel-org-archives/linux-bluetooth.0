Return-Path: <cyrus@holtmann.org>
Date: Mon, 5 Oct 2015 10:29:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btbcm: Send HCI Reset before sending Apple
 specific commands
Message-ID: <20151005072917.GA15431@t440s.lan>
References: <1443866468-82453-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443866468-82453-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Oct 03, 2015, Marcel Holtmann wrote:
> The commit 7bee8b08c428 allows the Read Verbose Config Info to fail
> gracefully and not cause the controller setup to abort. It seems the
> reason that command failed in the first place was the missing HCI Reset
> to bring the controller in full Bluetooth mode.
> 
> Apple Bluetooth controllers start out in HID mode and when in that mode
> the Read Verbose Config Info command is not allowed. Sending HCI Reset
> switches the controller into full HCI mode.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btbcm.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
