Return-Path: <cyrus@holtmann.org>
Message-ID: <1332258865.1870.18.camel@aeonflux>
Subject: Re: [RFC 3/4] Bluetooth: Check HCI_PINQUIRY in start_discovery
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <aguedespe@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, andre.guedes@openbossa.org
Date: Tue, 20 Mar 2012 08:54:25 -0700
In-Reply-To: <1332210772-13806-4-git-send-email-aguedespe@gmail.com>
References: <1332210772-13806-1-git-send-email-aguedespe@gmail.com>
	 <1332210772-13806-4-git-send-email-aguedespe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds a HCI_PINQUIRY check to start_discovery. If
> periodic inquiry is enabled, we fail MGMT Start Discovery
> command with MGMT_STATUS_BUSY code.
> 
> Signed-off-by: Andre Guedes <aguedespe@gmail.com>
> ---
>  net/bluetooth/mgmt.c |    6 ++++++
>  1 file changed, 6 insertions(+)

besides the pending flag name change, this is fine as well.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


