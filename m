Return-Path: <afzal.mohd.ma@gmail.com>
Date: Sat, 23 Apr 2016 12:17:45 +0530
From: Afzal Mohammed <afzal.mohd.ma@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [patch] Bluetooth: ath3k: Silence uninitialized variable warning
Message-ID: <20160423064745.GA4826@afzalpc>
References: <20160422100255.GE11398@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160422100255.GE11398@mwanda>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Apr 22, 2016 at 01:02:55PM +0300, Dan Carpenter wrote:

> -	int err, pipe, len, size, count, sent = 0;
> +	int len = 0;
> +	int err, pipe, size, count, sent = 0;

Is there any particular reason to avoid more than 1 variable
initialization in definition on a single line ?, like,

	int err, pipe, size, count, sent = 0, len = 0;

have observed that none of your uninitialized variable warning fixes
does as mentioned above.

Regards
afzal
