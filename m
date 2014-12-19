Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 1/3] bluetooth: hidp_connection_add() unsafe use of l2cap_pi()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1418970059-32486-1-git-send-email-viro@ZenIV.linux.org.uk>
Date: Fri, 19 Dec 2014 13:49:01 +0100
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Message-Id: <449207B2-2CFB-43B6-BD2E-958652087D58@holtmann.org>
References: <20141219061801.GU22149@ZenIV.linux.org.uk> <1418970059-32486-1-git-send-email-viro@ZenIV.linux.org.uk>
To: Al Viro <viro@ZenIV.linux.org.uk>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Al,

> it's OK after we'd verified the sockets, but not before that.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> net/bluetooth/hidp/core.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

patch has been applied to bluetooth tree.

Regards

Marcel

