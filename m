Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Feb 2012 23:11:12 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add support for HCI monitor channel
Message-ID: <20120220211112.GA20660@x220.ger.corp.intel.com>
References: <1329766478-2834-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329766478-2834-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Feb 20, 2012, Marcel Holtmann wrote:
> The HCI monitor channel can be used to monitor all packets and events
> from the Bluetooth subsystem. The monitor is not bound to any specific
> HCI device and allows even capturing multiple devices at the same time.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h      |    1 +
>  include/net/bluetooth/hci_core.h |    1 +
>  include/net/bluetooth/hci_mon.h  |   51 +++++++++
>  net/bluetooth/hci_core.c         |   13 ++-
>  net/bluetooth/hci_sock.c         |  207 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 270 insertions(+), 3 deletions(-)
>  create mode 100644 include/net/bluetooth/hci_mon.h

Applied to my bluetooth-next tree. Thanks.

Johan
