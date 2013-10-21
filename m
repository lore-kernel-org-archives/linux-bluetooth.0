Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 1/3] Bluetooth: Add L2CAP channel to skb private data
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1382386946-19797-1-git-send-email-gustavo@padovan.org>
Date: Mon, 21 Oct 2013 22:53:47 +0200
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Message-Id: <F944D94A-0708-4CE4-99BF-C54E6736FEA5@holtmann.org>
References: <1382386946-19797-1-git-send-email-gustavo@padovan.org>
To: Gustavo Padovan <gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Adding the channel to the skb private data makes possible to us know which
> channel the skb we have came from.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk
> ---
> include/net/bluetooth/bluetooth.h | 1 +
> net/bluetooth/l2cap_sock.c        | 2 ++
> 2 files changed, 3 insertions(+)

all 3 patches have been applied bluetooth-next tree.

Regards

Marcel

