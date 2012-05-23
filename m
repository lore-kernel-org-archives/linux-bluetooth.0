Return-Path: <cyrus@holtmann.org>
Message-ID: <1337771046.15105.73.camel@aeonflux>
Subject: Re: [PATCH trivial 1/4] Bluetooth: Use defined link key size
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 23 May 2012 13:04:06 +0200
In-Reply-To: <1337761883-3190-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1337761883-3190-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Remove magic number with defined link key size.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci.h      |    6 ++++--
>  include/net/bluetooth/hci_core.h |    2 +-
>  net/bluetooth/hci_core.c         |    2 +-
>  net/bluetooth/hci_event.c        |    2 +-
>  net/bluetooth/mgmt.c             |    2 +-
>  5 files changed, 8 insertions(+), 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


