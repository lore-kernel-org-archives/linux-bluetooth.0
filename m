Return-Path: <cyrus@holtmann.org>
Message-ID: <1325829298.6454.78.camel@aeonflux>
Subject: Re: [PATCH 9/9] Bluetooth: Add name resolving support for mgmt
 based discovery
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 05 Jan 2012 21:54:58 -0800
In-Reply-To: <1325776582-10314-10-git-send-email-johan.hedberg@gmail.com>
References: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
	 <1325776582-10314-10-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds the necessary logic to perform name lookups after
> inquiry completes. This is done by checking for entries in the resolve
> list after each inquiry complete and remote name complete HCI event.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    8 +++-
>  net/bluetooth/hci_core.c         |   34 +++++++++++++++-
>  net/bluetooth/hci_event.c        |   81 ++++++++++++++++++++++++++++++++++++--
>  net/bluetooth/mgmt.c             |   37 +++++++++++++++--
>  4 files changed, 149 insertions(+), 11 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


