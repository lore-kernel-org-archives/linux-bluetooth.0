Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC] DUT mode support for kernel
From: Marcel Holtmann <marcel@holtmann.org>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <48DA1762.7050206@nokia.com>
References: <48DA1762.7050206@nokia.com>
Content-Type: text/plain
Date: Wed, 24 Sep 2008 20:42:37 +0200
Message-Id: <1222281757.6481.0.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

> In good old days the only action needed to enable DUT mode was "hcitool 
> cmd 0x06 0x0003" or similar. However now after having full connection 
> tracking also for incoming connection this doesn't work anymore.
> 
> At least R&S tester does only ACL link to the device and therefore BlueZ 
> disconnects it after 10 secs. Connection tracking needs to be disabled 
> somehow. I prepared one proposal how to deal with it. The disable DUT 
> mode command is missing because the Spec says the DUT mode is disabled 
> by resetting the chip. Thus it can be done with "hciconfig hci0 reset" 
> command.
> 
> With this patch against bluetooth-2.6 tree the DUT mode is enabled by 
> echoing "enabled\n" to new sysfs entry. Maybe some other interface 
> should be used instead?

just remove the whole sysfs crap around it. Listen to the command status
from the DUT change and then still use hcitool cmd for entering it.

Regards

Marcel


