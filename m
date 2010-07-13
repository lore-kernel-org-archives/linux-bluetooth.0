Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 3/5] Bluetooth: create a l2cap dir
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
In-Reply-To: <1279033035-24708-3-git-send-email-gustavo@padovan.org>
References: <1279033035-24708-1-git-send-email-gustavo@padovan.org>
	 <1279033035-24708-2-git-send-email-gustavo@padovan.org>
	 <1279033035-24708-3-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Jul 2010 14:13:48 -0300
Message-ID: <1279041228.6282.20.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> The dir is being created looking forward to the l2cap.c split.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/Makefile       |    2 +-
>  net/bluetooth/l2cap.c        | 4859 ------------------------------------------
>  net/bluetooth/l2cap/Makefile |    5 +
>  net/bluetooth/l2cap/l2cap.c  | 4859 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 4865 insertions(+), 4860 deletions(-)
>  delete mode 100644 net/bluetooth/l2cap.c
>  create mode 100644 net/bluetooth/l2cap/Makefile
>  create mode 100644 net/bluetooth/l2cap/l2cap.c

hold off with this changes. We are not doing a separate directory
anyway. I need more time to think about it.

Regards

Marcel


