Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 May 2012 13:17:07 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Minho Ban <mhban@samsung.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix null pointer dereference in
 l2cap_chan_send
Message-ID: <20120521161707.GD16942@joana>
References: <4FB9932B.9070101@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FB9932B.9070101@samsung.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Minho,

* Minho Ban <mhban@samsung.com> [2012-05-21 09:58:19 +0900]:

> If l2cap_chan_send is called will null conn it will cause kernel Oops.
> This patch checks if conn is valid before entering l2cap_chan_send.

chan->conn should be always valid, and if not we have a bug somewhere else in
the code and not in l2cap_chan_send(). It could be a locking problem maybe.
Also check if you can reproduce this with latest bluetooth-next.

	Gustavo
