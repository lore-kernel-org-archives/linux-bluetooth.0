Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Dec 2014 09:18:02 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix controller configuration with
 HCI_QUIRK_INVALID_BDADDR
Message-ID: <20141224071802.GA12395@t440s.P-661HNU-F1>
References: <1419372648-5111-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419372648-5111-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Dec 23, 2014, Marcel Holtmann wrote:
> When controllers set the HCI_QUIRK_INVALID_BDADDR flag, it is required
> by userspace to program a valid public Bluetooth device address into
> the controller before it can be used.
> 
> After successful address configuration, the internal state changes and
> the controller runs the complete initialization procedure. However one
> small difference is that this is no longer the HCI_SETUP stage. The
> HCI_SETUP stage is only valid during initial controller setup. In this
> case the stack runs the initialization as part of the HCI_CONFIG stage.
> 
> The controller version information, default name and supported commands
> are only stored during HCI_SETUP. While these information are static,
> they are not read initially when HCI_QUIRK_INVALID_BDADDR is set. So
> when running in HCI_CONFIG state, these information need to be updated
> as well.
> 
> This especially impacts Bluetooth 4.1 and later controllers using
> extended feature pages and second event mask page.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> Cc: stable@vger.kernel.org # 3.17.x
> ---
>  net/bluetooth/hci_event.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Applied to bluetooth.git. Thanks.

Johan
