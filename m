Return-Path: <johan.hedberg@gmail.com>
Date: Mon, 30 Oct 2017 14:00:00 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Use bt_dev_err and bt_dev_info when
 possible
Message-ID: <20171030120000.GA10743@x1c.lan>
References: <20171030090441.21322-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171030090441.21322-1-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Oct 30, 2017, Marcel Holtmann wrote:
> In case of using BT_ERR and BT_INFO, convert to bt_dev_err and
> bt_dev_info when possible. This allows for controller specific
> reporting.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/bpa10x.c        |  15 ++--
>  drivers/bluetooth/bt3c_cs.c       |   2 +-
>  drivers/bluetooth/btbcm.c         | 103 ++++++++++++-------------
>  drivers/bluetooth/btintel.c       |  42 +++++------
>  drivers/bluetooth/btqca.c         |   6 +-
>  drivers/bluetooth/btrtl.c         |  21 +++---
>  drivers/bluetooth/btusb.c         | 155 ++++++++++++++++++--------------------
>  drivers/bluetooth/hci_ath.c       |   2 +-
>  drivers/bluetooth/hci_h4.c        |   2 +-
>  drivers/bluetooth/hci_qca.c       |  12 +--
>  drivers/bluetooth/hci_serdev.c    |   9 +--
>  include/net/bluetooth/bluetooth.h |   3 +
>  net/bluetooth/a2mp.c              |   2 +-
>  net/bluetooth/amp.c               |   4 +-
>  net/bluetooth/hci_conn.c          |   4 +-
>  net/bluetooth/hci_core.c          |  35 +++++----
>  net/bluetooth/hci_event.c         |  46 +++++------
>  net/bluetooth/hci_request.c       |  16 ++--
>  net/bluetooth/hci_sysfs.c         |   2 +-
>  net/bluetooth/mgmt.c              |  56 +++++++-------
>  net/bluetooth/smp.c               |  22 +++---
>  21 files changed, 279 insertions(+), 280 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
