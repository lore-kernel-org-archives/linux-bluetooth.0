Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Dec 2014 21:59:41 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Increase minor version of core module
Message-ID: <20141203195941.GA14488@t440s.P-661HNU-F1>
References: <1417632370-31742-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417632370-31742-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Dec 03, 2014, Marcel Holtmann wrote:
> With the addition of support for Bluetooth Low Energy Secure Connections
> feature, it makes sense to increase the minor version of the Bluetooth
> core module.
> 
> The module version is not used anywhere, but it gives a nice extra
> hint for debugging purposes.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/af_bluetooth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
