Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Jun 2011 00:04:00 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: Re: [PATCH] adaptername: Move adapter naming into a plugin
Message-ID: <20110615210400.GA8352@dell.ger.corp.intel.com>
References: <BANLkTind9qu33viRE+eSB6b7SiGhr_DTLQ@mail.gmail.com>
 <1307554688-21555-1-git-send-email-hadess@hadess.net>
 <20110614080730.GC28890@dell.ger.corp.intel.com>
 <1308043116.26522.1.camel@air.hadess.net>
 <20110614094338.GA18317@dell.ger.corp.intel.com>
 <1308133135.9190.11.camel@air.hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308133135.9190.11.camel@air.hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Wed, Jun 15, 2011, Bastien Nocera wrote:
> > > I already sent the split patches (2 of them) last week:
> > > http://thread.gmane.org/gmane.linux.bluez.kernel/13621
> > 
> > No, I did notice that thread. It's not a split of this patch. For one
> > thing it doesn't contain any adaptername plugin at all.
> 
> I know. I mentioned on IRC that I would work on the adaptername plugin
> once those 2 patches went in. I'm getting a little bit sick of spinning
> patches that get reviewed when I don't have time. A month to get patches
> into bluez isn't my idea of fun.

I understand that and I'm sorry that the process has taken so long. I'm
mostly to blame, though a considerable part of the reason is that you're
not adding or touching some peripheral piece of code here but
fundamental core functionality that will inevitably take longer to
discuss and review compared other patches.

> > I also need to look more carefully into the name_stored change. I'm not
> > sure you completely understood its significance.
> 
> The significance is to avoid writing the adapter name to disk when it
> hasn't changed. Given that we only ever write the adapter name to disk
> in one location, and we check whether it's been changed, then the
> variable is useless.

Good. I just wanted to make sure that you're familiar with commit
eb3efee1 (that introduced this variable) and the use-case its commit
message describes, that you realize that a name write will trigger a
name read (in hciops) which in turn will trigger a new call to
adapter_update_local_name, and that part of all this is also to try to
support 3rd party name changers like hciconfig (not a very high priority
goal though).

> >  This is also a change
> > which doesn't exist in your original patch (again confirming that the
> > new thread is *not* a split of the original patch).
> 
> I *obviously* can't split the original patch in 2 patches and keep the
> code working. Lizardo wanted the simplification of the name setting and
> the adaptername plugin patch to be separate so that we could potentially
> bisect regressions.

I'll attribute it to your frustration with the tardiness of this process
that you don't seem to have the will or interest to understand what I
was trying to say. As Lizardo already clarified the proposed split was
about first moving the existing functionality/code to the new plugin and
then adding the prettyname support. The final outcome would then contain
the same functionality as the original patch and the code would "keep
working" at every step. Since neither of the new patches you sent
contained the adaptername plugin I concluded that it was something else
than the proposed split.

Btw, the get_default_adapter patch is now in so you can base the rest of
your patches on top of that.

Johan
