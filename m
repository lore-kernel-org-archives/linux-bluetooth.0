Return-Path: <cyrus@holtmann.org>
Date: Tue, 09 Dec 2008 04:44:24 -0800 (PST)
Message-Id: <20081209.044424.134557406.davem@davemloft.net>
To: a.beregalov@gmail.com
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, mingo@elte.hu,
 linux-next@vger.kernel.org
Subject: Re: [PATCH] rfcomm/sock: fix build problem
From: David Miller <davem@davemloft.net>
In-Reply-To: <20081209123950.GA31294@orion>
References: <20081209123950.GA31294@orion>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alexander Beregalov <a.beregalov@gmail.com>
Date: Tue, 9 Dec 2008 15:39:50 +0300

> net/bluetooth/rfcomm/sock.c: In function 'rfcomm_sock_ioctl':
> net/bluetooth/rfcomm/sock.c:795: error: 'sk' undeclared (first use in this function)
> net/bluetooth/rfcomm/sock.c:795: error: (Each undeclared identifier is reported only once
> net/bluetooth/rfcomm/sock.c:795: error: for each function it appears in.)
> 
> It is a conflict between a418b893
> (Bluetooth: Enable per-module dynamic debug messages)
> and 45555c0e
> (bluetooth: fix warning in net/bluetooth/rfcomm/sock.c)
> 
> Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>

Already fixed in net-next-2.6.

BTW, your patch reintroduces a warning.
