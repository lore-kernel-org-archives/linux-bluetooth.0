Return-Path: <jt@bougret.hpl.hp.com>
Date: Fri, 13 Aug 2004 09:37:36 -0700
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Steven Singer <steven.singer@csr.com>
Subject: Re: CSR firmware question...
Message-ID: <20040813163736.GC22763@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040813002514.GA21388@bougret.hpl.hp.com> <1092385877.28711.185.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1092385877.28711.185.camel@pegasus>
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, Aug 13, 2004 at 10:31:17AM +0200, Marcel Holtmann wrote:
> Hi Jean,
> 
> > 	A few questions regarding CSR firmware : what's a commonly
> > available BT USB dongle with a recent CSR firmware.
> 
> as I know there are only dongles with HCI 16.14 firmware available.

	And...

> > 	I'm hitting various bugs with the CSR firmware in my D-Link
> > USB dongles (0x1bb), where I can easilly deadlock the dongle. My 3Com
> > dongle, which has a more recent firmware (0x20e), behave much better,
> > but not perfect.
> > 	D-Link doesn't provide a firmware updater, but, beeing
> > fearless, I tried to firmware upgrade a D-Link dongle and ended up
> > with a dead dongle (can't even put back the original firmware on it).
> > 	From the release notes, the latest CSR firmwares have zillions
> > of bug fixes. I really wonder how I can enjoy the bug fixes.
> 
> The D-Link dongle DBT-120 (Rev B3) can be updated using the Apple
> firmware update file. After that it will be HCI 18.1 with default boot
> mode set to HID.

	This is exactly what I did. I have a rev B3, and I used Apple
file.
	What do you mean default boot set to HID ? I look similar to
what I'm seeing.

> Maybe other revisions of the D-Link dongle don't work
> and I already put some of dongles to death while playing with firmware
> upgrade.

	Yep, seems easy.

> > P.S. : Marcel, do you have a version of btdfu that can write the
> > firmware image to the dongle ? Or some documentation ?
> 
> I never announced the new version of the btdfu, but now as you asked for
> it, here it is:
> 
> 	http://www.holtmann.org/linux/bluetooth/btdfu-0.3.tar.gz
> 
> Use it at your own risk, because you can kill your dongle !!!

	Actually, I realised that I can't even use that, the dongle no
longer has a control pipe. Grrr....

> Read what the CSR guys had written about signed firmware and that it is
> not possible to move firmware from one manufacturer to another !!!

	Yep, I read that, I won't comment to stay polite.

> Regards
> 
> Marcel

	Jean
