Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/3] Bluetooth: Add Bluetooth Management interface
 definitions
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@nokia.com>
In-Reply-To: <1290609575-28435-2-git-send-email-johan.hedberg@gmail.com>
References: <1290609575-28435-1-git-send-email-johan.hedberg@gmail.com>
	 <1290609575-28435-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 24 Nov 2010 15:47:52 +0100
Message-ID: <1290610072.13641.14.camel@aeonflux.mpl.access-company.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Add initial definitions for the new Bluetooth Management interface to
> the bluetooth headers.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
> ---
>  include/net/bluetooth/hci.h      |    4 +++
>  include/net/bluetooth/hci_core.h |    1 +
>  include/net/bluetooth/mgmt.h     |   46 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 51 insertions(+), 0 deletions(-)
>  create mode 100644 include/net/bluetooth/mgmt.h

looks fine to me.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


