Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <Mikel.Astiz@bmw-carit.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Mikel Astiz <mikel.astiz.oss@gmail.com>
Date: Thu, 12 Apr 2012 10:58:32 +0200
Subject: RE: [PATCH BlueZ v0 1/7] btio: Fix bind SCO socket only if server
Message-ID: <66BD268F973E3544A665E5F503FB38B71AFB7646BB@DC01.bmw-carit.intra>
References: <1334127438-27617-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1334127438-27617-2-git-send-email-mikel.astiz.oss@gmail.com>
	<CABBYNZJF8XSSdVH2PCB7aX2eNyrPq5Nfj7L5gGV-WMcXyUaPhg@mail.gmail.com>
 <CABBYNZ+So=kMMjN+ZkLB+gHnAy2EZGvhATbANSdfbpnWEMbQYQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+So=kMMjN+ZkLB+gHnAy2EZGvhATbANSdfbpnWEMbQYQ@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> 
> Hi Mikel,
> 
> On Wed, Apr 11, 2012 at 2:20 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > Hi Mikel,
> >
> > On Wed, Apr 11, 2012 at 9:57 AM, Mikel Astiz
> <mikel.astiz.oss@gmail.com> wrote:
> >> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> >>
> >> When the socket is open is client mode, the bind() system call
> should
> >> not be used.
> >> ---
> >>  btio/btio.c |    5 +++--
> >>  1 files changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/btio/btio.c b/btio/btio.c index 9781ec4..7564d85 100644
> >> --- a/btio/btio.c
> >> +++ b/btio/btio.c
> >> @@ -1317,8 +1317,9 @@ static GIOChannel *create_io(BtIOType type,
> >> gboolean server,
> >>                        ERROR_FAILED(err, "socket(SEQPACKET, SCO)",
> >> errno);
> >>                        return NULL;
> >>                }
> >> -               if (sco_bind(sock, &opts->src, err) < 0)
> >> -                       goto failed;
> >> +               if (server)
> >> +                       if (sco_bind(sock, &opts->src, err) < 0)
> >> +                               goto failed;
> >>                if (!sco_set(sock, opts->mtu, err))
> >>                        goto failed;
> >>                break;
> >> --
> >> 1.7.7.6
> >
> > Ack, in future send this kind of trivial/obvious fix in separated so
> > it can easily be picked.
> 
> Actually I take it back, the bind is necessary to set the adapter
> address otherwise you can't choose with which adapter you want to
> connect so it always use adapter any.
> 

Nice catch, it wasn't that simple after all.

If I understand this correctly, this means we need some kernel patches. Either (a) we add the source address in sockaddr_sco so we can drop the bind() call (because sco_sock_connect would already receive both addresses), or (b) we modify sco_sock_bind such that it doesn't complain with EADDRINUSE.

I don't have much experience with sockets but the second approach seems a workaround to me.

On the other hand, the first approach would need special care not to break existing userland code. However this doesn't seem very difficult.

Any other proposals?

Cheers,
Mikel

