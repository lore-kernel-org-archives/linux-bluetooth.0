Return-Path: <cyrus@holtmann.org>
Subject: Re: bluetooth: module_refcount is not decreased when connection
 times out
From: Marcel Holtmann <marcel@holtmann.org>
To: Bing Zhao <bzhao@marvell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <477F20668A386D41ADCC57781B1F704301E62956E5@SC-VEXCH1.marvell.com>
References: <477F20668A386D41ADCC57781B1F704301E62956E5@SC-VEXCH1.marvell.com>
Content-Type: text/plain
Date: Fri, 08 May 2009 16:20:19 -0700
Message-Id: <1241824819.4903.70.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> The module refcount is increased by hci_dev_hold() call in hci_conn_add() in hci_conn.c, and it is decreased by hci_dev_put() call in "del_conn" (hci_sysfs.c).
> 
> In case connection timeout happens, hci_dev_put() is never called.
> 
> Procedure to reproduce the issue:
> 
> # hciconfig hci0 up
> # lsmod | grep btusb				-> "used by" refcount = 1
> 
> # hcitool cc <non-exisiting bdaddr>		-> will get timeout
> 
> # lsmod | grep btusb				-> "used by" refcount = 2
> # hciconfig hci0 down
> # lsmod | grep btusb				-> "used by" refcount = 1
> # rmmod btusb					-> ERROR: Module btusb is in use

I have seen that happen before, but never had the time to check up on
them. Your analysis seems correct. Would have to check on how to fix
this. Proposals are welcome.

Regards

Marcel


