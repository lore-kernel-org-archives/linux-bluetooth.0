Return-Path: <cyrus@holtmann.org>
Message-ID: <1336320975.5970.85.camel@aeonflux>
Subject: Re: [PATCH v2] Bluetooth: mgmt: Fix device_connected sending order
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 06 May 2012 09:16:15 -0700
In-Reply-To: <1336128329-6650-1-git-send-email-johan.hedberg@gmail.com>
References: <1336127870-5930-1-git-send-email-johan.hedberg@gmail.com>
	 <1336128329-6650-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The mgmt_ev_device_connected signal must be sent before any event
> indications happen for sockets associated with the connection. Otherwise
> e.g. device authorization for the sockets will fail with ENOTCONN as
> user space things that there is no baseband link.
> 
> This patch fixes the issue by ensuring that the device_connected event
> if sent (if it hasn't been so already) as soon as the first ACL data
> packet arrives from the remote device.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> v2: Fixed missing hdev locking
> 
>  net/bluetooth/hci_core.c  |    8 ++++++++
>  net/bluetooth/hci_event.c |    4 ++--
>  2 files changed, 10 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


