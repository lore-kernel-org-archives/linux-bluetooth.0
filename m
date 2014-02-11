Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 Feb 2014 14:26:17 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: "Viswanatham, RaviTeja" <RaviTeja.Viswanatham.EDUCATION@eberspaecher.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>,
	bzhao@marvell.com
Subject: Re: Bluetooth with full AMP
Message-ID: <20140211122616.GF8980@aemeltch-MOBL1>
References: <9BC883E0D59F6B4DBD525D460025714B08AE363D@deessmx03.dees.eberspaecher.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9BC883E0D59F6B4DBD525D460025714B08AE363D@deessmx03.dees.eberspaecher.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Raviteja,

> On Mon, Feb 10, 2014 at 10:35:24AM -0800, Marcel Holtmann wrote:
> > Hi Ravi,
> > 
> > > I am working on Ubuntu 12.04 with a Bluetooth 3.0 +HS + wifi combo 
> > > USB dongle.
> > > 
> > > I want to reach a data transfer speed of up to 24 Mbit/s. 
> > > 
> > > My Questions: Does Bluez support high speed data transfer rates up 
> > > to
> > > 24 Mbit/s (Bluetooth 3.0+HS) ? 
> > > 
> > > If it does, is there any user configuration involved to achieve that?
> > > What other requirements need to be met?  Does, Bluetooth enables AMP 
> > > function to communicate 802.11n channel to support high speed or it 
> > > has to be configure with any other drivers?
> > > 
> > > I am new to Linux a detail explanation would be really appreciated.
> > > Thank you in advance for your support.
> > 
> > we do support Bluetooth HS operation. However your WiFi device needs 
> > to be exposed as AMP Controller. Most WiFi hardware needs a special 
> > driver to expose itself as AMP Controller. There is no generic driver
> > for mac80211 subsystem in the kernel.
> 
> Some devices have AMP Controller implemented in firmware.  I was using
> Marvell SD8787, probably newer Marvell devices also works.
> 
> You may check drivers/bluetooth/btmrvl_main.c to see how HCI dev_type
> HCI_AMP is assigned.
> 
> Thanks for replying me. I would like to know some more information about
> the Bluetooth dongle. As you said the Marvell SD8787 is kind of a SoC
> chipset. Is there any USB Bluetooth  device available in the market
> which supports out of the box.  

The only possibility I know is Marvell development board like:
http://avnetexpress.avnet.com/store/em/EMController/Development-Kits/Marvell/RD-88W-SD-8787-A0/_/R-10001817/A-10001817/An-0?action=part&catalogId=500201&langId=-1&storeId=500201


> I am running 3.11 kernel and I already
> build the Marvell option inside the kernel. 
> 
> Is there any dongles available in the market which supports full AMP. 

At least I couldn't find one. If you find it let us know ;)

> If
> not are there any other possibilities to fix the Marvell driver with the
> existing dongle. Please any hints as I am working on ARM board I need to
> fix the USB Bluetooth device which can transfer with high speed. 
> 

Try to contact Marvell and ask which one supports FullAMP.

Best regards 
Andrei Emeltchenko 
