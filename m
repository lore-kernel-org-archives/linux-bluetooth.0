Return-Path: <cyrus@holtmann.org>
Message-ID: <1325180937.1965.294.camel@aeonflux>
Subject: Re: [PATCH 1/5] Bluetooth: Remove obsolete hci-destruct callback
From: Marcel Holtmann <marcel@holtmann.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Date: Thu, 29 Dec 2011 09:48:57 -0800
In-Reply-To: <1325173242-12264-2-git-send-email-dh.herrmann@googlemail.com>
References: <1325173242-12264-1-git-send-email-dh.herrmann@googlemail.com>
	 <1325173242-12264-2-git-send-email-dh.herrmann@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> The destruct-callback is used by *all* drivers to remove their platform
> data only. However, all drivers call hci_unregister_dev() before this
> callback is executed. Therefore, there is no reason to keep platform
> data alive after the driver was unregistered. Hence, we can free platform data
> directly and then remove the hci-destruct callback entirely.
> 
> Some drivers already depend on this behaviour, since they erroneously
> already free the data after calling hci_free_dev(). This patch makes all
> drivers behave that way and removes the callback entirely.

it is important to not end up with a race condition between sysfs and
hci_dev here. For example a cat /sys/class/bluetooth/hci0/name could
still have sysfs file open and we need to keep the memory around until
it gets destructed.

Regards

Marcel


