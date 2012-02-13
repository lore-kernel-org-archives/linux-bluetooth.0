Return-Path: <cyrus@holtmann.org>
Message-ID: <1329117558.28848.53.camel@aeonflux>
Subject: Re: [PATCH 2/2] bluetooth: Convert BT_DBG to pr_debug
From: Marcel Holtmann <marcel@holtmann.org>
To: Joe Perches <joe@perches.com>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	"David S. Miller" <davem@davemloft.net>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Date: Mon, 13 Feb 2012 08:19:18 +0100
In-Reply-To: <1329115904.30878.7.camel@joe2Laptop>
References: <cover.1329102581.git.joe@perches.com>
	 <90fbd8a0b800c83f5ad1df7889dc9b11d7d9c588.1329102581.git.joe@perches.com>
	 <1329115057.28848.52.camel@aeonflux> <1329115904.30878.7.camel@joe2Laptop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joe,

> > > No need to obfuscate, just use the normal debugging macro.
> > > Add "\n" to uses, align arguments, coalesce formats.
> > > Fix a typo and fix a bad format extended by a line continuation.
> > what is this patch buying us.
> 
> Easier greps of pr_debug.
> BT_DBG is just an unnecessary useless wrapper.
> 
> > The only useful change would be to move to dev_printk, but we are not
> > there yet.
> 
> Maybe dev_dbg, but there isn't always an
> appropriate device * available.

exactly. And that needs to be fixed first. People are working on getting
some old legacy 2.4 leftovers out of this subsystem so we can have first
call struct device everywhere.

Regards

Marcel


