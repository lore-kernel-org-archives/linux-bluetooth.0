Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/3] Bluetooth: Add initial Bluetooth Management
 interface callbacks
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@nokia.com>
In-Reply-To: <1290609575-28435-3-git-send-email-johan.hedberg@gmail.com>
References: <1290609575-28435-1-git-send-email-johan.hedberg@gmail.com>
	 <1290609575-28435-3-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 24 Nov 2010 15:48:20 +0100
Message-ID: <1290610100.13641.15.camel@aeonflux.mpl.access-company.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Add initial code for handling Bluetooth Management interface messages.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
> ---
>  include/net/bluetooth/hci_core.h |    3 +
>  net/bluetooth/Makefile           |    2 +-
>  net/bluetooth/hci_sock.c         |   39 +++++++++++++--
>  net/bluetooth/mgmt.c             |   99 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 136 insertions(+), 7 deletions(-)
>  create mode 100644 net/bluetooth/mgmt.c

looks good.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


