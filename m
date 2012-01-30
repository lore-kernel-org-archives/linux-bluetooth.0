Return-Path: <cyrus@holtmann.org>
Message-ID: <1327960525.1955.178.camel@aeonflux>
Subject: Re: [PATCH 1/4] Bluetooth: Introduce to_hci_dev()
From: Marcel Holtmann <marcel@holtmann.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Date: Mon, 30 Jan 2012 13:55:25 -0800
In-Reply-To: <1327679246-2667-2-git-send-email-dh.herrmann@googlemail.com>
References: <1327679246-2667-1-git-send-email-dh.herrmann@googlemail.com>
	 <1327679246-2667-2-git-send-email-dh.herrmann@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> We currently use dev_set_drvdata to keep a pointer to ourself. This
> doesn't make sense as we are the bus and not a driver. Therefore,
> introduce to_hci_dev() so we can get a struct hci_dev pointer from a
> struct device pointer.
> 
> dev_set/get_drvdata() is reserved for drivers that provide a device and
> not for the bus using the device. The bus can use simple pointer
> arithmetic to retrieve its private data.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
>  include/net/bluetooth/hci_core.h |    2 ++
>  net/bluetooth/hci_sysfs.c        |   33 ++++++++++++++++-----------------
>  2 files changed, 18 insertions(+), 17 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


