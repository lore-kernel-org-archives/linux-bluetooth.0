Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Mar 2013 11:57:11 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: bluetooth: Use PTR_RET function
Message-ID: <20130318145711.GB16337@joana>
References: <1363443003-13839-1-git-send-email-gheorghiuandru@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363443003-13839-1-git-send-email-gheorghiuandru@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexandru,

* Alexandru Gheorghiu <gheorghiuandru@gmail.com> [2013-03-16 16:10:03 +0200]:

> Used PTR_RET function instead of IS_ERR and PTR_ERR.
> Patch found using coccinelle.
> 
> Signed-off-by: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
> ---
>  net/bluetooth/hci_sysfs.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
