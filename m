Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 Feb 2014 09:13:22 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Viswanatham, RaviTeja" <RaviTeja.Viswanatham.EDUCATION@eberspaecher.com>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>
Subject: Re: 
Message-ID: <20140211071321.GB8980@aemeltch-MOBL1>
References: <9BC883E0D59F6B4DBD525D460025714B08AE336F@deessmx03.dees.eberspaecher.com>
 <BE8107B5-0F83-47C5-ADC6-345CFD24BE21@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BE8107B5-0F83-47C5-ADC6-345CFD24BE21@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

On Mon, Feb 10, 2014 at 10:35:24AM -0800, Marcel Holtmann wrote:
> Hi Ravi,
> 
> > I am working on Ubuntu 12.04 with a Bluetooth 3.0 +HS + wifi combo USB
> > dongle. 
> > 
> > I want to reach a data transfer speed of up to 24 Mbit/s. 
> > 
> > My Questions: Does Bluez support high speed data transfer rates up to
> > 24 Mbit/s (Bluetooth 3.0+HS) ? 
> > 
> > If it does, is there any user configuration involved to achieve that?
> > What other requirements need to be met?  Does, Bluetooth enables AMP
> > function to communicate 802.11n channel to support high speed or it
> > has to be configure with any other drivers? 
> > 
> > I am new to Linux a detail explanation would be really appreciated.
> > Thank you in advance for your support.
> 
> we do support Bluetooth HS operation. However your WiFi device needs to
> be exposed as AMP Controller. Most WiFi hardware needs a special driver
> to expose itself as AMP Controller. There is no generic driver for
> mac80211 subsystem in the kernel.

Some devices have AMP Controller implemented in firmware.
I was using Marvell SD8787, probably newer Marvell devices also works.

You may check drivers/bluetooth/btmrvl_main.c to see how HCI dev_type
HCI_AMP is assigned.

Best regards 
Andrei Emeltchenko 
