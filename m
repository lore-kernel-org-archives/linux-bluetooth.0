Return-Path: <cyrus@holtmann.org>
Message-ID: <1337771517.15105.77.camel@aeonflux>
Subject: Re: [PATCH 1/6] Bluetooth: Remove most of the inline usage
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Wed, 23 May 2012 13:11:57 +0200
In-Reply-To: <1337756663-19805-1-git-send-email-gustavo@padovan.org>
References: <1337756663-19805-1-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Only obvious cases were left as inline, mostly oneline functions.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>  net/bluetooth/bnep/core.c   |    4 +-
>  net/bluetooth/bnep/netdev.c |    6 +-
>  net/bluetooth/hci_core.c    |   33 +++++-----
>  net/bluetooth/hci_event.c   |  144 ++++++++++++++++++-------------------------
>  net/bluetooth/hci_sock.c    |    6 +-
>  net/bluetooth/hidp/core.c   |    4 +-
>  net/bluetooth/mgmt.c        |    2 +-
>  net/bluetooth/rfcomm/core.c |   18 +++---
>  net/bluetooth/rfcomm/tty.c  |    4 +-
>  net/bluetooth/sco.c         |    9 +--
>  10 files changed, 104 insertions(+), 126 deletions(-)

all 6 patches have been applied to bluetooth-next tree.

However we need to watch out for some of these include removal since in
some cases there are still needed on non-x86 platforms.

Regards

Marcel


