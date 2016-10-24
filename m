Return-Path: <jiangbo.wu@intel.com>
Date: Mon, 24 Oct 2016 15:30:34 +0800
From: "Wu,Jiangbo" <jiangbo.wu@intel.com>
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: Johan Hedberg <johan.hedberg@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>, martin.xu@intel.com,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add conn type to identify addr type with SMP
 over BR/EDR
Message-ID: <20161024073034.GA16791@wujiangbo-ubuntu>
References: <1476448183-8630-1-git-send-email-jiangbo.wu@intel.com>
 <1880358.RakREcZFtR@ix>
 <20161018102338.GB25770@wujiangbo-ubuntu>
 <1868573.jZNrvtjvi1@ix>
 <CAAEJBhKbpAMu5oYV3rLHPgeAiRdbPcaGGT8r4x-HwqkH_t3VVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAAEJBhKbpAMu5oYV3rLHPgeAiRdbPcaGGT8r4x-HwqkH_t3VVg@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Sat, Oct 22, 2016 at 11:17:21AM +0200, Szymon Janc wrote:
> Hi Jiangbo,
> 
> On 18 October 2016 at 22:32, Szymon Janc <szymon.janc@codecoup.pl> wrote:
> > Hi Jiangbo,
> >
> > On Tuesday, 18 October 2016 18:23:38 CEST Wu,Jiangbo wrote:
> >> Hi,
> >>
> >> On Mon, Oct 17, 2016 at 11:05:33PM +0200, Szymon Janc wrote:
> >> > Hi,
> >> >
> >> > On Saturday, 15 October 2016 00:43:13 CEST wujiangbo wrote:
> >> > > On Fri, Oct 14, 2016 at 05:19:38PM +0300, Johan Hedberg wrote:
> >> > > > Hi Jiangbo,
> >> > > >
> >> > > > Please don't top-post on this list.
> >> > > >
> >> > > > On Fri, Oct 14, 2016, Wu, Jiangbo wrote:
> >> > > > > If pair a device that unpair firstly that remove encryption key,
> >> > > > > encryption key event will be emitted. kernel will receive
> >> > > > > 'L2CAP_CID_SMP_BREDR' frame, and then it will use SMP to distribute
> >> > > > > key.  SMP would like to use LTK, IRK and CRSK to notify user. If it
> >> > > > > don't identify device by which conn type they are, only marks LE as
> >> > > > > the device type,
> >> > > >
> >> > > > Why would that happen? Before SMP over BR/EDR happens pairing would
> >> > > > have
> >> > > > happened over BR/EDR, so bluetoothd should know that BR/EDR is
> >> > > > supported
> >> > > > as well (it would even be aware of an existing BR/EDR connection). Are
> >> > > > you perhaps trying to work around some bluetoothd bug with all this?
> >> > >
> >> > > I use upstream bluez source code without change.
> >> > >
> >> > > Yes, bluetoothd scan will find device type is BR/EDR or LE. As my case,
> >> > > device is BR/EDR. But if kernel report CRSK notify, bluetoothd will
> >> > > change
> >> > >
> >> > > the device type to LE. The code you can see:
> >> > >   new_csrk_callback -> btd_adapter_get_device ->
> > btd_adapter_find_device
> >> > >
> >> > >           if (bdaddr_type == BDADDR_BREDR)
> >> > >
> >> > >                   device_set_bredr_support(device);
> >> > >
> >> > >           else
> >> > >
> >> > >                   device_set_le_support(device, bdaddr_type);
> >> > >
> >> > > As Marcel mentioned before, LTK, IRK and CRSK are only valid for LE
> >> > > link.
> >> > > So the rootcause is why remote start to pair a BR/EDR device, the kernel
> >> > > will receive CRSK event.
> >> > >
> >> > > This is the first pair, and it will pair success even if receive CRSK
> >> > > notify. And the second and the next all pair will be failed with remote
> >> > > device unpair and then pair again.
> >> > >
> >> > > > > while Bluetoothd will use this 'addr' and 'addr type' to reply the
> >> > > > > comfirm to kernel.
> >> > > >
> >> > > > What reply are you talking about? There's no user interaction involved
> >> > > > with SMP over BR/EDR - that would already have occurred when SSP over
> >> > > > BR/EDR happened.
> >> > >
> >> > > Sorry to confuse the case, the pairing failed coming with next pair
> >> > > procedure. Because at the last pair with CRSK notify, device type will
> >> > > be
> >> > > changed to LE, following is the failed scenario after last success with
> >> > > CRSK notify. Remote unpair and pair again.
> >> > >
> >> > > This reply is SPP, user confirm passkey reply. When pairing proceduce,
> >> > > User
> >> > > confirm the pairing request through bluetoothd, that will send mgmt op
> >> > > 'MGMT_OP_USER_CONFIRM_REPLY' with device address and device type in
> >> > > mgmt_cp_user_confirm_reply. Kernel use the device address and type to
> >> > > lookup hci conn. Unfortunately, it will lookup hci_conn from LE
> >> > > hashtable, that don't include hci conn. So spp reply couldn't send to
> >> > > remote, caused pair failed.
> >> > >
> >> > > > > At the same time kernel always uses them to lookup hci_conn in LE
> >> > > > > hashtable firstly, because addr type always marks as LE. Obviously
> >> > > > > it
> >> > > > > will failed with SMP over BR/EDR.
> >> > > >
> >> > > > I don't follow this either since there shouldn't have been any "reply"
> >> > > > from user space for SMP over BR/EDR. All there should be are events
> >> > > > from
> >> > > > the kernel for the generated LE keys.
> >> > > >
> >> > > > > Actually, SPM is only for LE in SPEC,
> >> > > >
> >> > > > That's not true. SMP is specified both for LE-U and ACL-U.
> >> > > >
> >> > > > > but kernel already support and use SMP over BR/EDR. if BR/EDR
> >> > > > > exchanges key with SMP, it will never reply pairing response to
> >> > > > > remote, in other words it will be never paired, that is happened in
> >> > > > > our products.
> >> > > >
> >> > > > Szymon recently implemented SMP over BR/EDR for Zephyr and used
> >> > > > Linux/BlueZ as a reference for testing. He didn't report any issues
> >> > > > like
> >> > > > this. It might help if you could provide some logs (particularly
> >> > > > HCI/btmon but also from bluetoothd) to understand what's the actual
> >> > > > issue you're seeing.
> >> > > >
> >> > > > Johan
> >> > >
> >> > > Sorry to confuse this issue, the log is not in my hand right now,
> >> > > so it maybe later.
> >> >
> >> > So I was able to reproduce this issue. This is bluetoothd bug and not
> >> > kernel one. This bug is no specific to cross-transport pairing. It can
> >> > happen with any dual-mode device that is doing BR/EDR pairing while being
> >> > known as dual mode by bluetoothd when agent replies with passkey or
> >> > confirmation.
> >> >
> >> > To fix this we probably need to hold extra information in
> >> > 'struct authentication_req' in device.c about type of pairing (LE or
> >> > BR/EDR). This is not a one-liner-fix so I don't have a patch ready yet.
> >>
> >> Totally agree with you about dual-mode device pairing known as dual mode.
> >> But i want to known is that reasonable about device is to do BR/EDR pairing
> >> will generate CRSK notify? I'm very intersting about this fixing, this bug
> >> is hight priority in our product. In my opinion hold extra informatin in
> >> 'struct authentication_req' may not fix this bug. Because if CRSK event is
> >> still report, then bluetoothd will change the device type to LE even if we
> >> pair device that is scaned with BR/EDR. So i think the rootcase is find
> >> does CRSK event make sense in BR/EDR pairing, and how to handle CRSK events
> >> in BR/EDR pairing if it make sense. I'm confuse with those.
> >
> > It doesn't change the device to LE but to dual mode device. This is
> > *cross-transport* pairing so keys for other transport are generated.
> > baddr_type specify only LE address type, not BR/EDR since there is no address
> > type for BR/EDR. This is mostly true but few places in bluetoothd seem to
> > asusme that for device supporting BR/EDR type is equal 0. Which is not true if
> > device is dual mode.
> >
> > You should be able to reproduce this bug with dual-mode devices that don't
> > support cross-transport pairing: enable advertising, scan from linux, when
> > device is found stop advertising and make device discoverable over BR/EDR
> > (inquiry). When device is found over BR/EDR stop scanning and start pairing.
> >
> >>
> >> I noticed that if quikly reply the passkey confirm, this bug always be
> >> reproduced, but if wait for 2~3s to reply the passkey confirm, it works
> >> well every time. In terms of code, wait for 2~3s will cause l2cap chan
> >> timeout for info timer that created by HCI_EV_REMOTE_EXT_FEATURES event,
> >> and timeout will change l2cap chan to BT_CONNECTED. So next SMP
> >> resume/ready don't distribute key also CRSK events.
> >>
> >> It can't reproduce with btmgmt, because it reply passkey confirm always only
> >> use BR/EDR in 'struct mgmt_cp_user_confirm_reply' not use device relation
> >> type.
> >>
> >> bluetoothd.log and btmon.log are attached. It records two pair request
> >> sequence, one is pair success that have CRSK event, another is next pair
> >> reqeust don't success any, hope those maybe help you to annlyze this bug.
> 
> I've sent a patch "[RFC] core: Fix BR/EDR pairing for dual mode devices".
> Please check if this solves issue you are seeing.
> 

