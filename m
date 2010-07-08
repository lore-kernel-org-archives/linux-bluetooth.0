Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] bluetooth: btmrvl_sdio: silence warning
From: Marcel Holtmann <marcel@holtmann.org>
To: Kulikov Vasiliy <segooon@gmail.com>
Cc: Kernel Janitors <kernel-janitors@vger.kernel.org>,
	Bing Zhao <bzhao@marvell.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	=?ISO-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>,
	Julia Lawall <julia@diku.dk>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <1278316883-29784-1-git-send-email-segooon@gmail.com>
References: <1278316883-29784-1-git-send-email-segooon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Jul 2010 18:02:39 -0300
Message-ID: <1278622959.10421.68.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kulikov,

> Clone checking of ret to simplify the code.
> 
> This patch silences a compiler warning:
> drivers/bluetooth/btmrvl_sdio.c: In function ‘btmrvl_sdio_verify_fw_download’:
> drivers/bluetooth/btmrvl_sdio.c:80: warning: ‘fws1’ may be used uninitialized in this function
> drivers/bluetooth/btmrvl_sdio.c:80: note: ‘fws1’ was declared here
> 
> Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>

patch has been applied to bluetooth-next-2.6 tree. Thanks.

Regards

Marcel


