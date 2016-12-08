Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: Re: [PATCH v2] Bluetooth: SMP: Add support for H7 crypto function and
 CT2 auth flag
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20161208063254.2151-1-johan.hedberg@gmail.com>
Date: Thu, 8 Dec 2016 08:04:59 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <460F420F-2C73-4084-A232-4047F6CBED18@holtmann.org>
References: <20161208063254.2151-1-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Bluetooth 5.0 introduces a new H7 key generation function that's used
> when both sides of the pairing set the CT2 authentication flag to 1.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 85 ++++++++++++++++++++++++++++++++++++++++++-----------
> net/bluetooth/smp.h |  1 +
> 2 files changed, 69 insertions(+), 17 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

