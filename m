Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Jun 2011 12:43:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: Re: [PATCH] adaptername: Move adapter naming into a plugin
Message-ID: <20110614094338.GA18317@dell.ger.corp.intel.com>
References: <BANLkTind9qu33viRE+eSB6b7SiGhr_DTLQ@mail.gmail.com>
 <1307554688-21555-1-git-send-email-hadess@hadess.net>
 <20110614080730.GC28890@dell.ger.corp.intel.com>
 <1308043116.26522.1.camel@air.hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308043116.26522.1.camel@air.hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Tue, Jun 14, 2011, Bastien Nocera wrote:
> On Tue, 2011-06-14 at 11:07 +0300, Johan Hedberg wrote:
> > Hi Bastien,
> <snip>
> > This could simply be:
> > 
> > 	if (adapter->up)
> > 		return adapter_ops->set_name(adapter->dev_id, name);
> > 
> > 	return 0;
> > 
> > Other than that I didn't find any major issues, however please consider
> > the suggestion from Lizardo to split the patch in two parts.
> 
> I already sent the split patches (2 of them) last week:
> http://thread.gmane.org/gmane.linux.bluez.kernel/13621

No, I did notice that thread. It's not a split of this patch. For one
thing it doesn't contain any adaptername plugin at all.

What about the coding style issues I pointed out?

I also need to look more carefully into the name_stored change. I'm not
sure you completely understood its significance. This is also a change
which doesn't exist in your original patch (again confirming that the
new thread is *not* a split of the original patch).

Johan
