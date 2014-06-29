Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 Jun 2014 15:33:35 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Restrict access for raw-only controllers
Message-ID: <20140629123335.GA7248@t440s.P-661HNU-F1>
References: <1404036785-42112-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404036785-42112-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jun 29, 2014, Marcel Holtmann wrote:
> Bluetooth controllers that are marked for raw-only usage can only be
> used with user channel access. Any other operation should be rejected.
> 
> This simplifies the whole raw-only support since it now depends on
> the fact that the controller is marked with HCI_QUIRK_RAW_DEVICE and
> runtime raw access is restricted to user channel operation.
> 
> The kernel internal processing of HCI commands and events is designed
> around the case that either the kernel has full control over the device
> or that the device is driven from userspace. This now makes a clear
> distinction between these two possible operation modes.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_conn.c |  7 -----
>  net/bluetooth/hci_core.c | 74 +++++++++++++++++++++++++++++++++++++-----------
>  net/bluetooth/hci_sock.c | 14 ++++++---
>  net/bluetooth/mgmt.c     |  6 +++-
>  4 files changed, 72 insertions(+), 29 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
