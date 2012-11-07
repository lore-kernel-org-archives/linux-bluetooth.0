Return-Path: <cyrus@holtmann.org>
Message-ID: <1352303590.16204.0.camel@aeonflux>
Subject: Re: [PATCH 1/3] Bluetooth: Use proper invalid value for tx_power
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 07 Nov 2012 16:53:10 +0100
In-Reply-To: <1352239600-5840-1-git-send-email-johan.hedberg@gmail.com>
References: <1352239600-5840-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The core specification defines 127 as the "not available" value (well,
> "reserved" for BR/EDR and "not available" for LE - but essentially the
> same). Therefore, instead of testing for 0 (which is in fact a valid
> value) we should be using this invalid value to test if the tx_power is
> available.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci.h |    3 +++
>  net/bluetooth/hci_core.c    |    2 ++
>  net/bluetooth/hci_event.c   |    2 ++
>  net/bluetooth/mgmt.c        |    2 +-
>  4 files changed, 8 insertions(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


