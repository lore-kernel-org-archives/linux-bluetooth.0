Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Sep 2010 16:49:19 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: fix MTU L2CAP configuration parameter
Message-ID: <20100902194919.GC11191@vigoh>
References: <1283343445-9328-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283343445-9328-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2010-09-01 15:17:25 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> 
> When receiving L2CAP negative configuration response with respect
> to MTU parameter we modify wrong field. MTU here means proposed
> value of MTU that the remote device intends to transmit. So for local
> L2CAP socket it is pi->imtu.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>  net/bluetooth/l2cap.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
