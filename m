Return-Path: <cyrus@holtmann.org>
Message-ID: <1325829192.6454.76.camel@aeonflux>
Subject: Re: [PATCH 8/9] Bluetooth: Add discovery state tracking
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 05 Jan 2012 21:53:12 -0800
In-Reply-To: <1325776582-10314-9-git-send-email-johan.hedberg@gmail.com>
References: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
	 <1325776582-10314-9-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds proper state tracking to the device discovery process.
> This makes it possible to return appropriate errors when trying to stop
> a non-active discovery or start discovery when it is already ongoing.
> Once name resolving is implemented this also makes it possible to know
> what the right action to do is when a remote name lookup is cancelled.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    9 +++++++++
>  net/bluetooth/hci_core.c         |   25 +++++++++++++++++++++++++
>  net/bluetooth/hci_event.c        |    6 +++---
>  net/bluetooth/mgmt.c             |   16 ++++++++++++++++
>  4 files changed, 53 insertions(+), 3 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


