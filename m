Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Oct 2013 17:07:34 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] Bluetooth: Declare btusb_table[] and
 blacklist_table[] as const
Message-ID: <20131011150734.GB20347@x220.p-661hnu-f1>
References: <1381502781-42826-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381502781-42826-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Oct 11, 2013, Marcel Holtmann wrote:
> The btusb_table[] and blacklist_table[] USB device tables can be
> declared as const.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

All four patches in this set have been applied to bluetooth-next. Thanks.

Johan
