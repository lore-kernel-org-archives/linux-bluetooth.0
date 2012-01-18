Return-Path: <cyrus@holtmann.org>
Message-ID: <1326913604.6454.402.camel@aeonflux>
Subject: Re: [PATCH 06/15] Bluetooth: Move eir_has_data_field to hci_core.h
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 18 Jan 2012 20:06:44 +0100
In-Reply-To: <1326912717-6347-7-git-send-email-johan.hedberg@gmail.com>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
	 <1326912717-6347-7-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This makes the function accessible from all places it's needed (e.g.
> mgmt.c and hci_event.c).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |   25 +++++++++++++++++++++++++
>  net/bluetooth/hci_event.c        |   25 -------------------------
>  2 files changed, 25 insertions(+), 25 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


