Return-Path: <cyrus@holtmann.org>
Subject: Re: RFC: btusb firmware load help
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <lrodriguez@atheros.com>
Cc: Marcel Holtmann <holtmann@linux.intel.com>,
	Luis Rodriguez <Luis.Rodriguez@Atheros.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	Deepak Dhamdhere <Deepak.Dhamdhere@Atheros.com>,
	Sree Durbha <Sree.Durbha@Atheros.com>
In-Reply-To: <20101006173949.GG7070@tux>
References: <20100924230730.GB6566@tux> <1286266981.17473.33.camel@aeonflux>
	 <20101005192814.GB11831@tux> <1286308731.2588.13.camel@aeonflux>
	 <AANLkTimz7U52_qHaTutQDOFQde+GrWJRA0WpqY__FPgi@mail.gmail.com>
	 <1286349552.6145.11.camel@aeonflux>
	 <AANLkTimDvgFtoGLEjgWyYRrhQy6Num-rn_2WYO4Lf84b@mail.gmail.com>
	 <1286380566.6145.42.camel@aeonflux> <20101006163816.GE7070@tux>
	 <AANLkTik9w4_PdcEsbRHakLcxcD334_1Q8hGArxTXPCGF@mail.gmail.com>
	 <20101006173949.GG7070@tux>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 06 Oct 2010 19:54:20 +0200
Message-ID: <1286387660.3655.382.camel@jlt3.sipsolutions.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2010-10-06 at 10:39 -0700, Luis R. Rodriguez wrote:


> > With sflash based AR3011 hardware, when we connect the device to USB
> > port it gets detected as a Bluetooth device because of firmware in
> > Flash (VID=0x0CF3, PID=0x3002). This triggers the Bluetooth sub
> > system driver (btusb.ko) directly in the host instead of ath3k
> > DFU driver. Therefore, there is no firmware downloaded in to the
> > RAM to bring up Bluetooth at this point. This is the problem
> > we're trying to "fix".

So the easiest fix for this would be to
 a) ignore 0x0cf3,0x3002 in btusb
 b) add it to ath3k firmware loading
 c) change the ath3k firmware to load with 0x0cf3,0x3003 (or whatever
    else you want, as long as it's not 0x3000 and not 0x3002)

Then the ignore in btusb won't affect ath3k after that new firmware was
loaded.

johannes

