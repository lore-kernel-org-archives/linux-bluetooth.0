Return-Path: <cyrus@holtmann.org>
Message-ID: <1326967397.1955.4.camel@aeonflux>
Subject: Re: [PATCH 2/3] Bluetooth Convert hdev->ssp_mode to a flag
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 19 Jan 2012 11:03:17 +0100
In-Reply-To: <1326966173-20105-3-git-send-email-johan.hedberg@gmail.com>
References: <1326966173-20105-1-git-send-email-johan.hedberg@gmail.com>
	 <1326966173-20105-3-git-send-email-johan.hedberg@gmail.com>
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
>  include/net/bluetooth/hci_core.h |    1 -
>  net/bluetooth/hci_conn.c         |    6 +++---
>  net/bluetooth/hci_event.c        |   17 ++++++++++++-----
>  net/bluetooth/mgmt.c             |    4 ++--
>  5 files changed, 18 insertions(+), 11 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


