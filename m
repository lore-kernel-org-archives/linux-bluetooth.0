Return-Path: <cyrus@holtmann.org>
Message-ID: <1326913468.6454.399.camel@aeonflux>
Subject: Re: [PATCH 03/15] Bluetooth: Add eir_len parameter to
 mgmt_ev_device_found
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 18 Jan 2012 20:04:28 +0100
In-Reply-To: <1326912717-6347-4-git-send-email-johan.hedberg@gmail.com>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
	 <1326912717-6347-4-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch add a two byte eir_len parameter mgmt_ev_device_found. Since
> it's unlikely that the data will in the short term be much bigger than
> conventional EIR lengths just use a small stack based buffer for now to
> avoid dynamic memory allocation & freeing.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    2 +-
>  include/net/bluetooth/mgmt.h     |    3 ++-
>  net/bluetooth/mgmt.c             |   28 +++++++++++++++-------------
>  3 files changed, 18 insertions(+), 15 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


