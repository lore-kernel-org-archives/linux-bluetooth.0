Return-Path: <cyrus@holtmann.org>
Message-ID: <1331825301.14217.129.camel@aeonflux>
Subject: Re: [PATCH v2 2/2] Bluetooth: LE support for MGMT stop discovery
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 15 Mar 2012 08:28:21 -0700
In-Reply-To: <1331297862-28875-3-git-send-email-andre.guedes@openbossa.org>
References: <1331297862-28875-1-git-send-email-andre.guedes@openbossa.org>
	 <1331297862-28875-3-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds LE support to MGMT stop discovery command. So,
> now we are able to cancel LE discovery procedures (LE-only and
> interleaved).
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c |    6 +++++-
>  net/bluetooth/mgmt.c      |    6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


