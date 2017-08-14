Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] net/bluetooth: make bluetooth socket can be created in
 net namespace
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170814071640.289327-1-fupan.li@windriver.com>
Date: Mon, 14 Aug 2017 11:30:02 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <6EC96C1E-CE98-4CF1-B1B2-1CEC9DBC36EA@holtmann.org>
References: <20170814071640.289327-1-fupan.li@windriver.com>
To: fupan.li@windriver.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fupan,

> By now kernel only supported creating bluetooth socket in init_net
> net namespace, which made bluetooth device cannot be accessed in
> containers, this patch made bluetooth socket can be created in
> net namespaces to fix this issue.
> 
> Signed-off-by: Fupan Li <fupan.li@windriver.com>
> ---
> net/bluetooth/af_bluetooth.c | 2 +-
> net/bluetooth/bnep/sock.c    | 4 ++--
> net/bluetooth/cmtp/sock.c    | 4 ++--
> net/bluetooth/hci_sock.c     | 4 ++--
> net/bluetooth/hidp/sock.c    | 4 ++--
> net/bluetooth/l2cap_sock.c   | 4 ++--
> net/bluetooth/rfcomm/core.c  | 2 +-
> net/bluetooth/rfcomm/sock.c  | 4 ++--
> net/bluetooth/sco.c          | 4 ++--
> 9 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index 91e3ba280706..eec5ac17faee 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -113,7 +113,7 @@ static int bt_sock_create(struct net *net, struct socket *sock, int proto,
> {
> 	int err;
> 
> -	if (net != &init_net)
> +	if (!net_eq(net, current->nsproxy->net_ns)) 
> 		return -EAFNOSUPPORT;

before I apply such a patch, what is the actual change here. What impact does this have? Are things like Bluetooth mgmt sockets still operating correctly after this? We have no support for move a Bluetooth controller into a container. The Bluetooth hardware is global.

Regards

Marcel
