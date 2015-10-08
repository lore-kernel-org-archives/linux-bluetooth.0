Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Oct 2015 10:04:26 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: bpa10x: Add support for set_diag driver
 callback
Message-ID: <20151008070426.GH25309@t440s.lan>
References: <1444266104-76648-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444266104-76648-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 08, 2015, Marcel Holtmann wrote:
> The BPA-10x devices support tracing operation. Use the set_diag driver
> callback to allow enabling and disabling that functionality.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/bpa10x.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
