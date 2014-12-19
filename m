Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 2/3] cmtp: cmtp_add_connection() should verify that it's dealing with l2cap socket
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1418970059-32486-2-git-send-email-viro@ZenIV.linux.org.uk>
Date: Fri, 19 Dec 2014 13:48:55 +0100
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Message-Id: <19614F21-1294-45D9-B5E0-CD48A68B4700@holtmann.org>
References: <20141219061801.GU22149@ZenIV.linux.org.uk> <1418970059-32486-2-git-send-email-viro@ZenIV.linux.org.uk>
To: Al Viro <viro@ZenIV.linux.org.uk>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Al,

> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> ... rather than relying on ciptool(8) never passing it anything else.  Give
> it e.g. an AF_UNIX connected socket (from socketpair(2)) and it'll oops,
> trying to evaluate &l2cap_pi(sock->sk)->chan->dst...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> net/bluetooth/cmtp/core.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth tree.

Regards

Marcel

