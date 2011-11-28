Return-Path: <cyrus@holtmann.org>
Message-ID: <1322497156.29909.32.camel@aeonflux>
Subject: Re: [PATCH v2 3/9] Bluetooth: Add helper functions to send LE scan
 commands
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 28 Nov 2011 17:19:16 +0100
In-Reply-To: <1322265226-6404-4-git-send-email-andre.guedes@openbossa.org>
References: <1322265226-6404-1-git-send-email-andre.guedes@openbossa.org>
	 <1322265226-6404-4-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch creates two helper functions to send LE Set Scan
> Parameters and LE Set Scan Enable commands.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_core.c |   23 +++++++++++++++++++++++
>  1 files changed, 23 insertions(+), 0 deletions(-)

I trust you that these are really needed this way.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


