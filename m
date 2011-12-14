Return-Path: <cyrus@holtmann.org>
Message-ID: <1323900264.1965.56.camel@aeonflux>
Subject: Re: [PATCH 1/7] Bluetooth: Update mgmt_read_info and related mgmt
 messages
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 14 Dec 2011 23:04:24 +0100
In-Reply-To: <1323899524-13653-2-git-send-email-johan.hedberg@gmail.com>
References: <1323899524-13653-1-git-send-email-johan.hedberg@gmail.com>
	 <1323899524-13653-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch updates the mgmt_read_info and related messages to the latest
> management API which uses a bitfield of settings instead of individual
> boolean values.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci.h  |    1 +
>  include/net/bluetooth/mgmt.h |   29 +++++---
>  net/bluetooth/mgmt.c         |  146 +++++++++++++++++++++++++++---------------
>  3 files changed, 113 insertions(+), 63 deletions(-)

I would have split the hci.h patch into a separate one, but since it is
so tiny, this is fine with me as well.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


