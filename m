Return-Path: <cyrus@holtmann.org>
Message-ID: <1326914231.6454.409.camel@aeonflux>
Subject: Re: [PATCH 13/15] Bluetooth: Update device_connected and
 device_found events to latest API
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 18 Jan 2012 20:17:11 +0100
In-Reply-To: <1326912717-6347-14-git-send-email-johan.hedberg@gmail.com>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
	 <1326912717-6347-14-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch updates mgmt_ev_device_connected and mgmt_ev_device found to
> include an EIR-encoded remote name and class whenever possible. With
> this addition the mgmt_ev_remote_name event becomes unnecessary and can
> be removed. Since the connected event doesn't map to hci_conn_complete
> anymore a HCI_CONN_MGMT_CONNECTED flag is added to track when mgmt has
> been notified about a connection.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    7 ++-
>  include/net/bluetooth/mgmt.h     |   17 ++++----
>  net/bluetooth/hci_event.c        |   78 +++++++++++++++++++++++++++-----------
>  net/bluetooth/mgmt.c             |   56 ++++++++++++++++++++-------
>  4 files changed, 110 insertions(+), 48 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


