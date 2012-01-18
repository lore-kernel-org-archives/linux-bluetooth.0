Return-Path: <cyrus@holtmann.org>
Message-ID: <1326914128.6454.408.camel@aeonflux>
Subject: Re: [PATCH 12/15] Bluetooth: Convert hdev->out to a bool type
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 18 Jan 2012 20:15:28 +0100
In-Reply-To: <1326912717-6347-13-git-send-email-johan.hedberg@gmail.com>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
	 <1326912717-6347-13-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The hdev->out variable is essentially a boolean so the type 'bool' makes
> more sense than u8.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    2 +-
>  net/bluetooth/hci_conn.c         |    8 ++++----
>  net/bluetooth/hci_event.c        |    4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


