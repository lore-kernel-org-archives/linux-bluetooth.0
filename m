Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Define HCI reasons instead of magic number
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 08 Nov 2011 08:46:34 +0900
In-Reply-To: <1320668425-11251-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1320668425-11251-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1320709598.15441.305.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Use HCI error reasons instead of magic numbers.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci.h      |    7 +++++++
>  include/net/bluetooth/hci_core.h |    2 +-
>  net/bluetooth/hci_conn.c         |    2 +-
>  net/bluetooth/hci_event.c        |    4 ++--
>  net/bluetooth/l2cap_core.c       |    8 ++++----
>  5 files changed, 15 insertions(+), 8 deletions(-)

looks good to me.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


