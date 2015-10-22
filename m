Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: [patch] Bluetooth: hci_bcm: checking for ERR_PTR instead of NULL
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20151022090609.GA9202@mwanda>
Date: Thu, 22 Oct 2015 11:33:16 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Message-Id: <F7002528-3BCE-4A94-B9F5-7C1CF0B54745@holtmann.org>
References: <20151022090609.GA9202@mwanda>
To: Dan Carpenter <dan.carpenter@oracle.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

> bt_skb_alloc() returns NULL on error, it never returns an ERR_PTR.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

patch has been applied to bluetooth-next tree.

Regards

Marcel

