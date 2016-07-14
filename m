Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Bluetooth: Fix l2cap_sock_setsockopt() with optname BT_RCVMTU
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1468486223-10140-1-git-send-email-amadeusz.slawinski@tieto.com>
Date: Thu, 14 Jul 2016 10:07:39 +0100
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>
Message-Id: <D20D6768-AF6A-46F8-8F4F-786A908F4521@holtmann.org>
References: <1468486223-10140-1-git-send-email-amadeusz.slawinski@tieto.com>
To: =?utf-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
	<amadeusz.slawinski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amadeusz,

> When we retrieve imtu value from userspace we should use 16 bit pointer
> cast instead of 32 as it's defined that way in headers. Fixes setsockopt
> calls on big-endian platforms.
> 
> Signed-off-by: Amadeusz Sławiński <amadeusz.slawinski@tieto.com>
> ---
> net/bluetooth/l2cap_sock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

