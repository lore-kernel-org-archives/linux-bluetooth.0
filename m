Return-Path: <cyrus@holtmann.org>
Date: Mon, 29 Nov 2010 23:37:43 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: "ext tim.howes@accenture.com" <tim.howes@accenture.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] Interface to set LE connection parameters
Message-ID: <20101130013743.GC5919@vigoh>
References: <20101115120632.GB16464@null>
 <1AFE20D16950C745A2A83986B72E8748011F571E6CE6@EMEXM3131.dir.svc.accenture.com>
 <20101115151739.GD16464@null>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20101115151739.GD16464@null>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

* Ville Tervo <ville.tervo@nokia.com> [2010-11-15 17:17:39 +0200]:

> Hi Tim,
> 
> Please stop top posting on this ml.
> 
> On Mon, Nov 15, 2010 at 03:24:29PM +0100, ext tim.howes@accenture.com wrote:
> > Hi Ville,
> > 
> > As you note the different profiles would likely have different connection parameters.  The different profiles may be running on the same LE link (indeed the same L2CAP [fixed] channel).
> > 
> 
> I guess the latency should override power requirements. Low power profile can
> operate on low latency link but low latency profile fails on high latency. Of
> course this gets much more complicated if there are more requirements.
> 
> Are these (latency and power) the only characteristics we need to deal with.
> There might be some also. I'm not too familiar with profile drafts.
> 
> > Do you have a view on how the different profiles - on the same link - would have different requests arbitrated, and where that arbitration would be done?  I'd imagine that the API towards the profiles should be of the abstract form - such as you mention (eg BT_LE_LOW_LAT).  This would make it easier to arbitrate the different requests, as compared to if the profiles see an API of the "numerical" form (eg interval = N ms).  I guess the arbitration could happen in user or kernel space; as long as there is something with singleton-like semantics to do it.
> > 
> 
> I think I need to get more details from profile specs and try to find out the
> requirements from them.
> 
> Right now I'm trying to find out what would be the right interface from kernel
> to user space. 

If you go with the abstraction in userspace (inside bluetoothd) will be easy to
create usage profiles on top of it or even do a fine tune of the parameters
for a specific usage. New profiles should be created in the future and we
can't foresee its requirements. And I'm seeing that we will have many
many different use cases for LE in the future.  It can be hard to extend
the API if we do the abstraction in the kernel because we can't break
the API that we are going to create.

We also have to check if we really need all the parameters you are
proposing, maybe we can simplify that API. What about you send a e-mail
explaining why we should add each parameter to the API?

-- 
Gustavo F. Padovan
http://profusion.mobi
