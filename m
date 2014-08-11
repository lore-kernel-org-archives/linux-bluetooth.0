Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 1/4] mac802154: cleanup in rx path
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1407756310-26592-2-git-send-email-alex.aring@gmail.com>
Date: Mon, 11 Aug 2014 12:18:09 -0700
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
	kernel@pengutronix.de, Varka Bhadram <varkab@cdac.in>
Message-Id: <8964B6B1-55A7-4980-AEDA-FD2A41D89ED5@holtmann.org>
References: <1407756310-26592-1-git-send-email-alex.aring@gmail.com> <1407756310-26592-2-git-send-email-alex.aring@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> From: Varka Bhadram <varkab@cdac.in>
> 
> This patch replace the sizeof(struct rx_work) with sizeof(*work)
> and directly passing the skb in mac802154_subif_rx()
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/mac802154/rx.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

