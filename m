Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v2] Bluetooth: btusb: Add Broadcom patch RAM support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140508225001.2A395100DB2@puck.mtv.corp.google.com>
Date: Thu, 8 May 2014 16:17:24 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3E1C911D-7198-4FFB-9E13-1D01662B4C9B@holtmann.org>
References: <20140508225001.2A395100DB2@puck.mtv.corp.google.com>
To: Petri Gynther <pgynther@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

> After hardware reset, some BCM Bluetooth adapters obtain their initial firmware
> from OTPROM chip. Once this initial firmware is running, the firmware can be
> further upgraded over HCI interface with .hcd files provided by Broadcom. This
> is also known as "patch RAM" support. This change implements that.
> 
> If the .hcd file is not found in /lib/firmware, BCM Bluetooth adapter continues
> to operate with the initial firmware. Sample kernel log:
>  hotplug: sys=firmware act=add fw=brcm/BCM20702A0-0a5c-22be.hcd dev=...
>  Bluetooth: hci0: BCM: patch brcm/BCM20702A0-0a5c-22be.hcd not found
> 
> If the .hcd file is found, btusb driver pushes it to the BCM Bluetooth adapter and
> it starts using the new firmware. Sample kernel log:
>  hotplug: sys=firmware act=add fw=brcm/BCM20702A0-0a5c-22be.hcd dev=...
>  Bluetooth: hci0: BCM: patching hci_ver=06 hci_rev=1000 lmp_ver=06 lmp_subver=220e
>  Bluetooth: hci0: BCM: firmware hci_ver=06 hci_rev=1389 lmp_ver=06 lmp_subver=220e
> 
> Above, we can see that hci_rev goes from 1000 to 1389 as a result of the upgrade.

so I tested this with an off the shelf USB dongle now and a firmware converted with the hex2hcd utility (which we most likely should just include in bluez.git).

[193812.000971] Bluetooth: hci0: BCM: patching hci_ver=06 hci_rev=1000 lmp_ver=06 lmp_subver=220e
[193812.738603] Bluetooth: hci0: BCM: firmware hci_ver=06 hci_rev=153a lmp_ver=06 lmp_subver=220e

Of course I have no idea what kind of bugs this new firmware now fixes. I am also almost certain that just based on the lmp_subver and hci_rev we could pick a firmware to load. And it would be nice if Broadcom starts putting firmware files in linux-firmware.git like any other company.

Anyhow, one minor thing that bugs me is this:

[193452.790194] Bluetooth: hci0: BCM: patch brcm/BCM20702A0-0a5c-21e8.hcd not found

While I want the firmware loading available for all Broadcom controllers, I do think we might have to mark some of them as firmware absolutely required since otherwise they will not work. And in that case we should print the error. Otherwise we might just silently not print anything. Thoughts?

> Signed-off-by: Petri Gynther <pgynther@google.com>
> ---
> drivers/bluetooth/btusb.c | 155 +++++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 154 insertions(+), 1 deletion(-)

Patch has been applied to bluetooth-next tree.

Regards

Marcel

