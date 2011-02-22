Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Feb 2011 09:26:41 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetooth: remove unnecessary call to hci_sock_cleanup
Message-ID: <20110222122641.GC2249@joana>
References: <1298358806-13257-1-git-send-email-gadiyar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298358806-13257-1-git-send-email-gadiyar@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anand,

* Anand Gadiyar <gadiyar@ti.com> [2011-02-22 12:43:26 +0530]:

> hci_sock_cleanup is already called after the sock_err label.
> It appears that we can drop this call.
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Cc: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/af_bluetooth.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Also applied, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
