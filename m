Return-Path: <johan.hedberg@gmail.com>
Date: Sat, 9 Jul 2016 21:51:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Rename HCI_BREDR into HCI_PRIMARY
Message-ID: <20160709185141.GA2152@t440s.P-661HNU-F1>
References: <1467721814-117020-3-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467721814-117020-3-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Jul 05, 2016, Marcel Holtmann wrote:
> The HCI_BREDR naming is confusing since it actually stands for Primary
> Bluetooth Controller. Which is a term that has been used in the latest
> standard. However from a legacy point of view there only really have
> been Basic Rate (BR) and Enhanced Data Rate (EDR). Recent versions of
> Bluetooth introduced Low Energy (LE) and made this terminology a little
> bit confused since Dual Mode Controllers include BR/EDR and LE. To
> simplify this the name HCI_PRIMARY stands for the Primary Controller
> which can be a single mode or dual mode controller.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btmrvl_main.c |  2 +-
>  drivers/bluetooth/btsdio.c      |  2 +-
>  drivers/bluetooth/btusb.c       |  2 +-
>  drivers/bluetooth/hci_ldisc.c   |  2 +-
>  drivers/bluetooth/hci_vhci.c    |  6 +++---
>  include/net/bluetooth/hci.h     |  2 +-
>  net/bluetooth/hci_conn.c        |  2 +-
>  net/bluetooth/hci_core.c        | 28 +++++++++++++---------------
>  net/bluetooth/hci_event.c       |  2 +-
>  net/bluetooth/hci_sock.c        |  2 +-
>  net/bluetooth/l2cap_core.c      |  2 +-
>  net/bluetooth/mgmt.c            | 16 ++++++++--------
>  12 files changed, 33 insertions(+), 35 deletions(-)

All three patches have been applied to bluetooth-next. Thanks.

Johan
