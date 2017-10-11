Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Subject: Re: [PATCH 2/2] Bluetooth: BT_HCIUART now depends on SERIAL_DEV_BUS
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <ff49535c-61e1-f6da-8b2c-490dc55d5982@redhat.com>
Date: Wed, 11 Oct 2017 20:10:54 +0200
Cc: Arnd Bergmann <arnd@arndb.de>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Tobias Regnery <tobias.regnery@gmail.com>,
        "bluez mailin list (linux-bluetooth@vger.kernel.org)"
        <linux-bluetooth@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <C156D266-F58A-4A4E-986E-17B003BE5A37@holtmann.org>
References: <20171011134640.3152236-1-arnd@arndb.de>
 <20171011134805.3207569-1-arnd@arndb.de>
 <ff49535c-61e1-f6da-8b2c-490dc55d5982@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

>> It is no longer possible to build BT_HCIUART into the kernel
>> when SERIAL_DEV_BUS is a loadable module, even if none of the
>> SERIAL_DEV_BUS based implementations are selected:
>> drivers/bluetooth/hci_ldisc.o: In function `hci_uart_set_flow_control':
>> hci_ldisc.c:(.text+0xb40): undefined reference to `serdev_device_set_flow_control'
>> hci_ldisc.c:(.text+0xb5c): undefined reference to `serdev_device_set_tiocm'
>> This adds a dependency to avoid the broken configuration.
>> Fixes: 7841d554809b ("Bluetooth: hci_uart_set_flow_control: Fix NULL deref when using serdev")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Another one I have on my TODO after the buildbot errors. In this case
> I do not believe this is the proper fix though.
> 
> As pointed out in another thread discussing the series introducing
> this problem, hci_ldisc.c really should not depend on serdev,
> so the proper fix would be to have hci_bcm.c directly call
> the serdev flowcontrol and rts functions when the hci is
> backed by a serdev device, like hci_bcm.c is already doing
> when setting the baudrate, see host_set_baudrate in hci_bcm.c,
> so a similar host_set_flow_control should be added after which
> the changes to hci_ldisc.c can be reverted.
> 
> If I understood Marcel correctly he prefers a single patch
> fixing this which also removes the changes from hci_ldisc.c,
> rather then a separate revert.

actually two patches is fine, but I want them as a patch series so they are applied in a row. I think best is first to revert the btusb.c changes and then apply the new ACPI PNP id.

Regards

Marcel
