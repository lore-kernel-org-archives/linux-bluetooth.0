Return-Path: <cyrus@holtmann.org>
Message-ID: <1324414720.1965.131.camel@aeonflux>
Subject: Re: [PATCH 1/2] Bluetooth: fix bt_accept_dequeue() to work in
 process context
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 20 Dec 2011 12:58:40 -0800
In-Reply-To: <1324408558-24653-1-git-send-email-padovan@profusion.mobi>
References: <1324408558-24653-1-git-send-email-padovan@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> No local_bh_disable is needed there once we run everything in process
> context. The same goes for the replacement of bh_lock_sock() by
> lock_sock().
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/af_bluetooth.c |   11 ++++-------
>  1 files changed, 4 insertions(+), 7 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


