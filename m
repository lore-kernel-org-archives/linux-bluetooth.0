Return-Path: <cyrus@holtmann.org>
Message-ID: <1330730818.3392.130.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooth: mgmt: Fix updating local name when
 powering on
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 02 Mar 2012 15:26:58 -0800
In-Reply-To: <1330727590-27120-2-git-send-email-johan.hedberg@gmail.com>
References: <1330727590-27120-1-git-send-email-johan.hedberg@gmail.com>
	 <1330727590-27120-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When powering on we need to apply whatever name has been set through
> mgmt_set_local_name. The appropriate place for this is mgmt_powered()
> and not hci_setup() since this needs to be applied also if the HCI init
> sequence was already completed but the adapter was still "powered off"
> from a mgmt perspective due the the HCI_AUTO_OFF still being set.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_event.c |    8 --------
>  net/bluetooth/mgmt.c      |   22 ++++++++++++++--------
>  2 files changed, 14 insertions(+), 16 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


