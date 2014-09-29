Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: 6lowpan: Make sure skb exists before accessing it
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1411977346-10219-1-git-send-email-jukka.rissanen@linux.intel.com>
Date: Mon, 29 Sep 2014 10:37:51 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5E3C4608-1AAC-4745-8AEE-2B8152816531@holtmann.org>
References: <1411977346-10219-1-git-send-email-jukka.rissanen@linux.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> We need to make sure that the saved skb exists when
> resuming or suspending a CoC channel. This can happen if
> initial credits is 0 when channel is connected.
> 
> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
> net/bluetooth/6lowpan.c | 6 ++++++
> 1 file changed, 6 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

