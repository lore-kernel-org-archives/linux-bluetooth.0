Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 9/20] drivers/bluetooth: Use kzalloc
From: Marcel Holtmann <marcel@holtmann.org>
To: Julia Lawall <julia@diku.dk>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.1005132201470.6282@ask.diku.dk>
References: <Pine.LNX.4.64.1005132201470.6282@ask.diku.dk>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Jul 2010 19:01:19 -0300
Message-ID: <1278626479.10421.85.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Julia,

> Use kzalloc rather than the combination of kmalloc and memset.
> 

patch has been applied to bluetooth-next-2.6 tree. Thanks.

Regards

Marcel


