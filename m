Return-Path: <cyrus@holtmann.org>
Message-ID: <1432168603.2474.20.camel@gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Support for QCA61x4 on Samsung
From: Chanyeol Park <chanyeol.park@gmail.com>
To: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
Cc: Chan-yeol Park <chanyeol.park@samsung.com>, Marcel Holtmann
	 <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, Kim@samsung.com
Date: Thu, 21 May 2015 09:36:43 +0900
In-Reply-To: <555CCA62.10809@qca.qualcomm.com>
References: <1432017670-6024-1-git-send-email-chanyeol.park@samsung.com>
	 <D5B20D85-8B5F-4694-8B5E-2BFC670BE85C@holtmann.org>
	 <555C7F93.9080901@samsung.com> <555C819A.40600@samsung.com>
	 <555CCA62.10809@qca.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,Ben Kim

On Wed, 2015-05-20 at 10:54 -0700, Ben Young Tae Kim wrote:
> Hi Chan-yeol,
> 
> On 05/20/15 05:44, Chan-yeol Park wrote:
> > Hi Marcel,
> > 
> > On 05/20/2015 09:35 PM, Chan-yeol Park wrote:
> > > Hi Marcel,
> > > On 05/20/2015 03:21 AM, Marcel Holtmann wrote:
> > > > 
> > > > Hi Chan-yeol,
> > > > > 
> > > > > The previous commit(3267c88) regressed QCA61x4 BT on Samsung 
> > > > > because its device info is missed in qca_devices_table[], so 
> > > > > btusb_open() return error unexpectedly.
> > > > 
> > > > how does this regress. We never had QCA module support in the 
> > > > first place. The patch looks good, I was just wondering what 
> > > > the regression will be here?
> > > My environment was virtual box on windows.
> > > I guess windows download QC firmware successfully, so without 
> > > firmware handling in the linux I could use bluetooth adapter.
> > > 
> I didn't realize ROME v2.0 was out to the market. Where did you get 
> this module? Does it built-in on your laptop?
Yes. It's built-in in my Samsung labtop bought on market.

> 
> Your patch looks good, however, I need your confirmation that it will 
> work on your board since I don't have ROME v2.0 HW. I'll send you 
> ROME v2.0 FW files for you and will upstream it to linux-firmware.git 
> if it works.
It works well. I test basic things such as searching, sdp, and pairing.
and they works fine.

Actually before I use your driver/firmware, my "hciconfig -a" shows
wrong address and hci 4.0. but thanks to your driver/firmware I could
get hci 4.1 and normal address.
>  
> > > Until now , I fail to find the exact firmware , 
> > > "qca/rampatch_usb_*.bin" for QCA61x4.
> > > I just saw the mail that Kyle McMartin reject firmware patches 
> > > made by Ben Young Tae Kim.
> > > Could you tell where I can get it?
> > > 
> > > Actually my wifi QCA61x4 does not work well..
> QCA61x4 WiFi will use 'ATH10k' driver. Did you enable this module 
> compiled on your kernel tree
No. I just use fedora 22, 4.0.3-300.fc22.x86_64. In case of wifi they
use PCI, so it's not easy to use it in guest os that use latest kernel
tree.

Also I search some mail thread for ath10k, it seems that firmware is
not added in linux-firmware until now.
> > > 
> > I am sending this mail again because previous mail is not sent to 
> > bluetooth-next due to HTML format.
> > 
> > Thanks
> > Chanyeol
> > 
> 
> Thanks
> -- Ben Kim
I appreciate your help a lot. I could use my Bluetooth on my labtop
from now on.

Thanks
Chanyeol
