Return-Path: <cyrus@holtmann.org>
Message-ID: <1329776764.2049.1.camel@aeonflux>
Subject: Re: [PATCH 2/4] Bluetooth: mgmt: Add address type parameter to
 Discovering event
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 20 Feb 2012 23:26:04 +0100
In-Reply-To: <1329776676-22800-2-git-send-email-johan.hedberg@gmail.com>
References: <1329776676-22800-1-git-send-email-johan.hedberg@gmail.com>
	 <1329776676-22800-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds an address type parameter to the Discovering event. The
> value matches that given to Start/Stop Discovery.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/mgmt.h |    4 ++++
>  net/bluetooth/hci_core.c     |    3 +--
>  net/bluetooth/mgmt.c         |    8 ++++++--
>  3 files changed, 11 insertions(+), 4 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


