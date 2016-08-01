Return-Path: <linux-wpan-owner@vger.kernel.org>
Subject: Re: [PATCH linux-wpan/radvd 6lowpan] device-linux: detect 6LoWPAN
 lltype for hwaddr length
References: <20160621144250.31650-1-aar@pengutronix.de>
 <21cdff8b-9994-63ec-a9c8-6691b5820302@pengutronix.de>
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de,
	patrik.flykt@linux.intel.com, jukka.rissanen@linux.intel.com
From: Alexander Aring <aar@pengutronix.de>
To: linux-wpan@vger.kernel.org
Message-ID: <ccc16ce0-8f7e-5e4a-5cd6-fe1ba1e3a30d@pengutronix.de>
Date: Mon, 1 Aug 2016 16:07:15 +0200
MIME-Version: 1.0
In-Reply-To: <21cdff8b-9994-63ec-a9c8-6691b5820302@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi,

On 07/28/2016 02:20 PM, Alexander Aring wrote:
> Hi,
> 
> On 06/21/2016 04:42 PM, Alexander Aring wrote:
...
> 
> I think to solve this issue, the best way currently is to evaluate:
> 
> /sys/class/net/$IFNAME/addr_len
> 
> which directly told us the dev->addr_len attribute in kernel. The only
> thing that it could be that CONFIG_SYSFS isn't compiled. On 802.15.4 we
> need to have SYSFS because iwpan and phy enumaration [0].
> 
> This solution should make radvd working with current mainline version
> which does dev->addr_len == 8 and also with the version when we change
> addr_len to 6.

this doesn't work because the kernel stuff will put the device address
with U/L bitflip inside the address option. radvd will never do that
because this should never be the case...

Setting the U/L bit in radvd is a crazy behaviour inside the radvd code for
support bug compatible version of btle 6lowpan.

I currently try to catch all suggestions from the bluetooth 6lowpan
rework RFC and making a next round. Then maybe we can finding more
"issues" about using right dev->addr etc. :-)

Also I want to sent some RFC to fix radvd in upstream for 6LoWPAN.

- Alex
