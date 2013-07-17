Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH 1/1 v2] Bluetooth: Fix ACL alive for long in case of non pariable devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1374078638-3248-1-git-send-email-syamsidhardh@gmail.com>
Date: Wed, 17 Jul 2013 09:40:52 -0700
Cc: linux-bluetooth@vger.kernel.org,
	Syam Sidhardhan <s.syam@samsung.com>
Message-Id: <EDEF901A-564A-4532-B291-61F0CCDB9BFD@holtmann.org>
References: <1374078638-3248-1-git-send-email-syamsidhardh@gmail.com>
To: Syam Sidhardhan <syamsidhardh@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

> For certain devices (ex: HID mouse), support for authentication,
> pairing and bonding is optional. For such devices, the ACL alive
> for too long after the L2CAP disconnection.
> 
> To avoid the ACL alive for too long after L2CAP disconnection, reset the ACL
> disconnect timeout back to HCI_DISCONN_TIMEOUT when L2CAP is connected.
> 
> While merging the commit id:a9ea3ed9b71cc3271dd59e76f65748adcaa76422
> this issue might have introduced.
> 
> Signed-off-by: Sang-Ki Park <sangki79.park@samsung.com>
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> ---
> v1 -> Modified the code as per the latest code.
> v2 -> Add descriptive comment as per Marcel request.
> 
> net/bluetooth/l2cap_core.c |    9 +++++++++
> 1 file changed, 9 insertions(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

