Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] adaptername: Move adapter naming into a plugin
From: Bastien Nocera <hadess@hadess.net>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Date: Wed, 15 Jun 2011 11:18:51 +0100
In-Reply-To: <20110614094338.GA18317@dell.ger.corp.intel.com>
References: <BANLkTind9qu33viRE+eSB6b7SiGhr_DTLQ@mail.gmail.com>
	 <1307554688-21555-1-git-send-email-hadess@hadess.net>
	 <20110614080730.GC28890@dell.ger.corp.intel.com>
	 <1308043116.26522.1.camel@air.hadess.net>
	 <20110614094338.GA18317@dell.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1308133135.9190.11.camel@air.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2011-06-14 at 12:43 +0300, Johan Hedberg wrote:
> Hi Bastien,
> 
> On Tue, Jun 14, 2011, Bastien Nocera wrote:
> > On Tue, 2011-06-14 at 11:07 +0300, Johan Hedberg wrote:
> > > Hi Bastien,
> > <snip>
> > > This could simply be:
> > > 
> > > 	if (adapter->up)
> > > 		return adapter_ops->set_name(adapter->dev_id, name);
> > > 
> > > 	return 0;
> > > 
> > > Other than that I didn't find any major issues, however please consider
> > > the suggestion from Lizardo to split the patch in two parts.
> > 
> > I already sent the split patches (2 of them) last week:
> > http://thread.gmane.org/gmane.linux.bluez.kernel/13621
> 
> No, I did notice that thread. It's not a split of this patch. For one
> thing it doesn't contain any adaptername plugin at all.

I know. I mentioned on IRC that I would work on the adaptername plugin
once those 2 patches went in. I'm getting a little bit sick of spinning
patches that get reviewed when I don't have time. A month to get patches
into bluez isn't my idea of fun.

> What about the coding style issues I pointed out?
> 
> I also need to look more carefully into the name_stored change. I'm not
> sure you completely understood its significance.

The significance is to avoid writing the adapter name to disk when it
hasn't changed. Given that we only ever write the adapter name to disk
in one location, and we check whether it's been changed, then the
variable is useless.

>  This is also a change
> which doesn't exist in your original patch (again confirming that the
> new thread is *not* a split of the original patch).

I *obviously* can't split the original patch in 2 patches and keep the
code working. Lizardo wanted the simplification of the name setting and
the adaptername plugin patch to be separate so that we could potentially
bisect regressions.

Feel free to discuss it between yourselves.

