Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: hcidump does not show all traffic
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <16191327.qpDB01f2sL@eik132.beelaertsict.nl>
Date: Fri, 28 Aug 2015 12:05:29 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9EAE4CF9-7F4F-4DD8-A983-B9393DFFD339@holtmann.org>
References: <16191327.qpDB01f2sL@eik132.beelaertsict.nl>
To: Freek de Kruijf <f.de.kruijf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Freek,

> I am trying to monitor the traffic between my linux system and an external 
> bluetooth system using the command "hcidump -i hci0 -w filename". I only catch 
> some traffic from the host to the external device, but nothing from the device 
> to the host. I analyze the file using wireshark.

you need a newer Wireshark version. I remember it had some issues with correctly decoding the base packet types. Double check with btmon or hcidump that all traffic is actually in the file.

Regards

Marcel

