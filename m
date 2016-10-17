Return-Path: <szymon.janc@codecoup.pl>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: wujiangbo <jiangbo.wu@intel.com>
Cc: Johan Hedberg <johan.hedberg@intel.com>, marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add conn type to identify addr type with SMP over BR/EDR
Date: Mon, 17 Oct 2016 23:05:33 +0200
Message-ID: <1880358.RakREcZFtR@ix>
In-Reply-To: <20161014164313.GA16931@wujiangbo-ubuntu>
References: <1476448183-8630-1-git-send-email-jiangbo.wu@intel.com> <20161014141938.GA16585@x1c.P-661HNU-F1> <20161014164313.GA16931@wujiangbo-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Saturday, 15 October 2016 00:43:13 CEST wujiangbo wrote:
> On Fri, Oct 14, 2016 at 05:19:38PM +0300, Johan Hedberg wrote:
> > Hi Jiangbo,
> > 
> > Please don't top-post on this list.
> > 
> > On Fri, Oct 14, 2016, Wu, Jiangbo wrote:
> > > If pair a device that unpair firstly that remove encryption key,
> > > encryption key event will be emitted. kernel will receive
> > > 'L2CAP_CID_SMP_BREDR' frame, and then it will use SMP to distribute
> > > key.  SMP would like to use LTK, IRK and CRSK to notify user. If it
> > > don't identify device by which conn type they are, only marks LE as
> > > the device type,
> > 
> > Why would that happen? Before SMP over BR/EDR happens pairing would have
> > happened over BR/EDR, so bluetoothd should know that BR/EDR is supported
> > as well (it would even be aware of an existing BR/EDR connection). Are
> > you perhaps trying to work around some bluetoothd bug with all this?
> 
> I use upstream bluez source code without change.
> 
> Yes, bluetoothd scan will find device type is BR/EDR or LE. As my case,
> device is BR/EDR. But if kernel report CRSK notify, bluetoothd will change
> the device type to LE. The code you can see:
> 	new_csrk_callback -> btd_adapter_get_device -> btd_adapter_find_device
> 		if (bdaddr_type == BDADDR_BREDR)
> 			device_set_bredr_support(device);
> 		else
> 			device_set_le_support(device, bdaddr_type);
> As Marcel mentioned before, LTK, IRK and CRSK are only valid for LE link.
> So the rootcause is why remote start to pair a BR/EDR device, the kernel
> will receive CRSK event.
> 
> This is the first pair, and it will pair success even if receive CRSK
> notify. And the second and the next all pair will be failed with remote
> device unpair and then pair again.
> 
> > > while Bluetoothd will use this 'addr' and 'addr type' to reply the
> > > comfirm to kernel.
> > 
> > What reply are you talking about? There's no user interaction involved
> > with SMP over BR/EDR - that would already have occurred when SSP over
> > BR/EDR happened.
> 
> Sorry to confuse the case, the pairing failed coming with next pair
> procedure. Because at the last pair with CRSK notify, device type will be
> changed to LE, following is the failed scenario after last success with
> CRSK notify. Remote unpair and pair again.
> 
> This reply is SPP, user confirm passkey reply. When pairing proceduce, User
> confirm the pairing request through bluetoothd, that will send mgmt op
> 'MGMT_OP_USER_CONFIRM_REPLY' with device address and device type in
> mgmt_cp_user_confirm_reply. Kernel use the device address and type to lookup
> hci conn. Unfortunately, it will lookup hci_conn from LE hashtable, that
> don't include hci conn. So spp reply couldn't send to remote, caused pair
> failed.
> > > At the same time kernel always uses them to lookup hci_conn in LE
> > > hashtable firstly, because addr type always marks as LE. Obviously it
> > > will failed with SMP over BR/EDR.
> > 
> > I don't follow this either since there shouldn't have been any "reply"
> > from user space for SMP over BR/EDR. All there should be are events from
> > the kernel for the generated LE keys.
> > 
> > > Actually, SPM is only for LE in SPEC,
> > 
> > That's not true. SMP is specified both for LE-U and ACL-U.
> > 
> > > but kernel already support and use SMP over BR/EDR. if BR/EDR
> > > exchanges key with SMP, it will never reply pairing response to
> > > remote, in other words it will be never paired, that is happened in
> > > our products.
> > 
> > Szymon recently implemented SMP over BR/EDR for Zephyr and used
> > Linux/BlueZ as a reference for testing. He didn't report any issues like
> > this. It might help if you could provide some logs (particularly
> > HCI/btmon but also from bluetoothd) to understand what's the actual
> > issue you're seeing.
> > 
> > Johan
> 
> Sorry to confuse this issue, the log is not in my hand right now,
> so it maybe later.

So I was able to reproduce this issue. This is bluetoothd bug and not kernel 
one. This bug is no specific to cross-transport pairing. It can happen with 
any dual-mode device that is doing BR/EDR pairing while being known as dual 
mode by bluetoothd when agent replies with passkey or confirmation.

To fix this we probably need to hold extra information in
'struct authentication_req' in device.c about type of pairing (LE or BR/EDR). 
This is not a one-liner-fix so I don't have a patch ready yet.

-- 
pozdrawiam
Szymon Janc
