Return-Path: <cyrus@holtmann.org>
Message-ID: <1326138280.6454.156.camel@aeonflux>
Subject: Re: [PATCH 4/4] Bluetooth: Sort to-be-resolved devices by RSSI
 during discovery
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 09 Jan 2012 11:44:40 -0800
In-Reply-To: <1326109565-32631-4-git-send-email-johan.hedberg@gmail.com>
References: <1326109565-32631-1-git-send-email-johan.hedberg@gmail.com>
	 <1326109565-32631-4-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch makes sure that devices with stronger signal (RSSI closer to
> 0) are sorted first in the resolve list and will therefore get their
> names resolved first during device discovery. Since it's more likely
> that the device the user is trying to discover has a strong signal due
> to its proximity this ensures that the user gets the "device found"
> event for it more quickly.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    2 ++
>  net/bluetooth/hci_core.c         |   28 +++++++++++++++++++++++++++-
>  net/bluetooth/mgmt.c             |    2 +-
>  3 files changed, 30 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


