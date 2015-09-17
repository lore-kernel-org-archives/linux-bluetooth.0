Return-Path: <cyrus@holtmann.org>
From: <Trey_Ramsay@Dell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <Arulnambi_Raju@Dell.com>
Date: Thu, 17 Sep 2015 12:52:25 -0500
Subject: BlueZ - LGPL dependency with GPL headers and sources
Message-ID: <E43CE124327DEB448881DE4DD408A8A323E808BAD1@AUSX7MCPS308.AMER.DELL.COM>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We are making a BLE only product for embedded system and cannot use the whole bluez package due to lack of resources.  We noticed that the BLE specific code (src/shared) is licensed under LGPL and we are trying to leverage the code as a shared library for our proprietary source BLE application, similar to btgatt-server tool. While compiling, we noticed the LPGL code has a dependency with the following header and source files which are licensed as GPL.

lib/bluetooth.h
lib/hci.h
lib/mgmt..h
lib/uuid.c
lib/uuid.h
src/shared/ad.c
src/shared/ad.h

Are there plans to make the above files LGPL or LGPL compatible?

Are there any plans in the future to remove the GPL dependencies from the LGPL code?

Thanks,
Trey
