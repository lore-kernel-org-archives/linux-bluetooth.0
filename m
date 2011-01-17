Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Mon, 17 Jan 2011 14:13:59 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
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
	Joel Becker <jlbec@evilplan.org>, Mark Fasheh <mfasheh@suse.com>,
	Mauro Carvalho Chehab <mchehab@redhat.com>,
	Marcel Holtmann <marcel@holtmann.org>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Robert Richter <robert.richter@amd.com>
Subject: Re: [Patch] Kill off =?utf-8?Q?warning=3A_?=
 =?utf-8?B?4oCYaW5saW5l4oCZ?= is not at beginning of declaration
Message-ID: <20110117161359.GA2885@vigoh>
References: <alpine.LNX.2.00.1101170000270.13377@swampdragon.chaosbits.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.LNX.2.00.1101170000270.13377@swampdragon.chaosbits.net>
List-ID: <linux-bluetooth.vger.kernel.org>

* Jesper Juhl <jj@chaosbits.net> [2011-01-17 00:09:38 +0100]:

> Fix a bunch of=20
> 	warning: =E2=80=98inline=E2=80=99 is not at beginning of declaration
> messages when building a 'make allyesconfig' kernel with -Wextra.
>=20
> These warnings are trivial to kill, yet rather annoying when building wit=
h=20
> -Wextra.
> The more we can cut down on pointless crap like this the better (IMHO).
>=20
> A previous patch to do this for a 'allnoconfig' build has already been=20
> merged. This just takes the cleanup a little further.
>=20
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> ---
>  arch/x86/oprofile/op_model_p4.c |    2 +-
>  drivers/bluetooth/btusb.c       |    4 ++--
>  drivers/cpuidle/sysfs.c         |    2 +-
>  drivers/edac/i7300_edac.c       |    2 +-
>  fs/ocfs2/dir.c                  |    2 +-
>  kernel/trace/ring_buffer.c      |    2 +-
>  net/ipv6/inet6_hashtables.c     |    2 +-
>  net/mac80211/tx.c               |    2 +-
>  sound/pci/au88x0/au88x0.h       |    4 ++--
>  sound/pci/au88x0/au88x0_core.c  |    4 ++--
>  10 files changed, 13 insertions(+), 13 deletions(-)

For drivers/bluetooth

Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

--=20
Gustavo F. Padovan
http://profusion.mobi
