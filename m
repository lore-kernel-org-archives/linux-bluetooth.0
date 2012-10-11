Return-Path: <cyrus@holtmann.org>
Message-ID: <1349963436.27233.171.camel@aeonflux>
Subject: Re: [PATCH -v2 5/8] Bluetooth: Remove GFP_ATOMIC usage from
 l2cap_core.c
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Thu, 11 Oct 2012 15:50:36 +0200
In-Reply-To: <1349938311-25101-5-git-send-email-gustavo@padovan.org>
References: <1349938311-25101-1-git-send-email-gustavo@padovan.org>
	 <1349938311-25101-5-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Since we change the Bluetooth core to run in process context we don't need
> to use GFP_ATOMIC in many of places we were using it. The we just replace
> by GFP_KERNEL.

I assume you double-checked that we nowhere hold a lock or the caller
holds a lock.

> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>  net/bluetooth/l2cap_core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


