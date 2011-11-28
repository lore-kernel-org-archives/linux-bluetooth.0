Return-Path: <cyrus@holtmann.org>
Message-ID: <1322497071.29909.31.camel@aeonflux>
Subject: Re: [PATCH v2 2/9] Bluetooth: LE Set Scan Parameter Command
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 28 Nov 2011 17:17:51 +0100
In-Reply-To: <1322265226-6404-3-git-send-email-andre.guedes@openbossa.org>
References: <1322265226-6404-1-git-send-email-andre.guedes@openbossa.org>
	 <1322265226-6404-3-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds the parameter struct and the command complete event
> handler to the LE Set Scan Parameter HCI command.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci.h |    9 +++++++++
>  net/bluetooth/hci_event.c   |   11 +++++++++++
>  2 files changed, 20 insertions(+), 0 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


