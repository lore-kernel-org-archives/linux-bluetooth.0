Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Oct 2013 09:34:48 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Restrict SSP setting changes to BR/EDR
 enabled controllers
Message-ID: <20131003063448.GC20600@x220.p-661hnu-f1>
References: <1380774712-13370-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380774712-13370-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 02, 2013, Marcel Holtmann wrote:
> Only when BR/EDR is supported and enabled, allow changing of the SSP
> setting. Just checking if the hardware supports SSP is not enough
> since it might be the case that BR/EDR is disabled.
> 
> In the case that BR/EDR is disabled, but SSP supported by the
> controller the not supported error message is now returned.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
