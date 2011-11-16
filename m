Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 1/3] Bluetooth: Use queue in the device list
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 17 Nov 2011 06:48:00 +0900
In-Reply-To: <1321457422-31641-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1321457422-31641-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321480083.15441.552.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Use queue instead of stack discipline for device list. When processing
> dev_list with list_for_each* devices will be prosessed in order they
> were added (Usually BR/EDR first and AMP later).
> 
> Also output from hciconfig looks nicer :-)
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

not that this matters much, but I am fine with it.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


