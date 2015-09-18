Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: BlueZ - LGPL dependency with GPL headers and sources
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <E43CE124327DEB448881DE4DD408A8A323E808BAD1@AUSX7MCPS308.AMER.DELL.COM>
Date: Fri, 18 Sep 2015 06:27:47 +0200
Cc: linux-bluetooth@vger.kernel.org, Arulnambi_Raju@Dell.com
Message-Id: <6E7C05F9-DAAE-4AC1-B735-BB7B2E8D333B@holtmann.org>
References: <E43CE124327DEB448881DE4DD408A8A323E808BAD1@AUSX7MCPS308.AMER.DELL.COM>
To: Trey_Ramsay@Dell.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Trey,

> We are making a BLE only product for embedded system and cannot use the whole bluez package due to lack of resources.  We noticed that the BLE specific code (src/shared) is licensed under LGPL and we are trying to leverage the code as a shared library for our proprietary source BLE application, similar to btgatt-server tool. While compiling, we noticed the LPGL code has a dependency with the following header and source files which are licensed as GPL.
> 
> lib/bluetooth.h
> lib/hci.h
> lib/mgmt..h
> lib/uuid.c
> lib/uuid.h
> src/shared/ad.c
> src/shared/ad.h
> 
> Are there plans to make the above files LGPL or LGPL compatible?

the src/shared/ad.[ch] is actually a mistake. No code under GPL should have been accepted into src/shared/ directory. That code is intentionally kept LGPL only.

> Are there any plans in the future to remove the GPL dependencies from the LGPL code?

The lib/uuid.[ch] is pretty old code and not really nicely abstracted in the first place. However it has been used to speed up the development of the GATT support. The plan is actually to replace that with a new implementation src/shared/uuid.[ch] under LGPL that nicely integrates.

The other three are just a bunch of defines or structs. However they are kernel defines and structs and should be most likely come directly from the kernel as UAPI. However we have never gotten around it to clean these up. Some of this is part of the old libbluetooth (which is still internally required). We are talking about 13 year old code here.

Regards

Marcel

