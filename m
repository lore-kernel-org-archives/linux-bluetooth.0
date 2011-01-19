Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Jan 2011 16:45:12 +0100 (CET)
From: Jesper Juhl <jj@chaosbits.net>
To: Jiri Kosina <jkosina@suse.cz>
cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
    linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
    ocfs2-devel@oss.oracle.com, linux-edac@vger.kernel.org,
    linux-bluetooth@vger.kernel.org, oprofile-list@lists.sf.net,
    Andi Kleen <ak@linux.intel.com>, David Teigland <teigland@redhat.com>,
    Jens Axboe <jens.axboe@oracle.com>,
    Stephen Hemminger <shemminger@vyatta.com>,
    Greg Kroah-Hartman <gregkh@suse.de>, Takashi Iwai <tiwai@suse.de>,
    Jaroslav Kysela <perex@perex.cz>,
    "John W. Linville" <linville@tuxdriver.com>,
    Johannes Berg <johannes@sipsolutions.net>,
    Patrick McHardy <kaber@trash.net>,
    Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
    James Morris <jmorris@namei.org>,
    "Pekka Savola (ipv6)" <pekkas@netcore.fi>,
    Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
    "David S. Miller" <davem@davemloft.net>,
    Frederic Weisbecker <fweisbec@gmail.com>,
    Frederic Weisbecker <fweisbec@gmail.com>, Joel Becker <jlbec@evilplan.org>,
    Mark Fasheh <mfasheh@suse.com>, Mauro Carvalho Chehab <mchehab@redhat.com>,
    "Gustavo F. Padovan" <padovan@profusion.mobi>,
    Marcel Holtmann <marcel@holtmann.org>, x86@kernel.org,
    "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
    Thomas Gleixner <tglx@linutronix.de>,
    Robert Richter <robert.richter@amd.com>
Subject: =?ISO-8859-7?Q?Re=3A_=5BPatch=5D_Kill_off_warning=3A_=A1inline=A2_is_not_at_beginning_of_declaration?=
In-Reply-To: <alpine.LNX.2.00.1101191543110.26685@pobox.suse.cz>
Message-ID: <alpine.LNX.2.00.1101191643070.15798@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1101170000270.13377@swampdragon.chaosbits.net> <alpine.LNX.2.00.1101191543110.26685@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-969819006-1295451912=:15798"
List-ID: <linux-bluetooth.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-969819006-1295451912=:15798
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT

On Wed, 19 Jan 2011, Jiri Kosina wrote:

> On Mon, 17 Jan 2011, Jesper Juhl wrote:
> 
> > Fix a bunch of 
> > 	warning: ¡inline¢ is not at beginning of declaration
> > messages when building a 'make allyesconfig' kernel with -Wextra.
> > 
> > These warnings are trivial to kill, yet rather annoying when building with 
> > -Wextra.
> > The more we can cut down on pointless crap like this the better (IMHO).
> > 
> > A previous patch to do this for a 'allnoconfig' build has already been 
> > merged. This just takes the cleanup a little further.
> > 
> > Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> > ---
> >  arch/x86/oprofile/op_model_p4.c |    2 +-
> >  drivers/bluetooth/btusb.c       |    4 ++--
> >  drivers/cpuidle/sysfs.c         |    2 +-
> >  drivers/edac/i7300_edac.c       |    2 +-
> >  fs/ocfs2/dir.c                  |    2 +-
> >  kernel/trace/ring_buffer.c      |    2 +-
> >  net/ipv6/inet6_hashtables.c     |    2 +-
> >  net/mac80211/tx.c               |    2 +-
> >  sound/pci/au88x0/au88x0.h       |    4 ++--
> >  sound/pci/au88x0/au88x0_core.c  |    4 ++--
> >  10 files changed, 13 insertions(+), 13 deletions(-)
> > 
>
> Wow, what a huge CC list for such a simple change. Jesper, I think you 
> should re-consider this next time. I bet you used get_maintainer script, 
> didn't you? :)
> 

Yes, I did. I wanted to be sure that everyone whoes code I was modifying 
got the mail. I guess I should have broken it up into smaller pieces and 
submitted them as a series instead.


> I have applied it to my tree now. If anyone has objections/has already 
> applied part of the patch to subsystem tree, please let me know.
> 

Thank you.

-- 
Jesper Juhl <jj@chaosbits.net>            http://www.chaosbits.net/
Don't top-post http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please.

--8323328-969819006-1295451912=:15798--
