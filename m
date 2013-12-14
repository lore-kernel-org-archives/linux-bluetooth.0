Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [PATCH -next v2] Bluetooth: fix return value check
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAPgLHd-RYQ14ZoEKZGm0iO5JVkPmr5s1k+H6nh4OR=Wr=r8EfQ@mail.gmail.com>
Date: Sat, 14 Dec 2013 15:50:42 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	yongjun_wei@trendmicro.com.cn,
	"linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <C7E9E334-8A03-487E-9B3C-4A016E3B1F9C@holtmann.org>
References: <CAPgLHd-RYQ14ZoEKZGm0iO5JVkPmr5s1k+H6nh4OR=Wr=r8EfQ@mail.gmail.com>
To: Wei Yongjun <weiyj.lk@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wei,

> In case of error, the function bt_skb_alloc() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check should
> be replaced with NULL test.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
> net/bluetooth/6lowpan.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

