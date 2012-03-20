Return-Path: <cyrus@holtmann.org>
Message-ID: <1332258916.1870.19.camel@aeonflux>
Subject: Re: [RFC 4/4] Bluetooth: Ignore inquiry results from periodic
 inquiry
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <aguedespe@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, andre.guedes@openbossa.org
Date: Tue, 20 Mar 2012 08:55:16 -0700
In-Reply-To: <1332210772-13806-5-git-send-email-aguedespe@gmail.com>
References: <1332210772-13806-1-git-send-email-aguedespe@gmail.com>
	 <1332210772-13806-5-git-send-email-aguedespe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch changes inquiry result function handlers so they ignore
> inquiry result events if periodic inquiry is enabled.
> 
> Signed-off-by: Andre Guedes <aguedespe@gmail.com>
> ---
>  net/bluetooth/hci_event.c |    9 +++++++++
>  1 file changed, 9 insertions(+)

also flag name change here as well please.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


