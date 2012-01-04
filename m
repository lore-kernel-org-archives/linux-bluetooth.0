Return-Path: <cyrus@holtmann.org>
Message-ID: <1325692012.6454.31.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Remove magic number from ACL TO
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 04 Jan 2012 07:46:52 -0800
In-Reply-To: <1325688146-19896-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1325688146-19896-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Adds HCI_ACL_TX_TIMEOUT and clear conversion from msec to jiffies
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci.h |    1 +
>  net/bluetooth/hci_core.c    |    3 ++-
>  2 files changed, 3 insertions(+), 1 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


