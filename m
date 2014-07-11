Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CA+eFSM3LusFHD0+UT_NRX_Zepw-Tuc+sJ1M3f6Aujrzqf4-_MA@mail.gmail.com>
References: <CA+eFSM3LusFHD0+UT_NRX_Zepw-Tuc+sJ1M3f6Aujrzqf4-_MA@mail.gmail.com>
Date: Sat, 12 Jul 2014 06:51:16 +0800
Message-ID: <CA+eFSM10Fu8hKgJXOz1dqzcazdWq_GSmBF-PbWK7Aq3J4wKeug@mail.gmail.com>
Subject: Re: Bluetooth device AR3012 [0cf3:e005] sometimes can't work on XHCI
 host controller
From: Gavin Guo <gavin.guo@canonical.com>
To: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org,
	"Nyman, Mathias" <mathias.nyman@intel.com>,
	dan.j.williams@intel.com
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Anthony Wong <anthony.wong@canonical.com>,
	YK <yk@canonical.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

On Mon, Jun 30, 2014 at 10:38 AM, Gavin Guo <gavin.guo@canonical.com> wrote:
> Hi all,
>
> Recently, I found that the AR3012 bluetooth sometimes can't work with the
> 00:14.0 USB controller [0c03]: Intel Corporation Lynx Point USB xHCI
> Host Controller [8086:8c31] (rev 05).
>
> The dmesg is attached, and following is how I tested:
>
> The port which AR3012 uses on the platform is default routed to XHCI
> controller. So, when booting up the machine, I found those messages in
> dmesg:
>
> [   18.128566] Bluetooth: Error in firmware loading err = -110,len =
> 448, size = 4096
> [   18.128574] Bluetooth: Loading patch file failed
> [   18.128583] ath3k: probe of 3-6:1.0 failed with error -110
>
> Obviously, there is firmware loading error with the XHCI host
> controller, and there are also XHCI debugging messages showing before
> these ones. Because we found that the AR3012 works fine with EHCI host
> controller, so we wrote a module, xhci_quirk, to change the port to
> bind to EHCI host controller, which changes the USB_INTEL_XUSB2PR
> register. After insmoding the xhci_quirk module, we see the following
> lines:
>
> [  199.248468] xhci_quirk: module verification failed: signature
> and/or  required key missing - tainting kernel
> [  199.255687] old = 0x3fff, new = 0x3cdf
> [  199.255689] Planted return probe at usb_enable_intel_xhci_ports:
> ffffffff815950c0
>
> After that the port disconnected from the XHCI host controller, and
> then the AR3012 is attached to the EHCI host controller:
>
> [  199.936571] usb 1-1.2: new full-speed USB device number 4 using ehci-pci
> [  215.026596] usb 1-1.2: device descriptor read/64, error -110
> [  230.220811] usb 1-1.2: device descriptor read/64, error -110
> [  230.396975] usb 1-1.2: new full-speed USB device number 5 using ehci-pci
> [  235.495101] usb 1-1.2: unable to read config index 0 descriptor/all
> [  235.495105] usb 1-1.2: can't read configurations, error -110
> [  235.571216] usb 1-1.2: new full-speed USB device number 6 using ehci-pci
> [  235.592617] usb 1-1.2: New USB device found, idVendor=0cf3, idProduct=e005
> [  235.592621] usb 1-1.2: New USB device strings: Mfr=0, Product=0,
> SerialNumber=0
> [  235.705440] usb 1-1.2: USB disconnect, device number 6
> [  235.903613] usb 1-1.2: new full-speed USB device number 7 using ehci-pci
> [  241.002841] usb 1-1.2: New USB device found, idVendor=0cf3, idProduct=e005
> [  241.002844] usb 1-1.2: New USB device strings: Mfr=0, Product=0,
> SerialNumber=0
>
> After a while, the Bluetooth icon shows up in the right-upper corner
> (Ubuntu 12.04). I can use normal Bluetooth operations such as file
> transfer, headset, and mouse.
>
> Next, I did an experiment to remove the xhci_quirk module and the port
> will be routed to the XHCI host controller again. And something
> strange happened, I found that the Bluetooth device AR3012 _WORKS_ on
> XHCI host controller.
>
> Summary:
> * The ath3k.c firwmare loading error doesn't always happen on the XHCI
> host controller, it succeed sometimes. After the successful loading
> firmware, AR3012 works fine.
>
> * After sucessful loading the firmware through the EHCI controller, I
> found that the firmware status still remained and can work with XHCI
> host controller through dynamic changing the port routing.
>
> If there is any restriction that Bluetooth device AR3012 can't work on
> XHCI host controller?
>
> Thanks,
> Gavin Guo

Add Mathias and Dan to the list, Mathias is now the XHCI driver maintainer.
