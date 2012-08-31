Return-Path: <cyrus@holtmann.org>
Message-ID: <1346429495.23377.20.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Use GFP_KERNEL in read_index_list
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 31 Aug 2012 09:11:35 -0700
In-Reply-To: <1346396746-3479-1-git-send-email-szymon.janc@tieto.com>
References: <1346396746-3479-1-git-send-email-szymon.janc@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> read_index_list is executed by user thread running in kernel-mode
> thus is allowed to sleep.
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  net/bluetooth/mgmt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


