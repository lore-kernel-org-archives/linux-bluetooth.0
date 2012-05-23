Return-Path: <cyrus@holtmann.org>
Message-ID: <1337770927.15105.72.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Rename HCI_QUIRK_NO_RESET to
 HCI_QUIRK_RESET_ON_CLOSE
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Date: Wed, 23 May 2012 13:02:07 +0200
In-Reply-To: <1337769346-16306-1-git-send-email-szymon.janc@tieto.com>
References: <1337769346-16306-1-git-send-email-szymon.janc@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> HCI_QUIRK_NO_RESET name is misleading - purpose of this quirk is to
> reset device on close instead of init, not to not reset at all.
> Rename it to HCI_QUIRK_RESET_ON_CLOSE to avoid confusion.
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  drivers/bluetooth/bpa10x.c    |    2 +-
>  drivers/bluetooth/btusb.c     |    6 +++---
>  drivers/bluetooth/hci_ldisc.c |    2 +-
>  include/net/bluetooth/hci.h   |    2 +-
>  net/bluetooth/hci_core.c      |    4 ++--
>  5 files changed, 8 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


