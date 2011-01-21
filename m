Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Jan 2011 17:31:30 +0000
From: Joel Becker <jlbec@evilplan.org>
To: Jesper Juhl <jj@chaosbits.net>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org,
	alsa-devel@alsa-project.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, ocfs2-devel@oss.oracle.com,
	linux-edac@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	oprofile-list@lists.sf.net, Andi Kleen <ak@linux.intel.com>,
	David Teigland <teigland@redhat.com>,
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
	Mark Fasheh <mfasheh@suse.com>,
	Mauro Carvalho Chehab <mchehab@redhat.com>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>,
	Marcel Holtmann <marcel@holtmann.org>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Robert Richter <robert.richter@amd.com>
Subject: Re: [Patch] Kill off =?utf-8?Q?warning=3A_?=
 =?utf-8?B?4oCYaW5saW5l4oCZ?= is not at beginning of declaration
Message-ID: <20110121173130.GD8323@ZenIV.linux.org.uk>
References: <alpine.LNX.2.00.1101170000270.13377@swampdragon.chaosbits.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.LNX.2.00.1101170000270.13377@swampdragon.chaosbits.net>
Sender: Joel Becker <jlbec@ftp.linux.org.uk>
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 17, 2011 at 12:09:38AM +0100, Jesper Juhl wrote:
> Fix a bunch of 
> 	warning: ‘inline’ is not at beginning of declaration
> messages when building a 'make allyesconfig' kernel with -Wextra.
> 
> These warnings are trivial to kill, yet rather annoying when building with 
> -Wextra.
> The more we can cut down on pointless crap like this the better (IMHO).
> 
> A previous patch to do this for a 'allnoconfig' build has already been 
> merged. This just takes the cleanup a little further.
> 
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>

Acked for fs/ocfs2

Joel

-- 
