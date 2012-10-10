Return-Path: <cyrus@holtmann.org>
Message-ID: <1349891290.27233.154.camel@aeonflux>
Subject: Re: [PATCH 3/4] Bluetooth: Use __constant modifier for L2CAP SMP CID
From: Marcel Holtmann <marcel@holtmann.org>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 10 Oct 2012 19:48:10 +0200
In-Reply-To: <1349887169-20880-3-git-send-email-s.syam@samsung.com>
References: <1349887169-20880-1-git-send-email-s.syam@samsung.com>
	 <1349887169-20880-3-git-send-email-s.syam@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

> Since the L2CAP_CID_SMP is constant, __constant_cpu_to_le16() is
> the right go here.
> 
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> ---
>  net/bluetooth/smp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


