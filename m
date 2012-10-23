Return-Path: <cyrus@holtmann.org>
Message-ID: <1351003516.1785.29.camel@aeonflux>
Subject: Re: [PATCH 3/5] Bluetooth: Replace include linux/module.h with
 linux/export.h
From: Marcel Holtmann <marcel@holtmann.org>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 23 Oct 2012 07:45:16 -0700
In-Reply-To: <1350999140-7481-3-git-send-email-s.syam@samsung.com>
References: <1350999140-7481-1-git-send-email-s.syam@samsung.com>
	 <1350999140-7481-3-git-send-email-s.syam@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

> include <linux/export.h> is the right to go here.
> 
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> ---
>  net/bluetooth/cmtp/capi.c |    2 +-
>  net/bluetooth/cmtp/sock.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


