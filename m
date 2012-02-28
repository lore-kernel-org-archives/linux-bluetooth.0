Return-Path: <cyrus@holtmann.org>
Message-ID: <1330445968.3392.79.camel@aeonflux>
Subject: Re: [patch] Bluetooth: use kfree_skb() instead of kfree()
From: Marcel Holtmann <marcel@holtmann.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	Andrei Emeltchenko <andrei.emeltchenko@intel.com>,
	linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Date: Tue, 28 Feb 2012 08:19:28 -0800
In-Reply-To: <20120228065246.GC20506@elgon.mountain>
References: <20120228065246.GC20506@elgon.mountain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

> sk_buffs should be freed using kfree_skb().
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

sadly these keep slipping in every now and then.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


