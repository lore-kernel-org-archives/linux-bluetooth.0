Return-Path: <jt@bougret.hpl.hp.com>
Date: Fri, 13 Aug 2004 11:07:48 -0700
To: Carl Orsborn <cjo@csr.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ mailing list <bluez-devel@lists.sourceforge.net>,
   Steven Singer <steven.singer@csr.com>
Subject: Re: [Bluez-devel] CSR firmware question...
Message-ID: <20040813180748.GB23661@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040813002514.GA21388@bougret.hpl.hp.com> <411C9CC0.90507@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <411C9CC0.90507@csr.com>
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, Aug 13, 2004 at 11:49:36AM +0100, Carl Orsborn wrote:
> Hi, Jean,
> 
> Can you reveal what you're doing with the CSR device when
> you suffer deadlock?  We may recognise the symptoms, and possibly
> know of a workaround or of fixed firmware.

	Trivial deadlock :
	initiating a connection to a device within 80ms of receiving
incomming connection from same device. Unknown if bug is in fw or
stack, but firmware deadlock.

	Intermitent failure :
	Initiating connection (page) within 20ms of bringing HCI
device up. Sometime it works, sometime it doesn't.

> Build 0x1bb is "HCI 15.3", released in August 2002.  Build 0x20e
> is "HCI 16.4", released in October 2002.  HCI 16.4 introduced
> basic scatternet support and fixed some issues in HCI 15.3.

	Thanks.

> HCI 16.14 (build 0x33d) was published to product manufacturers
> in April 2003.  This fixed a handful of issues in HCI 16.4.  You
> may be able to get hold of this, but I have no knowledge of
> what firmware D-Link have tested with their hardware and have
> subsequently (signed and?) published.

	None, as far as I can see. That's why I was looking at other
vendors.

> If your hardware is suitable (i.e., if it has an 8 Mbit flash
> device), you may be able to load HCI 18.1 or HCI 18.2; these
> support BT 1.2.
> 
> Carl

	Thanks for the info.

	Jean
