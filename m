Return-Path: <cyrus@holtmann.org>
Date: Sat, 16 Oct 2010 20:09:07 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@nokia.com>
Subject: Re: [PATCH] Bluetooth: Fix non-SSP auth request for HIGH security
 level sockets
Message-ID: <20101016230907.GA12187@vigoh>
References: <1287128769-5078-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287128769-5078-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2010-10-15 10:46:09 +0300]:

> From: Johan Hedberg <johan.hedberg@nokia.com>
> 
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
> ---
>  net/bluetooth/hci_event.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)

Applied, thanks.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
