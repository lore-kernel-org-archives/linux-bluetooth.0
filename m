Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 Oct 2015 22:05:36 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: Print information of Intel SfP lock
 states
Message-ID: <20151013200536.GA24144@t440s>
References: <1444737295-109828-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444737295-109828-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Oct 13, 2015, Marcel Holtmann wrote:
> The lock states from Intel SfP controllers can only be read once before
> loading the firmware. So for debugging purposes, print them out.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
