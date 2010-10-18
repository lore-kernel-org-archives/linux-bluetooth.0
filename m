Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] bluetooth: fix unaligned access to l2cap conf data
From: Marcel Holtmann <marcel@holtmann.org>
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-bluetooth@vger.kernel.org,
	uclinux-dist-devel@blackfin.uclinux.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	steven miao <realmz6@gmail.com>
In-Reply-To: <1287268187-9628-1-git-send-email-vapier@gentoo.org>
References: <1287268187-9628-1-git-send-email-vapier@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 18 Oct 2010 13:51:46 +0200
Message-ID: <1287402706.3316.126.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

> In function l2cap_get_conf_opt() and l2cap_add_conf_opt() the address of
> opt->val sometimes is not at the edge of 2-bytes/4-bytes, so 2-bytes/4 bytes
> access will cause data misalignment exeception.  Use get_unaligned_le16/32
> and put_unaligned_le16/32 function to avoid data misalignment execption.
> 
> Signed-off-by: steven miao <realmz6@gmail.com>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
> was posted a month ago with no feedback ...

must have slipped through. However I don't remember it being on
linux-bluetooth at all. Maybe it was on the other mailing lists :(

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


