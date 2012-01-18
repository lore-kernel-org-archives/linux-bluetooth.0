Return-Path: <cyrus@holtmann.org>
Message-ID: <1326913923.6454.404.camel@aeonflux>
Subject: Re: [PATCH 08/15] Bluetooth: Rename conn->pend to conn->flags
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 18 Jan 2012 20:12:03 +0100
In-Reply-To: <1326912717-6347-9-git-send-email-johan.hedberg@gmail.com>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
	 <1326912717-6347-9-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> These flags can and will be used for more general purpose values than
> just pending state transitions so the more common name "flags" makes
> more sense than "pend".
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    6 +++---
>  net/bluetooth/hci_conn.c         |   20 ++++++++++----------
>  net/bluetooth/hci_event.c        |   36 ++++++++++++++++++------------------
>  net/bluetooth/l2cap_core.c       |    2 +-
>  net/bluetooth/smp.c              |   19 +++++++++----------
>  5 files changed, 41 insertions(+), 42 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


