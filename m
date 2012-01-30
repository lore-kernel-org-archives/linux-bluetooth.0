Return-Path: <cyrus@holtmann.org>
Message-ID: <1327960655.1955.179.camel@aeonflux>
Subject: Re: [PATCH 2/4 v2] Bluetooth: Remove hci_dev->driver_data
From: Marcel Holtmann <marcel@holtmann.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
	anderson.lizardo@openbossa.org
Date: Mon, 30 Jan 2012 13:57:35 -0800
In-Reply-To: <1327683670-3111-1-git-send-email-dh.herrmann@googlemail.com>
References: <CANq1E4TnqmTE31sA859FJPEuWRoW0mNy_Rb9zPpNhWc-=4mbjg@mail.gmail.com>
	 <1327683670-3111-1-git-send-email-dh.herrmann@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> The linux device model provides dev_set/get_drvdata so we can use this
> to save private driver data.
> This also removes several unnecessary casts.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
> v2: Fixed a bug spotted by Anderson Lizardo. I checked the variables in
> btmrvl_main.c in the wrong order.
> 
>  drivers/bluetooth/bfusb.c          |   10 +++++-----
>  drivers/bluetooth/bluecard_cs.c    |   12 ++++++------
>  drivers/bluetooth/bpa10x.c         |   18 +++++++++---------
>  drivers/bluetooth/bt3c_cs.c        |    6 +++---
>  drivers/bluetooth/btmrvl_debugfs.c |   26 ++++++++++++--------------
>  drivers/bluetooth/btmrvl_main.c    |   11 ++++++-----
>  drivers/bluetooth/btsdio.c         |   10 +++++-----
>  drivers/bluetooth/btuart_cs.c      |    6 +++---
>  drivers/bluetooth/btusb.c          |   28 ++++++++++++++--------------
>  drivers/bluetooth/btwilink.c       |    8 ++++----
>  drivers/bluetooth/dtl1_cs.c        |    6 +++---
>  drivers/bluetooth/hci_ldisc.c      |    6 +++---
>  drivers/bluetooth/hci_vhci.c       |    8 ++++----
>  include/net/bluetooth/hci_core.h   |   11 ++++++++++-
>  14 files changed, 87 insertions(+), 79 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


