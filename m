Return-Path: <johan.hedberg@gmail.com>
Date: Wed, 27 Jan 2016 10:49:21 -0500
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add missing COMPATIBLE_IOCTL for UART line
 discipline
Message-ID: <20160127154921.GA13196@t440s>
References: <1453707843-92704-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453707843-92704-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jan 25, 2016, Marcel Holtmann wrote:
> The HCIUARTGETDEVICE, HCIUARTSETFLAGS and HCIUARTGETFLAGS ioctl are
> missing the COMPATIBLE_IOCTL declaration.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  fs/compat_ioctl.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied to bluetooth.git. Thanks.

Johan
