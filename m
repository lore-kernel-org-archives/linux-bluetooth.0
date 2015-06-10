Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] bluetooth: stop sabotaging list poisoning
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150610172832.GA8898@p183.telecom.by>
Date: Thu, 11 Jun 2015 01:24:33 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <976A7858-68B4-4412-9BCF-546C71986645@holtmann.org>
References: <20150610172832.GA8898@p183.telecom.by>
To: Alexey Dobriyan <adobriyan@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexey,

> list_del() poisons pointers with special values, no need to overwrite them.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
> net/bluetooth/l2cap_core.c |    8 ++------
> 1 file changed, 2 insertions(+), 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

