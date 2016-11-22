Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: Re: [PATCH] Bluetooth: Fix using the correct source address type
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1478962987-29898-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 22 Nov 2016 22:52:44 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9CFD2D4B-48CA-45FA-A59C-B9787D1BE1D3@holtmann.org>
References: <1478962987-29898-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The hci_get_route() API is used to look up local HCI devices, however
> so far it has been incapable of dealing with anything else than the
> public address of HCI devices. This completely breaks with LE-only HCI
> devices that do not come with a public address, but use a static
> random address instead.
> 
> This patch exteds the hci_get_route() API with a src_type parameter
> that's used for comparing with the right address of each HCI device.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  2 +-
> net/bluetooth/6lowpan.c          |  4 ++--
> net/bluetooth/hci_conn.c         | 26 ++++++++++++++++++++++++--
> net/bluetooth/l2cap_core.c       |  2 +-
> net/bluetooth/rfcomm/tty.c       |  2 +-
> net/bluetooth/sco.c              |  2 +-
> 6 files changed, 30 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-stable tree.

Regards

Marcel

