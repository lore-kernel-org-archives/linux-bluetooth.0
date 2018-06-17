Return-Path: <netdev-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH COMMITTED] bluetooth: hci_nokia: Don't include
 linux/unaligned/le_struct.h directly.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180616.164059.1116555189277956188.davem@davemloft.net>
Date: Sun, 17 Jun 2018 09:42:03 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <ACBA32F4-EFD6-488C-B3F6-358C8882C322@holtmann.org>
References: <20180616.164059.1116555189277956188.davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dave,

> This breaks the build as this header is not meant to be used in this
> way.
> 
> ./include/linux/unaligned/access_ok.h:8:28: error: redefinition of ‘get_unaligned_le16’
> static __always_inline u16 get_unaligned_le16(const void *p)
>                            ^~~~~~~~~~~~~~~~~~
> In file included from drivers/bluetooth/hci_nokia.c:32:
> ./include/linux/unaligned/le_struct.h:7:19: note: previous definition of ‘get_unaligned_le16’ was here
> static inline u16 get_unaligned_le16(const void *p)
> 
> Use asm/unaligned.h instead.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
> drivers/bluetooth/hci_nokia.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel
