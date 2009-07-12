Return-Path: <cyrus@holtmann.org>
Subject: RE: bluetoothd not starting at boot with udev
From: Bastien Nocera <hadess@hadess.net>
To: Mario_Limonciello@Dell.com
Cc: marcel@holtmann.org, artem@makhutov.org, linux-bluetooth@vger.kernel.org
In-Reply-To: <6BE8CE7840AC9F459EF5A0693CA2744D6BAFB1@ausx3mpc138.aus.amer.dell.com>
References: <20090711161051.GM10684@titan.makhutov-it.de>
	 <1247337640.9709.96.camel@localhost.localdomain>
	 <6BE8CE7840AC9F459EF5A0693CA2744D6BAFB1@ausx3mpc138.aus.amer.dell.com>
Content-Type: text/plain
Date: Sun, 12 Jul 2009 18:10:47 +0100
Message-Id: <1247418647.5460.3.camel@snoogens.fab.redhat.com>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 2009-07-11 at 18:26 -0500, Mario_Limonciello@Dell.com wrote:
> Hi Marcel:
> 
> > which distro? Which version of udev? Which kernel?
> Seeing this same behavior on Ubuntu 9.10 too.  Kernel 2.6.31-rc2. Udev
> 143.

Your udev scripts are missing a call to "udevadm trigger --retry-failed"

Cheers
