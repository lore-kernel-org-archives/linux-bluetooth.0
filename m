Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 May 2013 14:03:46 +0100
From: Ian Lynagh <igloo@earth.li>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Problems with a Plantronics BT300
Message-ID: <20130530130346.GA14111@matrix.chaos.earth.li>
References: <20130527152151.GA465@matrix.chaos.earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130527152151.GA465@matrix.chaos.earth.li>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, May 27, 2013 at 04:21:51PM +0100, Ian Lynagh wrote:
> 
> $ time sudo /lib/udev/hid2hci --devpath=devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.6/2-1.6:1.4/input/input11 --method=csr
> 
> which takes 10 seconds and adds this line to dmesg:
> 
> [587720.123420] usb 2-1.6: usbfs: USBDEVFS_CONTROL failed cmd hid2hci rqt 64 rq 0 len 0 ret -110
> 
> Am I doing something wrong? Or is my dongle just not supported?

If it's not supported, does anyone have any recommendations for a USB
dongle that works well with Linux please? (ideally without needing
non-free firmware).


Thanks
Ian

