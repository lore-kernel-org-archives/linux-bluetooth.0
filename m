Return-Path: <cyrus@holtmann.org>
Message-ID: <1349891329.27233.155.camel@aeonflux>
Subject: Re: [PATCH 4/4] Bluetooth: Use __constant modifier for RFCOMM PSM
From: Marcel Holtmann <marcel@holtmann.org>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 10 Oct 2012 19:48:49 +0200
In-Reply-To: <1349887169-20880-4-git-send-email-s.syam@samsung.com>
References: <1349887169-20880-1-git-send-email-s.syam@samsung.com>
	 <1349887169-20880-4-git-send-email-s.syam@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

> Since the RFCOMM_PSM is constant, __constant_cpu_to_le16() is
> the right go here.
> 
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> ---
>  net/bluetooth/rfcomm/core.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


