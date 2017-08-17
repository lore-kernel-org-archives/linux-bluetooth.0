Return-Path: <johan.hedberg@gmail.com>
Date: Thu, 17 Aug 2017 12:12:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btbcm: Consolidate the controller information
 commands
Message-ID: <20170817091229.GA26911@x1c.lan>
References: <20170817090240.72914-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170817090240.72914-1-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Aug 17, 2017, Marcel Holtmann wrote:
> The commands that read the basic vendor information about the Broadcom
> controller are duplicated for UART and USB devices. Combine them into a
> single function to reduce the code complexity.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btbcm.c | 69 ++++++++++++++++++++++++++---------------------
>  1 file changed, 39 insertions(+), 30 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
