Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/3] Bluetooth: Rename mgmt_inquiry_failed()
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 10 Nov 2011 07:15:01 +0900
In-Reply-To: <1320869667-1373-1-git-send-email-andre.guedes@openbossa.org>
References: <1320869667-1373-1-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1320876906.15441.347.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch renames the function mgmt_inquiry_failed() to
> mgmt_start_discovery_failed(). This function is more related
> to MGMT_OP_START_DISCOVERY command handling than to inquiry.
> Besides, this functions will be reused by LE based discovery
> procedures in case of failure.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    2 +-
>  net/bluetooth/hci_event.c        |    2 +-
>  net/bluetooth/mgmt.c             |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

And please just carry my ACK around when re-sending patches if I already
acked it. No need to keep doing this over and over again.

Regards

Marcel


