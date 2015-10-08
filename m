Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Oct 2015 10:00:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_bcm: Enable support for set_diag driver
 callback
Message-ID: <20151008070003.GE25309@t440s.lan>
References: <1444241306-41525-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444241306-41525-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 07, 2015, Marcel Holtmann wrote:
> The set_diag driver callback allows enabling and disabling the vendor
> specific diagnostic information. Since Broadcom chips have support for
> a dedicated LM_DIAG channel, hook it up accordingly.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_bcm.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
