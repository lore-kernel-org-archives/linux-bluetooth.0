Return-Path: <cyrus@holtmann.org>
Message-ID: <1330730728.3392.129.camel@aeonflux>
Subject: Re: [PATCH 1/2] Bluetooth: Remove HCI_PI_MGMT_INIT flag for sockets
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 02 Mar 2012 15:25:28 -0800
In-Reply-To: <1330727590-27120-1-git-send-email-johan.hedberg@gmail.com>
References: <1330727590-27120-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This flag is of no use right now and is in fact harmful in that it
> prevents the HCI_MGMT flag to be set for any controllers that may need
> it after the first one that bluetoothd takes into use (the flag is
> cleared for the first controller so any subsequent ones through the same
> bluetoothd mgmt socket never get the HCI_MGMT flag set).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    4 ----
>  net/bluetooth/hci_sock.c         |    1 -
>  net/bluetooth/mgmt.c             |   18 ++++++++----------
>  3 files changed, 8 insertions(+), 15 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


