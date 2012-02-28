Return-Path: <cyrus@holtmann.org>
Message-ID: <1330450557.3392.89.camel@aeonflux>
Subject: Re: [PATCH 1/2] Bluetooth: Change interleaved discovery behavior
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 28 Feb 2012 09:35:57 -0800
In-Reply-To: <1330094465-4625-1-git-send-email-andre.guedes@openbossa.org>
References: <1330094465-4625-1-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> According to last discussion on IRC, if an interleaved discovery is
> issued, but the device is not dual mode, we should return error
> instead of performing a regular BR/EDR or LE-only discovery.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/mgmt.c |   29 +++++------------------------
>  1 file changed, 5 insertions(+), 24 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


