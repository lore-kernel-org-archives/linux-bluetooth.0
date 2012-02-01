Return-Path: <cyrus@holtmann.org>
Message-ID: <1328131832.1955.239.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Fix invalid memory access when there's no
 SMP channel
From: Marcel Holtmann <marcel@holtmann.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 01 Feb 2012 13:30:32 -0800
In-Reply-To: <1328131676-29171-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328131676-29171-1-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

> We only should try to free the SMP channel that was created if there
> is a pending SMP session.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/smp.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


