Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] hcid hotplug initialisation?
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076323641.6869.98.camel@pegasus>
References: <1076323204.5263.34.camel@kalkyl.roxen.com>
	 <1076323641.6869.98.camel@pegasus>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1076324203.5263.47.camel@kalkyl.roxen.com>
Mime-Version: 1.0
Date: Mon, 09 Feb 2004 11:56:43 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

mån 2004-02-09 klockan 11.47 skrev Marcel Holtmann:
> no. The bluetooth.agent is only for device specific configuration and
> not for starting a deamon. However hcid watches all interfaces and
> bluetooth.agent would be called for every device. 

Having hcid actively running on a system that never will use a 
Bluetooth device is waste of resources. But when a user inserts 
a Bluetooth device, it would be excellent to have it all work
automtically. What do you suggest then?

> Multiple running hcid's will mess up the security manager.

Yes, but only one hcid instance would run. The hotplug script and/or
hcid can check this.

Fredrik
