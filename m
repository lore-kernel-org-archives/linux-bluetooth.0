Return-Path: <cyrus@holtmann.org>
From: <tim.howes@accenture.com>
To: <ville.tervo@nokia.com>
Cc: <linux-bluetooth@vger.kernel.org>
Date: Tue, 16 Nov 2010 10:56:22 +0100
Subject: RE: [RFC] Interface to set LE connection parameters
Message-ID: <1AFE20D16950C745A2A83986B72E8748011F571E6F06@EMEXM3131.dir.svc.accenture.com>
References: <20101115120632.GB16464@null> <1AFE20D16950C745A2A83986B72E8748011F571E6CE6@EMEXM3131.dir.svc.accenture.com> <20101115151739.GD16464@null>
In-Reply-To: <20101115151739.GD16464@null>
Content-Type: text/plain;
	charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ville,

> > As you note the different profiles would likely have different
> connection parameters.  The different profiles may be running on the
> same LE link (indeed the same L2CAP [fixed] channel).
> >
> 
> I guess the latency should override power requirements. Low power
> profile can
> operate on low latency link but low latency profile fails on high
> latency. Of
> course this gets much more complicated if there are more requirements.

Agreed.

> 
> Are these (latency and power) the only characteristics we need to deal
> with.
> There might be some also. I'm not too familiar with profile drafts.

I think these are the main issues; however I wonder whether link supervision timeout may conflict for different use cases.  Even if it is not the link supervision the lifetime of the physical link may differ between profiles (some may want the link up for a long time but send no data). Slightly off-topic; but still it raises issues around the type of API and the arbitration of different profile requirements on the same link.

> > Do you have a view on how the different profiles - on the same link -
> would have different requests arbitrated, and where that arbitration
> would be done?  I'd imagine that the API towards the profiles should be
> of the abstract form - such as you mention (eg BT_LE_LOW_LAT).  This
> would make it easier to arbitrate the different requests, as compared
> to if the profiles see an API of the "numerical" form (eg interval = N
> ms).  I guess the arbitration could happen in user or kernel space; as
> long as there is something with singleton-like semantics to do it.
> >
> 
> I think I need to get more details from profile specs and try to find
> out the
> requirements from them.

As an aside, it's not just the application profiles.  If you have a link to a device with high latency and need to do more service search using GATT then you might want to lower the latency temporarily.  This may impact the type of API control you give GATT applications versus any in-built GATT service discovery.

> Right now I'm trying to find out what would be the right interface from
> kernel
> to user space.
> 
> > Also - a quick observation: yes, the connection parameters are only
> for LE links; however they have some semantic similarity with sniff
> mode in BR. Especially in the abstract form ("Low Latency" verus "Low
> Power").  Does BlueZ present an API like this already for BR (I'm new
> to BlueZ...I was more of a Symbian guy ;)?  If not it might be worth
> having one API for both BR/Sniff and LE/Connection Parameters - and do
> the appropriate mapping "under the hood".
> 
> Actually this has been discussed earlier and we need also some api to
> change
> sniff behaviour. Reason for this is broken devices which does not turn
> on
> normal mode when low latency is needed. I guess Jaikumar had some
> patches
> regarding this?

I think it's a bit deeper than broken devices: the specifications offer no real way for devices to agree why a particular mode (eg active or sniff) is needed at a particular time.  This then gives interoperability problems because one side may decide it wants sniff mode; but the other does not know why.


Tim


This message is for the designated recipient only and may contain privileged, proprietary, or otherwise private information.  If you have received it in error, please notify the sender immediately and delete the original.  Any other use of the email by you is prohibited.
