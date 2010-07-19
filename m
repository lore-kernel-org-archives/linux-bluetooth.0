Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Use __packed annotation
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
In-Reply-To: <1279515613-710-1-git-send-email-gustavo@padovan.org>
References: <1279515613-710-1-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 18 Jul 2010 23:10:23 -0700
Message-ID: <1279519823.4572.17.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> To make net/ and include/net/ code consistent use __packed instead of
> __attribute__ ((packed)). Bluetooth subsystem was one of the last net
> subsys still using __attribute__ ((packed)).
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  include/net/bluetooth/bluetooth.h |    2 +-
>  include/net/bluetooth/hci.h       |  184 ++++++++++++++++++------------------
>  include/net/bluetooth/l2cap.h     |   26 +++---
>  include/net/bluetooth/rfcomm.h    |   14 ++--
>  4 files changed, 113 insertions(+), 113 deletions(-)

patch has been applied. Thanks.

Regards

Marcel


