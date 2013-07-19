Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH] bluetooth: replace strict_strtol() with kstrtol()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <000f01ce844e$eeba10d0$cc2e3270$@samsung.com>
Date: Fri, 19 Jul 2013 06:42:08 -0700
Cc: 'Gustavo Padovan' <gustavo@padovan.org>,
	'Johan Hedberg' <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <973071C0-FCE1-44D8-8EF8-B573476342A3@holtmann.org>
References: <000f01ce844e$eeba10d0$cc2e3270$@samsung.com>
To: Jingoo Han <jg1.han@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jingoo,

> The usage of strict_strtol() is not preferred, because
> strict_strtol() is obsolete. Thus, kstrtol() should be
> used.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
> drivers/bluetooth/btmrvl_debugfs.c |    6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

