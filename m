Return-Path: <cyrus@holtmann.org>
Subject: Re: [patch] bluetooth: ath3k: add kfree() on error path
From: Marcel Holtmann <marcel@holtmann.org>
To: Dan Carpenter <error27@gmail.com>
Cc: Alicke Xu <sxu@atheros.com>,
	"Luis R. Rodriguez" <lrodriguez@atheros.com>,
	Vikram Kandukuri <vikram.kandukuri@atheros.com>,
	linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20100208054317.GA10576@bicker>
References: <20100208054317.GA10576@bicker>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 08 Feb 2010 09:00:52 +0100
Message-ID: <1265616052.31341.256.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

> Add a couple kfree() calls on an error path.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> ---
> I only compile tested this one and it's obvoiusly low priority.  Could it go into linux-next?

patch has been applied. Thanks.

Regards

Marcel