Thanks for your patch. Maybe it can resolve the issue, but it will cause other
issues. For example, some operations also use device->bdaddr as parameter in
MGMT operations, unpair is the same. If kernel hold the device as BR/EDR type
in hdev->conn_hash, unpair operator won't find the hci conn, so it couldn't
terminal the link. but the link is exist at the moment. MGMT also complete
when don't terminal the link. So bluetoothd and the user don't feel the
different. But is that we would like? The code implies we should terminate the
connection if it is exist.

The patch use auth_req with BDADDR_BREDR to handle pairing request. It could
resolve the pairing procedure. But kernel hold the device as BR/EDR, even if
cross-tranport is generated on BR/EDR hci conn. Meanwhile bluetoothd will set
device->bdaddr_type to BDADDR_LE_PUBLIC with new_csrk_callback that generated
by cross-transport. I mean, the user-space hold the device with BDADDR_LE_PUBLIC
(yes, device->bredr and device->le are true, but addr-type is BDADDR_LE_PUBLIC),
the kernel hold the device with BDADDR_BREDR. Whenever user-space use couple
{addr, addr-type} to send request to kernel. It maybe failed.

As the end. In my case, i don't do the steps you mentioned(enable advertising,
scan from linux, stop advertising). I only start BR/EDR discovering with discovery
filter, pair device and unpair device to reproduce this bug. I don't start/stop
LE advertising.

> -- 
> pozdrawiam
> Szymon K. Janc
