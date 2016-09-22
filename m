Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Re: [PATCH 3/3] Bluetooth: Fix not updating scan rsp when adv off
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1474552899-3837-3-git-send-email-michal.narajowski@codecoup.pl>
Date: Thu, 22 Sep 2016 17:48:38 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0343787F-5737-4FA3-A54B-5FA8DF22A08B@holtmann.org>
References: <1474552899-3837-1-git-send-email-michal.narajowski@codecoup.pl>
 <1474552899-3837-3-git-send-email-michal.narajowski@codecoup.pl>
To: =?utf-8?Q?Micha=C5=82_Narajowski?= <michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

> Scan response data should not be updated unless there
> is an advertising instance.
> 
> Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
> ---
> net/bluetooth/mgmt.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

