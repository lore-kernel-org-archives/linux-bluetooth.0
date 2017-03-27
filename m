Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH] Bluetooth: bluecard: use setup_timer
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <e0af154c08327dbf266e641b135e4ef340913feb.1489061552.git.geliangtang@gmail.com>
Date: Mon, 27 Mar 2017 16:11:28 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <96F9530E-0D92-4728-B394-6B5402D0F38B@holtmann.org>
References: <3afa5498142ef68256023257dad37b9f8352e65e.1489060803.git.geliangtang@gmail.com>
 <e0af154c08327dbf266e641b135e4ef340913feb.1489061552.git.geliangtang@gmail.com>
To: Geliang Tang <geliangtang@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Geliang,

> Use setup_timer() instead of init_timer() to simplify the code.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> drivers/bluetooth/bluecard_cs.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

