Return-Path: <cyrus@holtmann.org>
Subject: Re: [bluetooth-next V2] Bluetooth: handle device reset event
From: Marcel Holtmann <marcel@holtmann.org>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: linux-bluetooth@vger.kernel.org, guy.cohen@intel.com,
	ron.rindjunsky@intel.com, Gregory Paskar <gregory.paskar@intel.com>
In-Reply-To: <1266843933-28802-1-git-send-email-tomas.winkler@intel.com>
References: <1266843933-28802-1-git-send-email-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 08 Mar 2010 17:03:07 -0800
Message-ID: <1268096587.3712.36.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tomas,

> A Bluetooth device experiencing hardware failure may issue
> a HARDWARE_ERROR hci event. The reaction to this event is device
> reset flow implemented in following sequence.
> 
> 1. Notify: HCI_DEV_DOWN
> 2. Reinitialize internal structures.
> 3. Call driver flush function
> 4. Send HCI reset request to the device.
> 5. Send HCI init sequence reset to the device.
> 6. Notify HCI_DEV_UP.

I prefer if we create a generic per controller workqueue first before
having a workqueue for every task. Something similar to what the
mac80211 layer offers right now.

Also in a second step we might wanna move the HCI event processing
completely into a workqueue. If we get no performance hit with that,
then sysfs handling and device reset becomes a lot simpler and less
prone to race conditions with device removal.

Regards

Marcel


