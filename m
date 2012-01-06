Return-Path: <cyrus@holtmann.org>
Message-ID: <1325829039.6454.73.camel@aeonflux>
Subject: Re: [PATCH 4/9] Bluetooth: Add initial mgmt_confirm_name support
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 05 Jan 2012 21:50:39 -0800
In-Reply-To: <1325776582-10314-5-git-send-email-johan.hedberg@gmail.com>
References: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
	 <1325776582-10314-5-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds initial support for mgmt_confirm_name. It adds the
> necessary tracking of the name state by extending the inquiry cache. The
> actual name resolving operation (to be done once inquiry is finished) is
> not yet part of this patch.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |   29 ++++++++++++++----
>  net/bluetooth/hci_core.c         |   58 ++++++++++++++++++++++++++++++-------
>  net/bluetooth/hci_event.c        |   51 ++++++++++++++++++++++++++++-----
>  net/bluetooth/hci_sysfs.c        |    2 +-
>  net/bluetooth/mgmt.c             |   51 ++++++++++++++++++++++++++++++++-
>  5 files changed, 163 insertions(+), 28 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


