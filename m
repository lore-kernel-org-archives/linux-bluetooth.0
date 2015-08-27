Return-Path: <cyrus@holtmann.org>
Date: Thu, 27 Aug 2015 12:23:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btintel: Add MODULE_FIRMWARE entries for iBT
 3.0 controllers
Message-ID: <20150827092303.GA18552@t440s.lan>
References: <1440658659-101531-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1440658659-101531-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Aug 27, 2015, Marcel Holtmann wrote:
> The iBT 3.0 controllers need intel/ibt-11-5.sfi and intel/ibt-11-5.ddc
> firmware files from linux-firmware repository.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btintel.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
