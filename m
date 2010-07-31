Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] bluetooth: Use list_head for hci blacklist head.
From: Marcel Holtmann <marcel@holtmann.org>
To: David Miller <davem@davemloft.net>
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <20100730.215449.226772568.davem@davemloft.net>
References: <20100730.215449.226772568.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 31 Jul 2010 09:16:17 -0700
Message-ID: <1280592977.12579.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dave,

> The bdaddr in the list root is completely unused and just
> taking up space.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>

looks fine to me.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

in case you wanna add it directly to net-next-2.6 tree.

Johan, wanna do a quick test-run of this patch and add Tested-by.

Regards

Marcel


