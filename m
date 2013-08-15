Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Aug 2013 09:56:20 +0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] btmrvl_sdio: use DIV_ROUND_UP in suitable places
Message-ID: <20130815075620.GA1980@joana>
References: <1375441812-13852-1-git-send-email-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1375441812-13852-1-git-send-email-andriy.shevchenko@linux.intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andy,

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [2013-08-02 14:10:12 +0300]:

> There are two places where DIV_ROUND_UP may be used. It makes code a bit
> clearer.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/bluetooth/btmrvl_sdio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
