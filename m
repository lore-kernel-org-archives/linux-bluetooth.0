Return-Path: <Carl.Orsborn@csr.com>
Message-ID: <411C9CC0.90507@csr.com>
Date: Fri, 13 Aug 2004 11:49:36 +0100
From: Carl Orsborn <cjo@csr.com>
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ mailing list
    <bluez-devel@lists.sourceforge.net>,
   Steven Singer
    <steven.singer@csr.com>
Subject: Re: [Bluez-devel] CSR firmware question...
References: <20040813002514.GA21388@bougret.hpl.hp.com>
In-Reply-To: <20040813002514.GA21388@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hi, Jean,

Can you reveal what you're doing with the CSR device when
you suffer deadlock?  We may recognise the symptoms, and possibly
know of a workaround or of fixed firmware.

Build 0x1bb is "HCI 15.3", released in August 2002.  Build 0x20e
is "HCI 16.4", released in October 2002.  HCI 16.4 introduced
basic scatternet support and fixed some issues in HCI 15.3.

HCI 16.14 (build 0x33d) was published to product manufacturers
in April 2003.  This fixed a handful of issues in HCI 16.4.  You
may be able to get hold of this, but I have no knowledge of
what firmware D-Link have tested with their hardware and have
subsequently (signed and?) published.

If your hardware is suitable (i.e., if it has an 8 Mbit flash
device), you may be able to load HCI 18.1 or HCI 18.2; these
support BT 1.2.

Carl


Jean Tourrilhes wrote:

> 	Hi guys,
> 
> 	A few questions regarding CSR firmware : what's a commonly
> available BT USB dongle with a recent CSR firmware.
> 
> 	Long story :
> 	I'm hitting various bugs with the CSR firmware in my D-Link
> USB dongles (0x1bb), where I can easilly deadlock the dongle. My 3Com
> dongle, which has a more recent firmware (0x20e), behave much better,
> but not perfect.
> 	D-Link doesn't provide a firmware updater, but, beeing
> fearless, I tried to firmware upgrade a D-Link dongle and ended up
> with a dead dongle (can't even put back the original firmware on it).
> 	From the release notes, the latest CSR firmwares have zillions
> of bug fixes. I really wonder how I can enjoy the bug fixes.
> 
> 	Thanks in advance...
> 
> 	Jean
> 
> P.S. : Marcel, do you have a version of btdfu that can write the
> firmware image to the dongle ? Or some documentation ?




**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************
