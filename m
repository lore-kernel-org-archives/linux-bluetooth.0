Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Jul 2013 12:02:33 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Marcel Holtmann' <marcel@holtmann.org>,
	'Johan Hedberg' <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetooth: replace strict_strtol() with kstrtol()
Message-ID: <20130725110232.GB9913@joana>
References: <000f01ce844e$eeba10d0$cc2e3270$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000f01ce844e$eeba10d0$cc2e3270$@samsung.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jingoo,

* Jingoo Han <jg1.han@samsung.com> [2013-07-19 16:09:38 +0900]:

> The usage of strict_strtol() is not preferred, because
> strict_strtol() is obsolete. Thus, kstrtol() should be
> used.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/bluetooth/btmrvl_debugfs.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
