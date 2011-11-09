Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/3] Bluetooth: Move pending management command list
 into struct hci_dev
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 09 Nov 2011 16:35:10 +0900
In-Reply-To: <1320777616-15794-2-git-send-email-johan.hedberg@gmail.com>
References: <1320777616-15794-1-git-send-email-johan.hedberg@gmail.com>
	 <1320777616-15794-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1320824117.15441.316.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch moves the pending management command list (previously global
> to mgmt.c) into struct hci_dev. This makes it possible to do proper
> locking when accessing it (through the existing hci_dev locks) and
> thereby avoid race conditions.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    2 +
>  net/bluetooth/hci_core.c         |    6 +++
>  net/bluetooth/mgmt.c             |   79 +++++++++++++++++++-------------------
>  3 files changed, 47 insertions(+), 40 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


