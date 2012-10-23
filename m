Return-Path: <cyrus@holtmann.org>
Message-ID: <1351019201.1785.49.camel@aeonflux>
Subject: Re: [PATCH 7/7] Bluetooth: Make use feature test macros
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 23 Oct 2012 12:06:41 -0700
In-Reply-To: <1351011241-32515-8-git-send-email-johan.hedberg@gmail.com>
References: <1351011241-32515-1-git-send-email-johan.hedberg@gmail.com>
	 <1351011241-32515-8-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> For better code readability and avoiding simple bugs of checking the
> wrong byte of the features make use of feature test macros whenever
> possible.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    8 ++++++++
>  net/bluetooth/hci_event.c        |   26 +++++++++++++-------------
>  net/bluetooth/mgmt.c             |    8 ++++----
>  3 files changed, 25 insertions(+), 17 deletions(-)

nice cleanup we should do first as well.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


