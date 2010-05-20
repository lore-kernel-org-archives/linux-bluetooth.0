Return-Path: <cyrus@holtmann.org>
Subject: Re: + btusb-patch-add_apple_macbookpro62.patch added to -mm tree
From: Marcel Holtmann <marcel@holtmann.org>
To: Bernhard Froemel <froemel@vmars.tuwien.ac.at>
Cc: akpm@linux-foundation.org, mm-commits@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <4BF50114.2000108@vmars.tuwien.ac.at>
References: <201005191906.o4JJ6ktf030453@imap1.linux-foundation.org>
	 <1274303130.26613.517.camel@localhost.localdomain>
	 <4BF45CB5.4050504@vmars.tuwien.ac.at>
	 <1274338372.27220.4.camel@localhost.localdomain>
	 <4BF4E67B.3050900@vmars.tuwien.ac.at>
	 <1274344173.27220.7.camel@localhost.localdomain>
	 <4BF50114.2000108@vmars.tuwien.ac.at>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 20 May 2010 17:50:23 +0200
Message-ID: <1274370623.27220.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bernhard,

> >>    usbfs disappears on recent kernels [1], at least for desktop machines
> >> (and most certainly on my stock distribution). Don't want to be contra
> >> productive here, but if you insist on this "proof" (i.e. don't accept
> >> the output of the above lsusb command or my forum discussion reference
> >> [2] as proof enough) and want me to spend another hour compiling a
> >> kernel with enabled usbfs for such a small fix, then I'll pass on this
> >> one for now.
> >>      
> > just run the attached script. It does the same thing. Or you could just
> > mount usbfs.
> >    
> There is *no* usbfs available in my current kernel - I'd need to enable 
> and recompile: that's why I can't mount. Distribution vendors (like 
> Ubuntu) follow the recommendation concerning usbfs support in their 
> stock kernels (it's marked deprecated).
> 
> Your script does not work on devices attached to (internal) hubs - they 
> are silently omitted. I modified it accordingly and that's the output:
> > T:  Bus=1 Dev#=8 Spd=12 MxCh=0
> > D:  Ver=2.00 Cls=ff(vendr) Sub=01 Prot=01 MxPS=64 #Cfgs=1
> > P:  Vendor=05ac ProdID=8218 Rev=0.22
> > S:  Manufacturer=Apple Inc.
> > S:  Product=Bluetooth USB Host Controller
> > C:  #Ifs=4 Cfg#=1 Atr=e0 MxPwr=0mA
> > E:  Ad=00(both) Atr=00(Control) MxPS=0040 Ivl=0ms
> > I:  If#=00 Alt=0 #EPs=03 Cls=ff(vendr) Sub=01 Prot=01 Driver=btusb
> > I:  If#=01 Alt=0 #EPs=02 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> > I:  If#=02 Alt=0 #EPs=02 Cls=ff(vendr) Sub=ff Prot=ff Driver=(none)
> > I:  If#=03 Alt=0 #EPs=00 Cls=fe(apspe) Sub=01 Prot=01 Driver=(none)
> As visible here and in my previously quoted lsusb output the class isn't 
> set correctly (0xff instead of 0xe0), so the driver won't detect the 
> device. It does here, because - of course - I run the patched btusb module.
> When I remove my patched DKMS module (and use the stock module as 
> shipped in 2.6.32), the output is:
> > T:  Bus=1 Dev#=8 Spd=12 MxCh=0
> > D:  Ver=2.00 Cls=ff(vendr) Sub=01 Prot=01 MxPS=64 #Cfgs=1
> > P:  Vendor=05ac ProdID=8218 Rev=0.22
> > S:  Manufacturer=Apple Inc.
> > S:  Product=Bluetooth USB Host Controller
> > C:  #Ifs=4 Cfg#=1 Atr=e0 MxPwr=0mA
> > E:  Ad=00(both) Atr=00(Control) MxPS=0040 Ivl=0ms
> > I:  If#=00 Alt=0 #EPs=03 Cls=ff(vendr) Sub=01 Prot=01 Driver=(none)
> > I:  If#=01 Alt=0 #EPs=02 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> > I:  If#=02 Alt=0 #EPs=02 Cls=ff(vendr) Sub=ff Prot=ff Driver=(none)
> > I:  If#=03 Alt=0 #EPs=00 Cls=fe(apspe) Sub=01 Prot=01 Driver=(none)
> I hope you're finally convinced, so attached once more the patch (and CC 
> to linux-bluetooth).

this is really stupid from Apple. They must have been smoking something
nice when doing this change.

So what I need is a patch done with git format-patch that contains the
explanation why including the output from above.

Regards

Marcel


