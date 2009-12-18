Return-Path: <cyrus@holtmann.org>
Subject: Re: btusb regression on commands unsupported by adapter
From: Marcel Holtmann <marcel@holtmann.org>
To: Jeremy Jackson <jerj@coplanar.net>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1261158272.4932.184.camel@ragnarok>
References: <1261158272.4932.184.camel@ragnarok>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 18 Dec 2009 13:53:26 -0800
Message-Id: <1261173206.4041.89.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jeremy,

> I've posted more details here for userspace diagnosis/workaround,
> 
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/377225
> 
> Some (older?) BT adapters don't support the commands 'Read Default Link
> Policy Settings' 
> 	'Write Default Link Policy Settings'
> 
> as shown by # hciconfig hci0 commands
> 
> This appears be one cause of the infamous kernel message: hci0: command
> tx timeout.  This in turn causes bluetoothd to give up and take down the
> interface.
> 
> If you kill bluetoothd, and manually # hciconfig hci0 up, you can
> discover and inq devices no problem.
> 
> I made a patch to disable the offending command, and the above mentioned
> bug report I gave instructions to gather data on adapter BT version,
> supported features, and supported commands.  Hopefully some user reports
> can be used to make use of the command conditional on actual adapter
> support.
> 
> The question for kernel side is, regression, or corrected behaviour?

this is basically a bluetoothd issue. We should be reading the list of
supported commands and then either issue or not issue this command. Feel
free to write a patch for that.

Regards

Marcel


