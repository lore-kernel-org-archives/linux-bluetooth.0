Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Oct 2012 13:08:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Notify about device registration before power
 on
Message-ID: <20121030110809.GA14238@x220>
References: <1351586140-30708-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1351586140-30708-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Oct 30, 2012, Marcel Holtmann wrote:
> It is important that the monitor interface gets notified about
> a new device before its power on procedure has been started.
> 
> For some reason that is no longer working as expected and the power
> on procedure runs first. It is safe to just notify about device
> registration and trigger the power on procedure afterwards.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
