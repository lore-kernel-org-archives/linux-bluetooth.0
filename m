Return-Path: <cyrus@holtmann.org>
Message-ID: <1331848335.14217.132.camel@aeonflux>
Subject: Re: [PATCH v3 1/2] Bluetooth: Add hci_cancel_le_scan() to hci_core
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 15 Mar 2012 14:52:15 -0700
In-Reply-To: <1331841128-1396-2-git-send-email-andre.guedes@openbossa.org>
References: <1331841128-1396-1-git-send-email-andre.guedes@openbossa.org>
	 <1331841128-1396-2-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds to hci_core the hci_cancel_le_scan function which
> should be used to cancel an ongoing LE scan.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_core.c         |   18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


