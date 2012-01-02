Return-Path: <cyrus@holtmann.org>
Message-ID: <1325542684.1965.394.camel@aeonflux>
Subject: Re: [PATCH 1/5] Bluetooth: Fix context in rfcomm_sock_lock
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 02 Jan 2012 14:18:04 -0800
In-Reply-To: <1325006928-3338-1-git-send-email-padovan@profusion.mobi>
References: <1325006928-3338-1-git-send-email-padovan@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Code now run in process context, does not need to disable interrupt
> anymore.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/rfcomm/sock.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

However I get the feeling that we might should mover all the Bluetooth
specific socket list locking to RCU.

Regards

Marcel


