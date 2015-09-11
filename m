Return-Path: <cyrus@holtmann.org>
From: Freek de Kruijf <f.de.kruijf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: hcidump does not show all traffic
Date: Fri, 11 Sep 2015 15:41:02 +0200
Message-ID: <3717569.7lEr2NYy4T@eik132.beelaertsict.nl>
In-Reply-To: <9EAE4CF9-7F4F-4DD8-A983-B9393DFFD339@holtmann.org>
References: <16191327.qpDB01f2sL@eik132.beelaertsict.nl> <9EAE4CF9-7F4F-4DD8-A983-B9393DFFD339@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Op vrijdag 28 augustus 2015 12:05:29 schreef Marcel Holtmann:
> Hi Freek,
> 
> > I am trying to monitor the traffic between my linux system and an external
> > bluetooth system using the command "hcidump -i hci0 -w filename". I only
> > catch some traffic from the host to the external device, but nothing from
> > the device to the host. I analyze the file using wireshark.
> 
> you need a newer Wireshark version. I remember it had some issues with
> correctly decoding the base packet types. Double check with btmon or
> hcidump that all traffic is actually in the file.

I finally found the cause. The bluetooth communication was between an 
application of a normal user and the device. I used hcidump from the same 
user. Now that I use hcidump as root I get all the traffic. Silly mistake.

I would propose to put some text in the man page of hcidump about using the 
command only as root. Maybe it should be installed in sbin instead of bin.

-- 
fr.gr.

Freek de Kruijf

