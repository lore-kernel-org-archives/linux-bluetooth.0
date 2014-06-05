Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Jun 2014 15:29:11 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Adam Lee <adam8157@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: ath3k: reduce pipe setting times in
 ath3k_load_fwfile()
Message-ID: <20140605182911.GB1944@joana>
References: <20140527131548.GB2034@joana>
 <1401976064-6736-1-git-send-email-adam8157@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1401976064-6736-1-git-send-email-adam8157@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Adam,

2014-06-05 Adam Lee <adam8157@gmail.com>:

> Invoking usb_sndbulkpipe() on same pipe for same purpose only once is
> enough.
> 
> Signed-off-by: Adam Lee <adam8157@gmail.com>
> ---
>  drivers/bluetooth/ath3k.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
