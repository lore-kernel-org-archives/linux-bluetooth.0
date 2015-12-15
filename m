Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [Bug 109321] New: ASUS T100TA Bluetooth stopped working
To: linux-bluetooth@vger.kernel.org
References: <bug-109321-62941@https.bugzilla.kernel.org/>
Cc: bugzilla-daemon@bugzilla.kernel.org
From: Frederic Danis <frederic.danis@linux.intel.com>
Message-ID: <567041AE.5060001@linux.intel.com>
Date: Tue, 15 Dec 2015 17:37:02 +0100
MIME-Version: 1.0
In-Reply-To: <bug-109321-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

On 14/12/2015 02:36, bugzilla-daemon@bugzilla.kernel.org wrote:
> Hello
>
> since kernel 4.2.3 the bluetooth on ASUS t100TA stopped working
>
> can no longer initialize it using hciattach /dev/ttyS4 bcm43xx command it
> always times out it also registers different in dmesg
>
>   80860F0A:00: ttyS4 at MMIO 0x9094d000 (irq = 191, base_baud = 2764800) is a
> 16550A
> [    5.629222] Bluetooth: Core ver 2.21
> [    5.629287] NET: Registered protocol family 31
> [    5.629291] Bluetooth: HCI device and connection manager initialized
> [    5.629299] Bluetooth: HCI socket layer initialized
> [    5.629305] Bluetooth: L2CAP socket layer initialized
> [    5.629318] Bluetooth: SCO socket layer initialized
> [    5.643749] Bluetooth: HCI UART driver ver 2.3
> [    5.643757] Bluetooth: HCI UART protocol H4 registered
> [    5.643760] Bluetooth: HCI UART protocol BCSP registered
> [    5.643763] Bluetooth: HCI UART protocol LL registered
> [    5.643765] Bluetooth: HCI UART protocol ATH3K registered
> [    5.643768] Bluetooth: HCI UART protocol Three-wire (H5) registered
> [    5.643853] Bluetooth: HCI UART protocol Intel registered
> [    5.657970] hci_bcm BCM2E39:00: BCM irq: 192
> [    5.658046] Bluetooth: BCM2E39:00: Asus T100TA: Overwriting IRQ polarity to
> active low
> [    5.658051] hci_bcm BCM2E39:00: BCM2E39:00 device registered.
> [    5.658224] Bluetooth: HCI UART protocol BCM registered
>
> not sure if this is a bug in the kernel driver or if something was changed
> BlueZ and not updated in the bcm driver
>
> also it no longer registers with rfkill which i think was changed

Bluetooth BCM chipset is no more managed by rfkill and hciattach.
You should use btattach to register it (BlueZ >= 5.31):
	btattach --bredr /dev/ttyS4 -P bcm
then (you should change the device address):
	btmgmt public-addr "43:24:b3:01:02:03"

Hope this helps

