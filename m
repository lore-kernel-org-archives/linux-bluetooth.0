Return-Path: <cyrus@holtmann.org>
Message-ID: <1329115057.28848.52.camel@aeonflux>
Subject: Re: [PATCH 2/2] bluetooth: Convert BT_DBG to pr_debug
From: Marcel Holtmann <marcel@holtmann.org>
To: Joe Perches <joe@perches.com>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	"David S. Miller" <davem@davemloft.net>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Date: Mon, 13 Feb 2012 07:37:37 +0100
In-Reply-To: <90fbd8a0b800c83f5ad1df7889dc9b11d7d9c588.1329102581.git.joe@perches.com>
References: <cover.1329102581.git.joe@perches.com>
	 <90fbd8a0b800c83f5ad1df7889dc9b11d7d9c588.1329102581.git.joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joe,

> No need to obfuscate, just use the normal debugging macro.
> 
> Add "\n" to uses, align arguments, coalesce formats.
> Fix a typo and fix a bad format extended by a line continuation.

what is this patch buying us. Nothing at all. I rather not do this and
leave BT_DBG in it.

The only useful change would be to move to dev_printk, but we are not
there yet.

Regards

Marcel


