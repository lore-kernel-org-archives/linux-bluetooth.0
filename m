Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/3] Bluetooth: mgmt_stop_discovery_failed()
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 10 Nov 2011 07:16:18 +0900
In-Reply-To: <1320869667-1373-2-git-send-email-andre.guedes@openbossa.org>
References: <1320869667-1373-1-git-send-email-andre.guedes@openbossa.org>
	 <1320869667-1373-2-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1320876981.15441.348.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patches creates mgmt_stop_discovery_failed() which removes
> pending MGMT_OP_STOP_DISCOVERY commands and sends proper command
> status events.
> 
> This patch also fixes the MGMT_OP_STOP_DISCOVERY command leak in
> case cancel inquiry fails.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_event.c        |    6 +++++-
>  net/bluetooth/mgmt.c             |   15 +++++++++++++++
>  3 files changed, 21 insertions(+), 1 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


