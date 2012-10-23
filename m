Return-Path: <cyrus@holtmann.org>
Message-ID: <1351019162.1785.48.camel@aeonflux>
Subject: Re: [PATCH 6/7] Bluetooth: Sort feature test macros by bitmask
 location
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 23 Oct 2012 12:06:02 -0700
In-Reply-To: <1351011241-32515-7-git-send-email-johan.hedberg@gmail.com>
References: <1351011241-32515-1-git-send-email-johan.hedberg@gmail.com>
	 <1351011241-32515-7-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch sorts the feature test marcos according to the location of
> each feature bit in the features bit mask. This helps easy lookup when
> adding new marcos and wanting to check if there already is a macro
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

this could go first as well.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


