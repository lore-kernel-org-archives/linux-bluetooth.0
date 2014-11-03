Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Nov 2014 10:28:41 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: btusb: Add internal callback for USB bulk
 rx data
Message-ID: <20141103082841.GC32217@t440s.lan>
References: <1414988168-51327-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414988168-51327-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Nov 03, 2014, Marcel Holtmann wrote:
> Some vendors require special handling of the rx data from the USB
> bulk endpoints. For that case provide an internal callback that
> can overwrite it with a custom receive function.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Both patches in this set have been applied to bluetooth-next. Thanks.

Johan
