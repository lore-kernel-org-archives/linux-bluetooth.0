Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: 6lowpan: Do not free skb when packet is dropped
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1418213993-24884-1-git-send-email-jukka.rissanen@linux.intel.com>
Date: Fri, 19 Dec 2014 13:43:35 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6EE19905-6559-46A0-B475-01D5513C00F3@holtmann.org>
References: <1418213993-24884-1-git-send-email-jukka.rissanen@linux.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> If we need to drop the message because of some error in the
> compression etc, then do not free the skb as that is done
> automatically in other part of networking stack.
> 
> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
> net/bluetooth/6lowpan.c | 1 -
> 1 file changed, 1 deletion(-)

patch has been applied to bluetooth tree.

Regards

Marcel

