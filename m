Return-Path: <cyrus@holtmann.org>
Date: Mon, 15 Nov 2010 17:17:39 +0200
From: Ville Tervo <ville.tervo@nokia.com>
To: "ext tim.howes@accenture.com" <tim.howes@accenture.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] Interface to set LE connection parameters
Message-ID: <20101115151739.GD16464@null>
References: <20101115120632.GB16464@null>
 <1AFE20D16950C745A2A83986B72E8748011F571E6CE6@EMEXM3131.dir.svc.accenture.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1AFE20D16950C745A2A83986B72E8748011F571E6CE6@EMEXM3131.dir.svc.accenture.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tim,

Please stop top posting on this ml.

On Mon, Nov 15, 2010 at 03:24:29PM +0100, ext tim.howes@accenture.com wrote:
> Hi Ville,
> 
> As you note the different profiles would likely have different connection parameters.  The different profiles may be running on the same LE link (indeed the same L2CAP [fixed] channel).
> 

I guess the latency should override power requirements. Low power profile can
operate on low latency link but low latency profile fails on high latency. Of
course this gets much more complicated if there are more requirements.

Are these (latency and power) the only characteristics we need to deal with.
There might be some also. I'm not too familiar with profile drafts.

> Do you have a view on how the different profiles - on the same link - would have different requests arbitrated, and where that arbitration would be done?  I'd imagine that the API towards the profiles should be of the abstract form - such as you mention (eg BT_LE_LOW_LAT).  This would make it easier to arbitrate the different requests, as compared to if the profiles see an API of the "numerical" form (eg interval = N ms).  I guess the arbitration could happen in user or kernel space; as long as there is something with singleton-like semantics to do it.
> 

I think I need to get more details from profile specs and try to find out the
requirements from them.

Right now I'm trying to find out what would be the right interface from kernel
to user space. 

> Also - a quick observation: yes, the connection parameters are only for LE links; however they have some semantic similarity with sniff mode in BR. Especially in the abstract form ("Low Latency" verus "Low Power").  Does BlueZ present an API like this already for BR (I'm new to BlueZ...I was more of a Symbian guy ;)?  If not it might be worth having one API for both BR/Sniff and LE/Connection Parameters - and do the appropriate mapping "under the hood".  

Actually this has been discussed earlier and we need also some api to change
sniff behaviour. Reason for this is broken devices which does not turn on
normal mode when low latency is needed. I guess Jaikumar had some patches
regarding this?

-- 
Ville
