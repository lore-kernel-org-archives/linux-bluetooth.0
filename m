Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Fix non-SSP auth request for HIGH security
 level sockets
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@nokia.com>
In-Reply-To: <1287128769-5078-1-git-send-email-johan.hedberg@gmail.com>
References: <1287128769-5078-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 15 Oct 2010 12:16:35 +0300
Message-ID: <1287134195.3316.60.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When initiating dedicated bonding a L2CAP raw socket with HIGH security
> level is used. The kernel is supposed to trigger the authentication
> request in this case but this doesn't happen currently for non-SSP
> (pre-2.1) devices. The reason is that the authentication request happens
> in the remote extended features callback which never gets called for
> non-SSP devices. This patch fixes the issue by requesting also
> authentiation in the (normal) remote features callback in the case of
> non-SSP devices.
> 
> This rule is applied only for HIGH security level which might at first
> seem unintuitive since on the server socket side MEDIUM is already
> enough for authentication. However, for the clients we really want to
> prefer the server side to decide the authentication requrement in most
> cases, and since most client sockets use MEDIUM it's better to be
> avoided on the kernel side for these sockets. The important socket to
> request it for is the dedicated bonding one and that socket uses HIGH
> security level.
> 
> The patch is based on the initial investigation and patch proposal from
> Andrei Emeltchenko <endrei.emeltchenko@nokia.com>.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>

so I had a quick review here on this one. Looks fine to me and it makes
sense.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


