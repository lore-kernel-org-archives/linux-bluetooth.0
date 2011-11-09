Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 3/3] Bluetooth: Add public/random LE address information
 to mgmt messages
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 09 Nov 2011 23:44:59 +0900
In-Reply-To: <1320839938-24873-3-git-send-email-johan.hedberg@gmail.com>
References: <1320839938-24873-1-git-send-email-johan.hedberg@gmail.com>
	 <1320839938-24873-3-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1320849902.15441.339.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> It's necessary to know the distinction between public and random LE
> addresses so the mgmt interface also needs to distinguish between them.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |   14 ++++++++------
>  include/net/bluetooth/mgmt.h     |    4 ++--
>  net/bluetooth/hci_event.c        |   21 ++++++++++++---------
>  net/bluetooth/mgmt.c             |   35 ++++++++++++++++++++++-------------
>  4 files changed, 44 insertions(+), 30 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


