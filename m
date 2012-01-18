Return-Path: <cyrus@holtmann.org>
Message-ID: <1326913708.6454.403.camel@aeonflux>
Subject: Re: [PATCH 07/15] Bluetooth: Merge device class into the EIR data
 in mgmt_ev_device_found
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 18 Jan 2012 20:08:28 +0100
In-Reply-To: <1326912717-6347-8-git-send-email-johan.hedberg@gmail.com>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
	 <1326912717-6347-8-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> There's no need to have a separate device class field since the same
> information can be encoded into the EIR data.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |   11 +++++++++++
>  include/net/bluetooth/mgmt.h     |    1 -
>  net/bluetooth/mgmt.c             |   20 +++++++++++++-------
>  3 files changed, 24 insertions(+), 8 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


