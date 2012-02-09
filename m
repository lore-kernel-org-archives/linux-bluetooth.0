Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Feb 2012 23:24:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	marcel@holtmann.org
Subject: Re: [RESEND PATCH 1/4] Bluetooth: Introduce to_hci_dev()
Message-ID: <20120209212437.GA453@x220.P-661HNU-F1>
References: <1328821115-12514-1-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328821115-12514-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Thu, Feb 09, 2012, David Herrmann wrote:
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
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
> Acked in: Message-ID: <1327960525.1955.178.camel@aeonflux>
> 
>  include/net/bluetooth/hci_core.h |    2 ++
>  net/bluetooth/hci_sysfs.c        |   33 ++++++++++++++++-----------------
>  2 files changed, 18 insertions(+), 17 deletions(-)

Sorry about missing these initially. Last week had plenty of
distractions to offer thanks to the UPF. Anyway, all four patches have
been applied to my bluetooth-next tree now.

Johan
