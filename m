Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 00/12] Caching LE advertising information
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1304701521-26459-1-git-send-email-andre.guedes@openbossa.org>
References: <1304701521-26459-1-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 11 May 2011 18:23:34 -0700
Message-ID: <1305163414.15916.165.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patchset implements the LE advertising cache which is used
> to establish LE connections.
> 
> Today, we cannot establish LE connections (via l2cap socket) with
> devices which use random address type. To achieve that, we came up
> with a solution where the host should be able to infer the address
> type (public or random) from the device it wants to connect to.
> 
> The approach this patchset implements is: during the LE scanning,
> the host stores the address and the address type gathered from
> advertising reports. These information are stored at the advertising
> cache. So, during a LE connection, the host looks up the advertising
> cache and gets the address type from the device it wants to connect
> to.

I would prefer if we try using the cache as long as possible. As long as
this works out it should be fine. Adding the BDADDR_TYPE to all public
socket address structures seems a bit of a pain to me.

And as backup we can always revert to that, but we can never ever remove
that address from the socket structure. While we can remove the cache if
we no longer need it.

Regards

Marcel


