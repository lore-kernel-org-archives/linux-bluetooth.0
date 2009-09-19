Return-Path: <cyrus@holtmann.org>
Subject: Re: can we disable/enable eSCO by using setsockopt of sco socket?
From: Marcel Holtmann <marcel@holtmann.org>
To: Peter Hurley <phurley@charter.net>
Cc: Lan Zhu <zhu.lan.cn@gmail.com>, linux-bluetooth@vger.kernel.org
In-Reply-To: <4AB3B1BF.107@charter.net>
References: <113d36d80909140452jb808a2bub393aae7307c7450@mail.gmail.com>
	 <1252935154.3421.17.camel@localhost.localdomain>
	 <113d36d80909140829g74828077tfd1a56348abcc916@mail.gmail.com>
	 <113d36d80909180347g59ac5444ta70e17c7eb3cb86e@mail.gmail.com>
	 <1253287883.28416.30.camel@localhost.localdomain>
	 <4AB3B1BF.107@charter.net>
Content-Type: text/plain
Date: Fri, 18 Sep 2009 22:50:49 -0700
Message-Id: <1253339449.28416.34.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

> >> We did some investigation on Mecel Bluetooth stack and Qualcomm's,
> >> they both provide the upper layer with the option to specify SCO type
> >> or eSCO type when creating synchronous connection. There are plenty of
> >> different Bluetooth devices in the world, compatiblility with them is
> >> usually a big issue for one Bluetooth product. So the rubestness will
> >> be a very important target for a product. Sometimes the Bluetooth
> >> developer need enough flexibility to handle many specific cases,
> >> because that can not be totally dealt with
> >> in stack layer. Actually Bluez already has an excellent architecture,
> >> but still a little weak in the rubestness. Then, why not give the
> >> developer more flexibility to deal with some problems?
> >>     
> >
> > BlueZ is not weak in robustness. Do me a favor and get your English
> > right here and do not spread FUD. You are saying that it is important to
> > work around some total broken eSCO capable chip to be robust. I do
> > question that statement. It is nice to have good interoperability with
> > broken devices, but there is a limit of broken devices we can support.
> >
> > And the userspace option to select between SCO and eSCO is just stupid
> > since you just start hacking some blacklist non-sense into the code that
> > becomes a big magic blob that nobody can track or understand.
> >
> > The way forward here is to analyze the headset and see what information
> > it gives us to determine that eSCO might not be working good enough. So
> > I want output from hcitool info and detailed hcidump.
> >
> There are device incompatibilities with eSCO.  I recently posted a 
> report here ("Odd eSCO behavior with BCM2045-based receiver") that 
> explains that (in that case) an eSCO connection *should not even be 
> tried* (much less retried).  In the case I provided, the controller's 
> link manager dumps all other connections and becomes unresponsive after 
> a --successful-- eSCO link is established.

that is a bug in your local controller. That is different from a broken
remote controller.

> Maybe one could argue that supporting a "broken device" is too much to 
> ask but, IMO, the BCM2045 is too common to avoid.  The reality is that 
> any code that directly supports hardware needs to account for situations 
> that reflect what actually happens, rather than what the spec describes 
> (again, IMO).
> 
> I feel this situation especially applies to Bluetooth.  Because of the 
> evolving complexities of Bluetooth (1300 page core spec with countless 
> sub-specs on its 3rd major evolution), there are bound to be plenty of 
> special cases that will continue to emerge.  Presumably your implicit 
> understanding of this is what prompted adding the "disable_esco" module 
> parameter to the sco driver.  At some point, special casing becomes 
> necessary -- so the real decision is what form that support will take.

The reason behind disable_esco is 1) to accommodate controllers that
tell that they support eSCO, but they are bluntly lying to you. So that
way can either replace them or use this option.

The second reason and more important one is that we need this for
testing and from qualification corner cases. We also have disable_cfc
for RFCOMM example and some crazy BNEP options. They are needed for
reasons that have nothing with this problem at hand. Which is that the
remote device is messed up.

Regards

Marcel


