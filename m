Return-Path: <cyrus@holtmann.org>
Date: Mon, 5 Oct 2015 14:56:48 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btbcm: Read the local name in setup stage
Message-ID: <20151005115648.GA28250@t440s.ger.corp.intel.com>
References: <1444041837-18497-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444041837-18497-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Oct 05, 2015, Marcel Holtmann wrote:
> The Broadcom Bluetooth controllers have the chip name included in the
> ROM firmware or later in the patchram firmware. For debugging purposes
> read the local name and print it out. This is only done during setup
> stage and only once before loading the firmware and once after loading
> the firmware.
> 
> For the Broadcom based controllers from Apple, the name is only read once
> after determining the chip id.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btbcm.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
