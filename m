Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: Problems with incoming connection request on Nexus 4
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <D1E69F17.AEFC%adam.moore@savant.com>
Date: Tue, 4 Aug 2015 18:32:44 -0700
Cc: Florian Grandel <fgrandel@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <A15F98E4-F405-4C97-BC68-F6FA51ABAC48@holtmann.org>
References: <55B83614.8090702@gmail.com> <BC4DBE9E-8369-4B20-BBE5-F175DD4C5626@holtmann.org> <55BA16BA.5060302@gmail.com> <F5B83C8F-6BD0-49C8-96C9-F13DF68CEECE@holtmann.org> <55BA2290.8090308@gmail.com> <2C03C1D8-0784-4DA4-93AF-FC8A1C874681@holtmann.org> <CAN_7+YaBFZqhCUF1m_5nNnCbn9inJmKJ6tXVmJ=Ks09A4_6utA@mail.gmail.com> <D1E1442B.ADA2%adam.moore@savant.com> <55BD1603.9020301@gmail.com> <D1E69F17.AEFC%adam.moore@savant.com>
To: Adam Moore <adam.moore@savantsystems.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Adam,

please refrain from top posting on this mailing list.

> For some reason, my 5.28 devices were defaulting to LE mode even though I
> didn't have a main.conf.  Being happy with this, I didn't ask questions
> and likely incorrectly assumed it was because of what I was setting the
> correct bits in the advertising data.
> 
> After updating to 5.32, my devices are defaulting to dual mode, according
> to 'btmgmt info'.
> 
> After creating a main.conf and setting ControllerMode = le, my 5.32
> devices are now seen as LE only.  This was probably the cause of my issue.
> Would like to know how I was able to get away without a main.conf before
> though.

by default dual-mode controllers should have always set up as BR/EDR and LE enabled. Only after we introduced the ControllerMode main.conf option it was possible to create a LE only mode when running bluetoothd.

The kernel has supported LE only since a long time, but until lately it was manual setup via btmgmt and we only ever used it for testing purposes.

Regards

Marcel

