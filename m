Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] bluetooth:Make the function sco_conn_del have a return type of void
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1439947381-11251-1-git-send-email-xerofoify@gmail.com>
Date: Wed, 19 Aug 2015 16:09:53 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-Id: <8A2DFDCC-6061-4342-A5EA-4564AE362E9A@holtmann.org>
References: <1439947381-11251-1-git-send-email-xerofoify@gmail.com>
To: Nicholas Krause <xerofoify@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nicholas,

> This makes the function sco_conn_del have a return type of void now
> due to this function always running successfully and thus never
> needing to signal its caller when a non recoverable internal failure
> occurs by returning a error code to its respective caller.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
> net/bluetooth/sco.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

