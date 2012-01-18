Return-Path: <cyrus@holtmann.org>
Message-ID: <1326914077.6454.407.camel@aeonflux>
Subject: Re: [PATCH 11/15] Bluetooth: Convert hdev->ssp_mode to a flag
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 18 Jan 2012 20:14:37 +0100
In-Reply-To: <1326912717-6347-12-git-send-email-johan.hedberg@gmail.com>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
	 <1326912717-6347-12-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The ssp_mode is essentially just a boolean so it's more appropriate to
> have it simply as a flag in hdev->dev_flags.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci.h      |    1 +
>  include/net/bluetooth/hci_core.h |    3 +--
>  net/bluetooth/hci_event.c        |   10 ++++++++--
>  net/bluetooth/mgmt.c             |    4 ++--
>  4 files changed, 12 insertions(+), 6 deletions(-)

please do this change first.

Regards

Marcel


