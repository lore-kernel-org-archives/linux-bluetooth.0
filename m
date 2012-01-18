Return-Path: <cyrus@holtmann.org>
Message-ID: <1326913396.6454.398.camel@aeonflux>
Subject: Re: [PATCH 02/15] Bluetooth: Rename mgmt connected events to match
 user space
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 18 Jan 2012 20:03:16 +0100
In-Reply-To: <1326912717-6347-3-git-send-email-johan.hedberg@gmail.com>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
	 <1326912717-6347-3-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> User space uses device_(dis)connected instead of just (dis)connected so
> rename the defines and functions to match this.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    6 +++---
>  include/net/bluetooth/mgmt.h     |    4 ++--
>  net/bluetooth/hci_event.c        |    6 +++---
>  net/bluetooth/mgmt.c             |   12 +++++++-----
>  4 files changed, 15 insertions(+), 13 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


